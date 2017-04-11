open Grammar;;
open Trs;;
open Trie;;
open Util;;
open Term;;
open Rewriting;;

let dbg_cps = ref false;;
let dbg_local_conf = ref false;;
let dbg_local_conf_micro = ref false;;
let dbg_rewriting = ref false;;

(* (maxvar,reduction1,reduction2,peak,toplevel,rule1,rule2), where the reductions are in order from oldest (least rewritten) to newest *)
type cp = int * term list * term list * term * bool * rule * rule;; 

let print_red_seq (os:string -> unit) (ts:term list) : unit =
  os "(\n";
  List.iter (fun t -> os "  "; print_term os t; os "\n") ts;
  os ")\n";;

let print_cp (os:string -> unit) (c:cp) =
  let (maxvar,x,y,peak,toplevel,r1,r2) = c in
    os "(We have two ways to rewrite the following term:\n  ";
    print_term os peak;
    os "\nWe could have this rewriting sequence\n";
    print_red_seq os x;
    os "or this one:\n";
    print_red_seq os y;
    os "\nThe overlapping rules are:\n";
    os "  ";
    print_rule os r1;
    os "  ";
    print_rule os r2;
    os ")\n";;

let print_cps (os : string -> unit) name cps = 
  if empty cps then
    (os "(No ";
     os name;
     os " critical pairs found.)\n")
  else
    (os "(";
     os (string_of_int (List.length cps));
     os " ";
     os name;
     os " critical pairs found:\n";
     List.iter (print_cp os) cps;
     os ")\n")
;;

let compare_cps (_,reduct1,reduct2,_,_,_,_) (_,reduct1',reduct2',_,_,_,_) : int =
  let reduct1 = List.hd reduct1 in
  let reduct1' = List.hd reduct1' in
  let reduct2 = List.hd reduct2 in
  let reduct2' = List.hd reduct2' in
  if eq_term nodbg reduct1 reduct1' then
    if eq_term nodbg reduct2 reduct2' then
      0
    else
      compare reduct2 reduct2'
  else
    compare reduct1 reduct1';;

