open Util;;
open Grammar;;
open Trs;;
open Trie;;
open Term;;
open Ast;;

let dbg_convert_grammar = ref false;;

(* (id, lhs , rhs, r) means that we will rewrite lists of
   terms whose top symbols match lhs (see ast.ml for the type avar)
   to rhs, where if r is Some(t), we will build AST t by including each 
   element of lhs in the way indicated by ast_type:
     -- NotInAst: do not include the element at all
     -- SymOnly: we literally include the element (this is for terminals) 
     -- SubAst: we include the sub-ast for the element.
   The root of the AST will be labeled with name. 
   The term t uses variables to refer to the sub-asts in the term matching the lhs.
   If r is None, we are not to build an AST.  

   The rhs is of the form (nt,ostates), where nt is the nonterminal, and
   ostates is optionally the pair of starting and ending states (as strings) for the rhs.

   The id is a unique rule id.
*)

let empty_string_target = "empty-string"

(* (name,lhs,rhs,term_to_construct) *)
type prule = string * (avar list) * string * (term option);;

type parsing_trs = prule list;;

let sort_rules (l:(string * 'a * 'b * 'c) list) : (string * 'a * 'b * 'c) list =
  List.sort (fun (i,_,_,_) (j,_,_,_) -> compare i j) l;;


let print_prule_sym os s =
  match s with
    (NotInAst,s) -> os "#"; os s
  | (SubAst(i),s) -> os s; os "["; os (string_of_int i); os "]"
  | (SymOnly,s) -> os s
;;



let print_prule (os:string -> unit) (r:prule) =
  let (id,lhs,rhs,ot) = r in
  let pr_ot () =
    os "[";
    (match ot with
       None -> ()
     | Some(t) -> print_term os t);
    os "]\n"
  in

  os id;
  os ": ";
  List.iter (fun s -> os " "; print_prule_sym os s) lhs;
  os " -> ";
  os rhs;
  pr_ot();
;;

let prule_to_string (r:prule) : string =
  let s = ref "" in
    print_prule (fun s' -> s := !s ^ s') r;
    !s;;

let print_parsing_trs (os:string -> unit) (s:parsing_trs) : unit = 
  os "(\n";
  List.iter (print_prule os) s;
  os ")\n";;       


(* convert grammar (abstract syntax) to a parsing TRS.

   The returned values:
     1. the tp_ctxt gives the types for all syntactic productions.
     2. the trie string maps syntactic nonterminals N to other nonterminals N', where N is embedded into N',
        which means that the parse-tree ctors for N will actually be declared as part of the type for N'.
     3. the actual parsing trs.
*)
let convert_grammar (Grammar(name,ostart,ows,o,ps,lexs,Trs(rs))) : tp_ctxt * (string trie) * parsing_trs =
  let dbg = debugger dbg_convert_grammar in
  let nextid = ref 0 in
  let id() = 
    let i = !nextid in
      incr nextid;
      i
  in
    wr dbg "(convert_grammar begins.\n";
    match o with
      (SyntacticNts(syn_nts),ReadingNts(read_nts),RecognizingNts(recog_nts),Terminals(ter_syms)) ->
	let ctor_tps = trie_new() in

	  (* map nt1 to nt2 if we are making the ctors for nt1 just be ctors of nt2 ("embedding" n1 into n2) *)
	let embedding = trie_new() in
	let rembedding = trie_new() in
	let embed s r = 
	  trie_insert embedding s r;
	  trie_cons rembedding r s
	in

	let getrep t = stringtrie_lookup_if embedding t in
	  (* first look for any embeddings, since this effects how we process rules involving
	     the embedded nonterminal. *)
	  List.iter (fun (Prod(rn,s,ss)) -> 
		       if rn = "embed" then
			 match ss with
			     s' :: [] -> 
			       (if not (trie_contains syn_nts s') then
				  err ("The grammar is requesting an embedding of nonterminal " ^ s' ^ " to " ^ s ^ ",\n"
					 ^ "but " ^ s' ^ " is not a syntactic nonterminal.\n");
				if trie_contains embedding s' then
				  err ("The grammar is requesting an embedding of nonterminal " ^ s' ^ " to " ^ s ^ ",\n"
				       ^ "but " ^ s' ^ " is already embedded to " ^ getrep s');
				let r = getrep s in
				  embed s' r;
				  (* now just see if we were already embedding things to s, because then we need to update
				     them to embed them to r *)
				  match trie_lookup rembedding s' with
				      None -> ()
				    | Some(ss') -> 
					List.iter (fun s' -> embed s' r) ss')
			   | _ ->
			       err ("The grammar is requesting an embedding of nonterminals, but the production given is not\n"
				      ^ "a unit production.\n\n"
				      ^ "1. the production: " ^ s ^ " -> " ^ String.concat " " ss)) ps;

	let helper (is_syn:bool) (rule_name_opt:string option)
	           (include_terminals:bool) (r:role) (prod_lhs:string) (prod_rhs:string list) 
	    : prule =

	  let nextvar = ref 0 in
	  let get_nextvar() = 
	    let v = !nextvar in
	      incr nextvar;
	      v
	  in

	  (* compute an rhs with ast_type annotations *)
	  let rec get_prule_lhs (ss : string list) : avar list = 
	    List.map (fun s -> 
			let tp = 
			  if trie_contains syn_nts s || trie_contains read_nts s then
			    SubAst(get_nextvar())
			  else
			    if (include_terminals && trie_contains ter_syms s) then
			      SymOnly
			    else
			      NotInAst
			in
			  (tp,s))
	      ss
	  in

	  let prule_lhs = get_prule_lhs prod_rhs in
	  let nt = prod_lhs in
	  let prule_rhs = nt in

	  (* args converts an rhs with intermediate annotations to a
	     list of pairs of strings and terms.  The strings are for
	     the nonterminals generating arguments to a constructor,
	     which will be used to construct types in emitted
	     code. The terms will be the actual arguments to the
	     constructor. *)
	  let rec args ss = 
	    match ss with
		[] -> []
	      | (NotInAst,_)::ss' -> args ss'
	      | (SymOnly,s)::ss' -> (s,app1 "char-to-string" (const s))::(args ss')
	      | (SubAst(i),s)::ss' -> (s,var i)::(args ss')
	  in
	  let default_rule_name () = "P"^(string_of_int (id())) in
	    match r with
		Reading ->
		  let a = args prule_lhs in
		  let (id,rule_name,extra_arg) = 
		    match rule_name_opt with
			(* for string-append, we will include the length of the list as an extra argument,
			   for the benefit of an arity-generic string-append function in Agda *)
			None -> 
			  let l = (List.length a) in
			    if l = 0 then
			      (default_rule_name(), empty_string_target, None)
			    else
			      (default_rule_name(), Trs.string_append, Some(const (string_of_int (l - 1))))
		      | Some(rule_name) -> (rule_name,rule_name,None)
		  in

		    (* update the ctor_tps table with the list of input types
		       and return type for the ctor with the given name; 
		       we are assuming productions have distinct names *)
		    
		    let args = List.map snd a in
		    let args = match extra_arg with Some(a) -> a::args | None -> args in

		    let retterm = ref (App(rule_name,args)) in
		      if is_syn then
			(if rule_name = "embed" then
			   retterm := List.hd args (* previous checks should ensure this never fails *)
			 else 
			   trie_insert ctor_tps rule_name (List.map (fun p -> getrep (fst p)) a, getrep nt));

		      (id, prule_lhs, prule_rhs, Some(!retterm))
	      | Recognizing -> 
		  (default_rule_name(), prule_lhs, prule_rhs, None)
	in

	(* this is now the ptrs: *)
	let ptrs = 
	  (List.map (fun (Prod(rn,s,ss)) -> helper true (Some(rn)) false Reading s ss) ps) 
	  @ (List.map (fun (Lex(r,s,ss)) -> helper false None (r=Reading) r s ss) lexs)
	in

	(* make sure the grammar's rewrite rules only use production names at
	   the correct arities *)
	let rec check_trs_term (r:rule) (t:term) : unit =
	  match t with
	      Normal(t') -> check_trs_term r t' (* shouldn't happen *)
	    | Var(_) -> ()
	    | App(f,args) -> 
		(match trie_lookup ctor_tps f with
		     None ->
		       (print_string "A rewrite rule is using a function symbol which is not the name of a production.\n";
			print_string "1. the rewrite rule: ";
			print_rule print_string r;
			print_string "\n2. the function symbol: ";
			print_string f;
			print_string "\n";
			exit 1);
		   | Some(input_tps,output_tp) ->
		       let a = List.length input_tps in
			 if List.length args <> a then
			   (print_string "A rewrite rule is using a production name with the wrong number of arguments.\n";
			    print_string "1. the rewrite rule: ";
			    print_rule print_string r;
			    print_string "\n2. the production name: ";
			    print_string f;
			    print_string "\n3. the expected number of arguments: ";
			    print_string (string_of_int a);
			    print_string "\n";
			    exit 1);
			 List.iter (check_trs_term r) args)
	in

	  List.iter (fun r ->
		       let (Rule(_,lhs,rhs)) = r in 
			 check_trs_term r lhs;
			 check_trs_term r rhs) rs;

	  wr dbg "convert_grammar ends.)\n";
	  (ctor_tps, embedding, sort_rules ptrs)
;;



(* Gets all the non-terminals which could directly produce the empty string *)
let get_nullable_nts (ptrs : parsing_trs)(dbg:debugger_t) =
  let nullable = trie_new() in
  let prodIds = trie_new() in

  let rec aux isNullable = function
    | (_,nt2)::xs -> 
       if trie_contains nullable nt2 then aux isNullable xs
       else false
    | [] -> isNullable
  in

  let rec collect_new_empties more = function
    | ((id,lhs,nt,_)::xs) -> (
      if trie_contains prodIds id then collect_new_empties more xs
      else if aux true lhs then (
	wr dbg ("Found nullable (" ^ nt ^ ", " ^ id ^ ")\n");
	trie_cons nullable nt id; 
	trie_insert prodIds id true;
	collect_new_empties true xs
      )
      else collect_new_empties more xs
    )

    | [] ->   if more then collect_new_empties false ptrs else ()
  in
  collect_new_empties false ptrs;

  nullable
;;

let get_empty_scc_refs nullable_nts scc_num ptrs dbgtop =
  let same_scc x y = scc_num x = scc_num y in

  let rec trav nulltrie nt context = function
    | (_,nt')::elts -> 
       if same_scc nt nt' then
	 trie_cons nulltrie nt (nt', context);
       if trie_contains nullable_nts nt' then
	 trav nulltrie nt (nt'::context) elts
    | [] -> ()
  in

  let prenull = trie_new() in

  List.iter (
      fun (id,lhs,nt,_) -> (
	trav prenull nt [] lhs;
      )       
    ) ptrs;

  prenull
;;

let index_ptrs (ptrs : parsing_trs) : prule list trie =
  let ind = trie_new () in 
  List.iter (fun r -> let (id,_,rhs,_) = r in trie_cons ind rhs r) ptrs;
  ind
;;

type symmap = int trie *   (* map strings to symnums *)
	      string array (* map symnums to strings *)


type prulei = string * (avari list) * int * (term option);;
type parsing_trsi = prulei list * symmap;;

let print_syms(os : string -> unit)(s : symmap)(l : int list) =
  let (tbl,revtbl) = s in
  print_strings os "," (List.map (fun x -> revtbl.(x)) l);;

let to_ptrsi(ptrs : parsing_trs) : parsing_trsi =
  let next_symnum = ref 0 in
  let tbl = trie_new() in
  let symnum e = 
    match trie_lookup tbl e with
	None ->
	  let v = !next_symnum in 
	    incr next_symnum; 
	    trie_insert tbl e v;
	    v 
      | Some(x) -> x
  in

  let rs = List.map (fun (name,lhs,rhs,ot) -> 
		      (name,List.map (fun(a,s) -> (a,symnum s)) lhs, symnum rhs, ot)) ptrs in
  
  let num_syms = !next_symnum in
  
  (* create the reverse table to map symnums to their symbols *)
  let revtbl = Array.make num_syms "" in
  List.iter
    (fun e -> revtbl.(symnum e) <- e)
    (trie_strings tbl);
  
  (rs,(tbl,revtbl));;
