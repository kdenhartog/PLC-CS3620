open Ast;;
open Intmap;;
open Parsing_trs;;
open Sccs;;
open Tree;;
open Trie;;
open Uf;;
open Util;;

let dbg_gen_aut = ref false;;
let dbg_gen_aut_micro = ref false;;

(* an nfa is a nondeterministic Moore machine
  (sm,next,eps), where:

   -- sm is a symmap (see parsing_trs.ml)
   -- next is the labeled part of the transition relation. 
      If next.(x) = Some(a,y), then this means that from state x on
      symbol (number) a, the nfa can transition to state y. 
   -- eps is the unlabeled part of the transition relation.
      eps.(x) = [ y1 ; ... ; yn ] means that from state x,
      the nfa can epsilon-transition to the states
      y1 through yn

   A few special notes:

   -- the start state is state 0
   -- the final state is state 1
*)

type nfa = symmap * (int * int) option array * int list array
let start_state = 0;;
let final_state = 1;;
let first_ordinary_state = 2;;

let print_nfa (os : string -> unit) (name:string) (aut:nfa) : unit =
  let ((tbl,revtbl),next,eps) = aut in
  let os_state s = os (string_of_int s) in

  os "(Nfa ";
  os name;
  os ":\n(Num states: ";
  os (string_of_int (Array.length next));
  os ")\n(Symbol table:\n";
  trie_print os (fun i -> os (string_of_int i)) tbl;
  os ")\n(Labeled edges:\n";
  Array.iteri
    (fun s edge -> 
      match edge with
	None -> ()
      | Some(symnum,s') ->
	 os_state s;
	 os " -- ";
	 os revtbl.(symnum);
	 os " --> ";
	 os_state s';
	 os "\n")
    next;
  os ")\n(Epsilon edges:\n";
  Array.iteri
    (fun s ss -> 
      if nonempty ss then
	(os_state s;
	 os " -->";
	 let first = ref true in
	 List.iter
	   (fun s' -> 
	     if !first then
	       first := false
	     else
	       os ",";
	     os " ";
	     os_state s')
	   ss;
	 os "\n"))
    eps;

  os "))\n"
;;

let print_nfa_dot (os:string -> unit) (name:string) (aut : nfa) : unit =
  let ((tbl,revtbl),next,eps) = aut in
  let os_state s = os "s"; os (string_of_int s) in
  let os_state_decl s = 
    os_state s; 
    os " [label = \""; 
    os (string_of_int s);
    os "\"];\n" in
    os "digraph ";
    os name;
    os " {\n";
    os "rankdir = LR;\n";
    os "hidden [shape = plaintext, label = \"\"];\n";
    os "node [shape = doublecircle];\n";
    os_state_decl final_state;
    os "node [shape = circle];\n";
    for i = 0 to (Array.length next) - 1 do
      os_state_decl i
    done;

    os "hidden -> ";
    os_state start_state;
    os "\n\n";

    Array.iteri
      (fun s e -> 
	 match e with
	     None -> ()
	   | Some(symnum,s') ->
	       os_state s;
	       os " -> ";
	       os_state s';
	       os " [label = \"";
	       os revtbl.(symnum);
	       os "\"];\n")
      next;

    Array.iteri
      (fun s ss -> 
	 List.iter
	   (fun s' ->
	      os_state s;
	      os " -> ";
	      os_state s';
	      os ";\n")
	   ss)
      eps;

    os "}\n"
;;

let write_nfa_dot (name:string) (aut:nfa) : unit =
  let o = open_out (name^".gv") in
  let os = output_string o in
    print_nfa_dot os name aut;
    close_out o;;

type autinfo = 
    Edge of int * string * int
  | Epsilon of int * int
;;

(* we assume that if a state has an outgoing epsilon-transition, then it has no outgoing labeled transition. *)
let nfa_from_autinfo(num_states:int)(sm : symmap)(info : autinfo list) : nfa =
  let dbg = debugger dbg_gen_aut_micro in
  wr dbg "(Beginning creation of nfa from edge descriptions.\n";
  let (symtrie,revsymtrie) = sm in
  let symnum e = match trie_lookup symtrie e with None -> err ("Internal error in nfa_from_autinfo, on symbol " ^ e) | Some(s) -> s in
      (* now create the transition relation *)

      let next = Array.make num_states None in
      let eps = Array.make num_states [] in

	wr dbg "(Creating next and eps.\n";

	List.iter
	  (fun e -> 
	     match e with
		 Epsilon(st,st')  -> 
		   eps.(st) <- st'::eps.(st);
	       | Edge(st,sym,st') -> 
		   if next.(st) <> None then
		     (* we have already added a labeled transition from this state -- that should not happen *)
		     err "Internal error in create_nfa: two labeled transitions are leaving the same state (should not happen).";
		   next.(st) <- Some(symnum sym, st'))
	  info;
	
	wr dbg "\nDone creating eps and next.)\n";

	(* uniquifying the epsilon transition lists *)
	for st = 0 to num_states - 1 do
	  eps.(st) <- uniq compare eps.(st);
	done;

	(sm,next,eps)
;;

let build_nfa(start_symbol:string)(ptrs:parsing_trs)(ters:stringset) : nfa =
(*  let (is_regular,scc_rep,sccs) = compute_nt_info (index_ptrs ptrs) ptrs in*)
(*  let same_scc s s' = scc_rep s = scc_rep s' in*)
  let (pi,sm) = to_ptrsi ptrs in

  let nextstate = ref 0 in
  let newstate() = 
    let x = !nextstate in
    incr nextstate;
    x
  in

  (* trie mapping nonterminals to the pair of states associated with starting and ending of their nfa's *)
  let startendtrie = trie_new() in
  
  (* return the pair of starting and ending state for a given nonterminal *)
  let get_startend(nt : string) : int * int =
    match trie_lookup startendtrie nt with
      None -> 
      let x = newstate() in
      let st = (x, newstate()) in
      trie_insert startendtrie nt st;
      st
    | Some(p) -> p
  in

  let st0 = newstate() in
  let st1 = newstate() in 

  (* given a previous state st and the end state to connect to, and the outputt for that ending state,
     generate a list of edges from an avar list *)
  let rec edges_from_lhs(rhs : string)(st : int)(lhs : avar list)(endst : int) : autinfo list =
    match lhs with
      [] -> [Epsilon(st,endst)]
    | (_,v) :: lhs ->
       let s = newstate() in
       if trie_contains ters v then
	 Edge(st,v,s) :: (edges_from_lhs rhs s lhs endst)
       else
	 (* this is a nonterminal *)
	 let (st',endst') = get_startend v in
	 Epsilon(st,st') :: Epsilon(endst',s) :: (edges_from_lhs rhs s lhs endst)
  in
  let edges_from_prule (r : prule) : autinfo list =
    match r with
      (id , lhs , rhs , oterm) -> 
      let (stst,endst) = get_startend rhs in
      let prodst = newstate() in
      let prodend = newstate() in
      Epsilon(stst,prodst) :: 
      Epsilon(prodend,endst) :: 
          edges_from_lhs rhs prodst lhs prodend 
  in

  let es = List.concat (List.map edges_from_prule ptrs) in
  
  let (stst,endst) = get_startend start_symbol in

(*  let gap = newstate() in *)

  (* add a transition for a special end-of-string symbol ✠ *)
  let es = Epsilon(st0,stst) :: Epsilon(endst,st1) (* :: gap) :: Edge(gap,"✠",st1) *) :: es in

  nfa_from_autinfo !nextstate sm es
;;

let map_nfa (map : int -> int) (aut : nfa) : nfa = 
  let ((tbl,revtbl),next,eps) = aut in
  let num_states = Array.length eps in
  let next' = Array.make num_states None in
  let eps' = Array.make num_states [] in
    for s = 0 to num_states - 1 do
      let s' = map s in
      let map_eps ss = uniq compare (List.filter ((<>) s') (List.map map ss)) in
	next'.(s') <- (match next.(s) with 
			   None -> None
			 | Some(e,s2) -> Some(e,map s2));
	eps'.(s') <- (map_eps eps.(s)) @ eps'.(s');
    done;

    ((tbl,revtbl),next',eps')
;;

(* return a list of distinct states which could begin part of the epsilon relation *)
let eps_start_states (aut : nfa) : int list =
  let (_,next,eps) = aut in
  let num_states = Array.length eps in
  let ret = ref [ start_state ] in
    for i = first_ordinary_state to num_states - 1 do
      match next.(i) with
	  None -> ()
	| Some(e,j) -> 
	    ret := j::!ret
    done;
    !ret
;;

(* collapse epsilon cycles in the given nmm, returning a new nmm.
   Outputs from states on a cycle will be recorded as a list, to
   which the new state representing the cycle will be mapped by the
   returned additional trie. *)
let collapse_cycles (aut:nfa) : nfa = 
  let dbg = nodbg in (*debugger dbg_gen_aut_micro in*)
  let (_,_,eps) = aut in
  let num_states = Array.length eps in
  let (uf:int equiv_t) = mk_equiv num_states in
  let pr() =
    kon dbg
      (fun dbg ->
	 print_equiv uf false dbg (fun x -> (string_of_int x)) (fun x -> ""));
  in
  let collapsed = ref false in 

  (* equate the nodes on the cycle*)
  let rec collapse_path s ss = 
    match ss with
	[] -> ()
      | s' :: ss' -> 
	  if s <> s' then 
	    (collapsed := (union uf s s' []) || !collapsed;
	     collapse_path s ss')
  in
  let collapse_path s ss = 
    collapse_path s ss
  in

  (* path is the path from the start state up to but not including the current state s *)
  let on_path = Array.make num_states false in
  let rec traverse path s =
    kon dbg 
      (fun dbg ->
	 dbg "(traverse ";
	 dbg (string_of_int s);
	 dbg "\n";);
    (if on_path.(s) then
      (collapse_path s path;
       pr())
    else
      (on_path.(s) <- true;
       List.iter 
	 (fun s' ->
	    traverse (s :: path) s')
	 eps.(s);
       on_path.(s) <- false));
    kon dbg 
      (fun dbg ->
	 dbg "traverse ";
	 dbg (string_of_int s);
	 dbg " ends)\n";);
  in

    wr dbg "(Collapse cycles begins:\n";
    pr();
    List.iter (traverse []) (eps_start_states aut);

    wr dbg "Collapse cycles ends.)\n";
    if !collapsed then
      map_nfa (findr uf) aut
    else
      aut
;;

type dfa = symmap * (* map symbols to ints and vice versa, just as for nfa's *)
           int * (* start state *)
	   intset * (* final states *)
           int intmap array (* map states to intmaps, which in turn map symbol numbers
                               to states. *)

let array_intmap_iter (f : int -> int -> 'a -> unit)(a : 'a intmap array) : unit =
  Array.iteri
    (fun s i -> 
      List.iter
	(fun (sym,x) ->
	  f s sym x)
	(intmap_bindings i))
    a;;

let print_dfa (os:string -> unit) (name:string) (aut : dfa) : unit =
  let ((tbl,revtbl),start,final,next) = aut in
  let os_state s = os (string_of_int s) in

  os "(Dfa ";
  os name;
  os ":\n(Symbol table:\n";
  trie_print os (fun i -> os (string_of_int i)) tbl;
  os ")\n(Start state: ";
  os_state start;
  os ")\n(Final states: ";
  List.iter (fun (f,_) -> os_state f; os " ") (intmap_bindings final);
  os ")\n(Transitions:\n";
  array_intmap_iter 
    (fun s sym s' -> 
      os_state s;
      os " -> ";
      os_state s';
      os " | ";
      os revtbl.(sym);
      os "\n") 
    next;
  os "))\n"
;;

let print_dfa_dot (os:string -> unit) (name:string) (aut : dfa) : unit =
  let ((tbl,revtbl),start,final,next) = aut in
  let os_state s = os "s"; os (string_of_int s) in
  let os_state_decl s = 
    os_state s; 
    os " [label = \""; 
    os (string_of_int s);
    os "\"];\n" in
    os "digraph ";
    os name;
    os " {\n";
    os "rankdir = LR;\n";
    os "hidden [shape = plaintext, label = \"\"];\n";
    os "node [shape = doublecircle];\n";
    List.iter (fun (f,_) -> os_state_decl f) (intmap_bindings final);
    os "node [shape = circle];\n";
    for i = 0 to (Array.length next) - 1 do
      if not (intmap_contains final i) then
	os_state_decl i
    done;

    os "hidden -> ";
    os_state start;
    os "\n\n";

    Array.iteri
      (fun s i -> 
	List.iter
	  (fun (sym,s') ->
	       os_state s;
	       os " -> ";
	       os_state s';
	       os " [label = \"";
	       os revtbl.(sym);
	       os "\"];\n")
	  (intmap_bindings i))
      next;

    os "}\n"
;;


let write_dfa_dot (name:string) (aut:dfa) : unit =
  let o = open_out (name^".gv") in
  let os = output_string o in
    print_dfa_dot os name aut;
    close_out o;;

(* map a set of states from the nfa to a canonical representation (just by 
     calling uniq) *)
let canon_nfa_states(sts : int list) : int list = uniq compare sts;;


(* given a list of nfa states, compute their epsilon-closure as a
   canonical list of states, returning also a bool for whether the
   epsclosure contains any final state *)
let epsclosure(aut : nfa)(ss : int list) : int list * bool =
  let dbg = debugger dbg_gen_aut_micro in
  let ((tbl,revtbl),next,eps) = aut in
    let rec helper(i : intset)(s : int) : intset =
      if intset_contains i s then
	i
      else
	helperl (intset_insert i s) eps.(s)
      and helperl(i : intset)(ss : int list) : intset =
	match ss with
	  [] -> i
	| s :: ss -> helperl (helper i s) ss
    in
    let e = canon_nfa_states (intset_ints (helperl intset_empty ss)) in
    let final = List.exists (fun s -> s = final_state) e in
    kon dbg
	(fun dbg ->
	  dbg "(epsclosure of ";
	  print_ints dbg " " ss;
	  dbg " is ";
	  print_ints dbg " " e;
	  dbg ")\n");
    (e , final)
;;

(* return true iff s can reach a final state by epsilon-transitions *)
let eps_final(aut : nfa)(s : int) : bool = 
  snd (epsclosure aut [s]);;

(* we assume nfa is free of epsilon-cycles *)
let nfa_to_dfa (aut : nfa) : dfa =
  let dbg = debugger dbg_gen_aut_micro in
  let ((tbl,revtbl),next,eps) = aut in

  let nextstate = ref 0 in
  let newstate() = 
    let x = !nextstate in
    incr nextstate;
    x
  in

  let (detsttrie : (int * bool) inttrie) = inttrie_new() in
  let (finalst : intset ref) = ref intmap_empty in

  let transs = ref [] in
  let record_trans(t : (int * int * int)) : unit = 
    transs := t :: !transs
  in

  (* from a canonical set of nfa states, compute its epsilon-closure,
     convert the resulting expanded set of nfa states to a detstate,
     and then add (labeled) transitions to trans for it to the next
     detstate. The detstate is returned. *)
  let rec traverse(csts : int list) : int =

    let (csts,final) = epsclosure aut csts in

    match inttrie_lookup detsttrie csts with
      Some(dst,_) -> dst
    | None -> 
       let dst = newstate() in
       if final then
	 finalst := intmap_insert !finalst dst ();

       (* compute an intmap mapping symbol numbers to lists of next nfa states, from the
	  given list of nfa states. *)
       let rec nextstate_set(m : int list intmap)(ss : int list) : int list intmap =
	 match ss with
	   [] -> m
	 | s :: ss -> 
	    match next.(s) with
	      None -> nextstate_set m ss
	    | Some(a,s') -> 
	       nextstate_set (intmap_cons m a s') ss
       in
       
       let m = nextstate_set intmap_empty csts in

       kon dbg (fun dbg ->
		 dbg "(Adding mapping: ";
		 print_ints dbg " " csts;
		 dbg " -> ";
		 dbg (string_of_int dst);
		 if final then
		   dbg " [final]";
		 dbg ")\n");
       inttrie_insert detsttrie csts (dst,final);

       kon dbg 
	   (fun dbg ->
	     intmap_iter m (fun sym ss ->
			     dbg ("  on symbol " ^ revtbl.(sym) ^ " -> ");
			     print_ints dbg " " ss;
			     dbg "\n"));

       intmap_iter m (fun sym ss -> 
		       record_trans (dst,sym,traverse ss));
       dst
  in

  let start = traverse [start_state] in

  kon dbg (fun dbg ->
	    dbg "(The mapping from sets of nfa states to dfa states:\nSize of domain: ";
	    dbg (string_of_int (List.length (inttrie_domain detsttrie)));
	    dbg "\n";
	    inttrie_print dbg (print_ints dbg " ") (fun (x,_) -> dbg (string_of_int x)) detsttrie;
	    dbg ")\n");


  let num_states = !nextstate in
  let trans = Array.make num_states intmap_empty in

  List.iter
    (fun (s,i,s') ->
      trans.(s) <- intmap_insert trans.(s) i s')
    !transs;

  ((tbl,revtbl),start,!finalst,trans)
;;