let rec unify (subst:term option array) (t1:term) (t2:term) : bool =
  match t1 with
      Var(x) ->
	(match subst.(x) with
	     None -> subst.(x) <- Some(t2); true
	   | Some(t1') -> unify subst t1' t2)
    | Normal(t1') -> unify subst t1' t2
    | App(f1,args1) ->
	match t2 with
	    Var(x) -> 
	      (* let the case above handle this one *)
	      unify subst t2 t1
	  | Normal(t2') -> unify subst t1 t2'
	  | App(f2,args2) ->
	      if f1 <> f2 then
		false
	      else
		unify_args subst args1 args2
and unify_args (subst:term option array) (args1:term list) (args2:term list) : bool =
  match args1,args2 with
      t1::args1',t2::args2' ->
	if unify subst t1 t2 then
	  unify_args subst args1' args2'
	else
	  false
    | [],[] -> true
    | _,_ -> false (* we will treat different arity uses of the same function as uses
		      of different functions *);;

let unify (maxv:int) (t1:term) (t2:term) : term option array option =
  let subst = Array.make (maxv+1) None in
    if (unify subst t1 t2) then
      Some(subst)
    else
      None
;;


(* t should be a subterm of lhs1, and we should have renamed r2 away from r1. 
   The int in the cp is an upper bound on its max var. 

   If eqlhs is true, then t equals lhs1.

   If top_only is true, we only look for an overlap at the top level of the term t.
*)
let rec cps (dbg:debugger_t) (headmap:rule list trie) r1 r2 maxv (c:term -> term) (t:term) (eqlhs1:bool) (top_only:bool): cp list =
  let dbgr = debugger dbg_rewriting in
  let Rule(_,_,rhs1) = r1 in
  let Rule(_,lhs2,rhs2) = r2 in

  (* compute cps for the args in rest_args, extending
     the context c to account for the fact that the term
     we are considering is c(f(pre_args,rest_args)) *)
  let rec cps_args (f:string) (pre_args:term list) (rest_args : term list) : cp list =
    match rest_args with 
	[] -> []
      | arg::rest_args' ->
	  (cps dbg headmap r1 r2 maxv (fun x -> c (App(f,pre_args @ x::rest_args'))) arg false false)
	  @ (cps_args f (pre_args @ [arg]) rest_args')
  in
    match t with
	Var(x) -> [] (* we do not use unification with a variable in lhs1 to generate a cp *)
      | Normal(t') -> cps dbg headmap r1 r2 maxv c t' eqlhs1 top_only
      | App(f,args) ->
	  let rest() = if top_only then [] else cps_args f [] args in
	    kon dbg
	      (fun dbg ->
		 dbg "(cps begins\nTrying to unify the subterm\n  ";
		 print_term dbg t;
		 dbg "\nof the lhs of rule\n  ";
		 print_rule dbg r1;
		 dbg "\nwith the lhs of rule\n  ";
		 print_rule dbg r2;
		 dbg "\n");
	    let ret =
	      match unify maxv t lhs2 with
		  None -> 
		    wr dbg "No cp.\n";
		    rest()
		| Some(u) -> 
		    (* we might rewrite the peak to nothing, returning None *)
		    let new_cp1 = apply_subst u rhs1 in
		    let new_cp2 = c (apply_subst u rhs2) in
		    let peak = (c (apply_subst u t)) in
		      kon dbg
			(fun dbg ->
			   dbg "(Trying to join cp with peak\n  ";
			   print_term dbg peak;
			   dbg "\n(The cp is:\n  a. ";
			   print_term dbg new_cp1;
			   dbg "\n  b. ";
			   print_term dbg new_cp2;
			   dbg ")\n\n");
		      wr dbgr "(Rewriting lhs:\n";
		      let nxs1 = rewrite_inner_rules dbgr false [r2] new_cp1 in
		      let nxs2 = rewrite_inner dbgr true headmap (List.hd nxs1) in
			wr dbgr ")\n(Rewriting rhs:\n";
			let nys1 = rewrite_inner_rules dbgr false [r1] new_cp2 in
			let nys2 = rewrite_inner dbgr true headmap (List.hd nys1) in
			  wr dbgr ")\n";
			  let nx = List.hd nxs2 in
			  let ny = List.hd nys2 in
			  let ret = 
			    if (eq_term nodbg nx ny) then 
			      (kon dbg 
				 (fun dbg ->
				    dbg "(Both sides of the cp rewrite to ";
				    print_term dbg nx;
				    dbg ")\n");
			       rest())
			    else
			      (wr dbg "(The cp is not joinable.)\n";
			       let jn l1 l2 = peak::(List.rev_append l1 (List.tl (List.rev l2))) in
				 (maxv, jn nxs1 nxs2, jn nys1 nys2, peak,eqlhs1,r1,r2)::rest())
			  in
			    wr dbg ")\n";
			    ret
	    in
	      wr dbg ")\n";
	      ret
		
;;

(* we are only supporting following rightmost positions of applications of binary functions *)
type position = EmptyPos | RightPos of position;;

let rec print_position os p =
  match p with
      EmptyPos -> os "empty"
    | RightPos(p) -> os "right "; print_position os p
;;

(* we assume p is a valid position into t *)
let decompose (p:position) (t:term) : (term -> term) * term =
  let rec helper (c:term -> term) (p:position) (t:term) : (term -> term) * term =
    match p,t with
	_ , Normal(t') -> helper c p t'
      | EmptyPos,_ -> (c,t)
      | RightPos(p),App(f,[arg1;arg2]) -> helper (fun x -> c (App(f,[arg1;x])))  p arg2
      | _ , _ -> err "Internal error in decompose.\n"
  in
    helper (fun x -> x) p t
;;    

(* rename rules and compute maxv for the above cps function *)
let cps_s (dbg:debugger_t) (headmap:rule list trie) r1 r2 (p:position) (top_only:bool): cp list =
  let Rule((id1,maxv2),_,_) = r2 in
  let Rule((id2,_),_,_) = r1 in
    if id1 = id2 && p = EmptyPos then 
      (wr dbg "(Computing cps: skipping the overlap of a rule with itself at the top level.)\n";
       [])
    else
      let r1' = rename_rule (maxv2+1) r1 in
      let Rule((_,maxv),lhs,rhs) = r1' in
      let ((c:term -> term), (t:term)) = decompose p lhs in
	cps dbg headmap r1' r2 maxv c t (p = EmptyPos) top_only;;

(* we look for overlaps with the second rule in the first, rewriting with the rules indexed
   by the given headmap. 
   If top_only is true, we look only consider lhs1, not subterms of lhs1.
*)
let cps_r (dbg:debugger_t) (headmap:rule list trie) (top_only:bool) (r : rule * rule) : cp list =
  let (r1,r2) = r in
    cps_s dbg headmap r1 r2 EmptyPos top_only;;

(* the symmap maps strings for functions symbols to
   rules where they appear. 
*)
let update_symmap (symmap:rule list trie) (rs : rule list) : unit =
  let rec add_term (r:rule) (t:term) : unit =
    match t with
	App(f,ts) -> 
	  trie_cons symmap f r;
	  List.iter (add_term r) ts
      | Normal(t') -> add_term r t'
      | Var(x) -> ()
  in
    List.iter 
      (fun r ->
	 let Rule(_,lhs,rhs) = r in
	   add_term r lhs)
      rs;
    list_trie_uniq symmap compare_rules
;;

(* the headmap maps strings for function symbols to the rules where
   they are the head, as defined by Grammar.get_head_symbol *)
let update_headmap_rule (headmap : rule list trie) (r:rule) : unit =
  let Rule(_,lhs,rhs) = r in
    match get_head_symbol lhs with
	None -> () (* should not happen *)
      | Some(f) ->
	  trie_cons headmap f r;;

let update_headmap (headmap:rule list trie) (rs : rule list) : unit =
  List.iter (update_headmap_rule headmap) rs;
  list_trie_uniq headmap compare_rules
;;

let cps  (symmap:rule list trie) (headmap:rule list trie) (rules:rule list) : cp list =
  let dbg = debugger dbg_cps in
  let consult_symmap (r:rule) : rule list =
    let Rule(rname,lhs,rhs) = r in
      match get_head_symbol lhs with
	  None -> [] (* should not happen *)
	| Some(f) ->
	    match trie_lookup symmap f with
		None -> []
	      | Some(rs) -> rs
  in
  let consult_headmap (r:rule) : rule list =
    let Rule(rname,lhs,rhs) = r in
    let syms = collect_fun_syms lhs in
      List.concat
	(List.map (fun f ->
		     match trie_lookup headmap f with
			 None -> []
		       | Some(rs) -> rs) 
	   syms)
  in
    wr dbg "(Beginning computation of cps.\n";

    (* for each new rule r:
       
       1. collect the rules which contain the leading symbol of r,
       and look for unifiers with r's lhs in those rules.

       2. collect the rules which contain any symbol of r,
       and look for unifiers with the lhs's of those rules in r.
    *)
    
    let the_cps = 
      List.concat
	(List.map 
	   (fun r ->
	      let ss = consult_symmap r in
	      let cs = consult_headmap r in 
		
	      let prrs z = kon dbg (fun dbg -> List.iter (fun r2 -> dbg "  "; print_rule dbg r2) z) in
		kon dbg
		  (fun dbg ->
		     dbg "(Computing cps with this rule:\n  ";
		     print_rule dbg r;
		     dbg "overlapping into these rules:\n";
		     prrs ss;
		     dbg "and being overlapped by these rules:\n";
		     prrs cs);
		let l = 
		  List.concat 
		    ((List.map (fun r2 -> cps_r dbg headmap false (r2,r)) ss)
		     @ (List.map (fun r2 -> cps_r dbg headmap false (r,r2)) cs)) in
		  wr dbg "\n)\n";
		  l)
	   rules)
    in
      kon dbg
	(fun dbg ->
	   dbg "computation of cps ends)\n";
	   dbg "(Computed ";
	   dbg (string_of_int (List.length the_cps));
	   dbg " critical pairs.)\n");
      let uniq_cps = uniq compare_cps the_cps in
	if nonempty uniq_cps then
	  (kon dbg
	     (fun dbg ->
		dbg "(Of the computed critical pairs, ";
		dbg (string_of_int (List.length uniq_cps));
		dbg " are unique.)\n"));

	uniq_cps
;;

(*   Return the list of unjoinable critical pairs (empty iff locally confluent). 
*)

let locally_confluent (Trs(rs)) : (cp list) =
  let dbg = debugger dbg_local_conf in
  let dbgm = debugger dbg_local_conf_micro in
    wr dbg "(Beginning check for local confluence.\n\n";
    let symmap = trie_new() in
    let headmap = trie_new() in

      update_symmap symmap rs;
      update_headmap headmap rs;
      
      kon dbgm 
	(fun dbgm ->
	   dbgm "The symmap is:\n(";
	   print_rewrite_map dbgm symmap;
	   dbgm ")\n\nThe headmap is:\n(";
	   print_rewrite_map dbgm headmap;
	   dbgm ")\n");
      
      let ret = cps symmap headmap rs in
	wr dbg "Check for local confluence ends.)\n";
	ret
;;
