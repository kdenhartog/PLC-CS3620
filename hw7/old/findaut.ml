open Aut;;
open Localconf;;
open Parsing_trs;;
open Rewriting;;
open Term;;
open Trs;;
open Trie;;
open Util;;

let dbg_find_aut = ref false;;
let dbg_print_uf = ref false;;
let max_rounds = ref 10;;

let solver : string option ref = ref None;;

type parsing_cp = (int * (string list) * Localconf.cp);;

(* test confluence of prs modulo the first together with the second
   trs.  The tuples (ind,common,cp) returned show the index into the
   left-overlapping rule at which a nontrivial common substring was
   found with the right-overlapping rule, giving rise to the given
   cp.  *)
let locally_confluent dbgtop (Trs(prs)) (Trs(rs)) : (parsing_cp list) =
  let dbg = debugger Localconf.dbg_local_conf in
  let dbgm = debugger Localconf.dbg_local_conf_micro in
    
    wr dbgtop "(Analyzing the plain rewriting rules for local confluence:\n";
    
    (* index the rules we will use to rewrite critical pairs *)
    let rewritemap = Rewriting.compute_rewrite_map (prs @ rs) in
      
      kon dbgm
	(fun dbgm ->
	   dbgm "(The rewrite map is:\n(";
	   print_rewrite_map dbgm rewritemap;
	   dbgm "))\n");

      elapsed (wr dbg);

      wr dbg "(Searching for overlaps between suffixes and prefixes of rules.\n";

      (* the index will map all suffixes (see list_suffixes) of the
	 lhs of r to (ind,pos,r), for each rule r, where ind is the index into
	 the lhs where the suffix starts, and pos is a position representing
	 that index (for benefit of Localconf). *)
      let index = trie_new() in

      (* build a list of the suffixes together with a number indicating how deep they are in the
	 list, and positions corresponding to those depths *)
      let rec list_suffixes (index:int) (p:position) (l:'a list) : (int * position * 'a list) list =
	match l with
	    _::l' -> (index,p,l)::(list_suffixes (index+1) (RightPos(p)) l')
	  | [] -> []
      in
      let right_strs_no_dot l = List.filter (fun x -> x <> "dot") (right_strs l) in
      let index_suffixes (r:rule) : unit =
	let (Rule(_,lhs,rhs)) = r in
	let lhs_strs = right_strs_no_dot lhs in
	let ls = list_suffixes 0 EmptyPos lhs_strs in
	  (* modify the index to map each suffix, as a single string, to (ind,p,r) *)
	  List.iter (fun (ind,p,suf) -> trie_cons index (String.concat " " suf) (ind,p,r)) ls;
      in

      let print_pos_rule os (ind,p,r) =
	os (string_of_int ind); os " , "; print_position os p; os " , " ; print_rule os r
      in
      let print_pos_rule_pref os (pref,x) = 
	os pref; 
	os " , ";
	print_pos_rule os x
      in

	wr dbg "(Indexing suffixes.\n";
	(* index all the rules which we are searching for critical pairs *)
	List.iter index_suffixes prs;
	wr dbg "done.)\n";
	kon dbgm
	  (fun dbgm ->
	     dbgm "The index of suffixes is\n(\n";
	     print_trie dbgm (List.iter (print_pos_rule dbgm)) index;
	     dbgm ")\n");
	elapsed (wr dbg);

	let rec suff_cps prs =
	  match prs with
	      [] -> []
	    | r::prs' ->
		kon dbg
		  (fun dbg ->
		     dbg "(Considering rule r=\n  ";
		     print_rule dbg r);
		
		(* for each rule r, search the index for a prefix of the lhs of r. 
		   Each such prefix corresponds to a situation where the a suffix of a rule
		   overlaps with a prefix of a rule.  
		*)

		let (Rule(_,lhs,_)) = r in

		  let overlapping = List.concat (List.map (fun (pref,rs) ->
							     List.map (fun r -> (pref,r)) rs)
						   (trie_lookup_prefix index (String.concat " " (right_strs_no_dot lhs)))) in
		    kon dbg
		      (fun dbg ->
			 dbg "\nThe overlaps found are:\n(\n";
			 List.iter (print_pos_rule_pref dbg) overlapping;
			 dbg ")\n");
		    let ret = List.concat (List.map (fun (pref,(ind,p,r')) -> 
						       List.map (fun cp ->
								   (ind,split_string ' ' pref,cp))
							 (Localconf.cps_s dbgm rewritemap r' r p true)) overlapping) in
		      wr dbg ")\n";

		      ret @ (suff_cps prs')
	in
	let ret = suff_cps prs in
	  wr dbg "done searching for overlaps between rules and proper suffixes of rules.)\n";
	  wr dbgtop "Analyzing run-rewriting rules for local confluence ends).\n\n";
	  ret
;;

type stpair = int * int

(* each rule is of the form (id,lhs,(stpair1,rhs,stpair2),ot)
   where the ot is either Some(t) with t a parse tree we are
   supposed to build when we apply the rule, or else None if
   we are not supposed to build a parse tree.  The lhs is 
   a list of tuples of the form (stpair1,t,s,stpair2) where
   t is an ast_type as described in parsing_trs.ml. 
*)
type rrs = (int * (stpair * ast_type * string * stpair) list * (stpair * string * stpair) * term option) list;;

let print_stpair(os:string -> unit) (f,b) = os "("; os (string_of_int f); os " , "; os (string_of_int b); os ")";;

let print_rrs(os:string -> unit) (r:rrs) : unit = 
  os "(Run-rewriting system with ";
  os (string_of_int (List.length r));
  os " rules:\n";
  List.iter
    (fun (i,lhs,(rhsp1,rhs,rhsp2),ot) ->
       os (string_of_int i);
       os ".  ";
       let first = ref true in
	 List.iter 
	   (fun (p1,t,s,p2) ->
	      if !first then
		(print_stpair os p1;
		 first := false);
	      os " . ";
	      print_prule_sym os t s;
	      os " . ";
	      print_stpair os p2)
	   lhs;
	 os " -> ";
	 print_stpair os rhsp1;
	 os " . ";
	 os rhs;
	 (match ot with
	      None -> ()
	    | Some(m) -> 
		os " [ ";
		print_term os m;
		os " ] ");
	 os " . ";
	 print_stpair os rhsp2;
	 os "\n")
    r;
  os "end of run-rewriting system.)\n";;

(* This uses an algorithm from Cormen, Leiserson, and Rivest (CLR): do
   a depth-first search of the graph, recording vertices whenever
   exploration of their out-edges finishes; then do a second DFS on
   the inverse of the original graph, starting with the vertices that
   finished last in the first DFS search.  The resulting forest is
   proved in CLR to consist of SCCs.

   We return a trie mapping a nt to the set of nts that come
   immediately after it in the graph where there is an edge (x,y) iff
   x generates y (i.e., x ->* w y w'), but not vice versa.
*)
let compute_after (is_nt:string -> bool) (ptrs:parsing_trs) : string list trie =
  let dbg = debugger dbg_find_aut in

  (* edge(x,y) holds iff there is a production x -> ... y ..., with y a nonterminal, 
     represented in ptrs. *)

  (* compute the graph and its inverse *)
  let edge = trie_new() in
  let rev_edge = trie_new() in
    List.iter (fun (_,lhs,rhs,ot) -> 
		 let lhs_nts = (List.filter is_nt (List.map snd lhs)) in
		   trie_append edge rhs lhs_nts;
		   List.iter (fun s -> trie_cons rev_edge s rhs) lhs_nts) ptrs;
    let mark = trie_new() in
    let finished = ref [] in

    let rec dfs (r:string list trie) (s:string) : unit =
      if not (trie_contains mark s) then
	(stringset_add mark s;
	 List.iter (dfs r) (list_trie_lookup r s);
	 finished := s::!finished)
    in

    let nodes = trie_strings edge in
      List.iter (dfs edge) nodes;
      let search_nodes = !finished in 
      let sccs = ref [] in
	trie_clear mark;
	List.iter 
	  (fun n ->
	     finished := [];
	     dfs rev_edge n;
	     if nonempty !finished then
	       sccs := !finished::!sccs)
	  search_nodes;

	let after = trie_new() in
	let rec process_sccs sccs =
	  match sccs with
	      [] -> ()
	    | scc1::sccs' ->
		match sccs' with
		    [] -> ()
		  | scc2::_ ->
		      List.iter
			(fun n ->
			   List.iter
			     (fun n' ->
				trie_cons after n n')
			     scc2)
			scc1;
		      process_sccs sccs'
	in
	  kon dbg
	    (fun dbg ->
	       dbg "(SCCs from the grammar:\n";
	       List.iter
		 (fun scc ->
		    print_strings dbg " " scc;
		    dbg "\n")
		 !sccs;
	       dbg ")\n");
	  process_sccs !sccs;
	  after
;;

let find_aut (dbgtop:debugger_t)(name:string)(start_symbol:string)(ptrs : parsing_trs)(reorg_trs:trs)
    (syn_nts:stringset)(read_nts:stringset)(rec_nts:stringset)(ter:stringset) : automaton * automaton * rrs =
  let dbg = debugger dbg_find_aut in
  let dbguf = debugger dbg_print_uf in
  let dbgc = debugger Localconf.dbg_cps in
  let nts = trie_clone syn_nts in
    trie_merge nts read_nts;
    trie_merge nts rec_nts;

  let rec round rnd ptrs : automaton * automaton * rrs =
    let _ = (kon dbg (fun dbg -> 
			dbg "-------------------------------------------------------------\n";
			dbg "Beginning round ";
			dbg (string_of_int rnd);
			dbg " of refining the parsing TRS (grammar) for automaton construction.\n\n")) in
    let is_nt = trie_contains nts in
    let is_ter = trie_contains ter in
    let trs = Parsing_trs.to_trs ptrs in
    let _ = (kon dbg
	       (fun dbg ->
		  dbg "(The TRS derived from the parsing TRS is:\n";
		  Trs.print_trs dbg trs;
		  dbg ")\n")) in
    let cps = locally_confluent dbg trs reorg_trs in
    let is_reorg_cp (_,_,(_,red1,red2,_,_,_,_)) =
      let last1 = list_last red1 in
      let last2 = list_last red2 in
      let complete t = not (is_app "dot" (get_right t)) in
	complete last1 && complete last2 && (eq_term nodbg (get_left last1) (get_left last2))
    in
    let (reorg_cps,parsing_cps) = List.partition is_reorg_cp cps in
    let pr_cp os (ind,common,cp) = 
      os "(With index ";
      os (string_of_int ind);
      os " and common substring ";
      print_strings os " " common;
      os " (length ";
      os (string_of_int (List.length common));
      os "):\n";
      print_cp os cp;
      os ")\n" in
    let pr_cps name cps = 
      kon dbgc
	(fun dbgc ->
	   if empty cps then
	     (dbgc "(No ";
	      dbgc name;
	      dbgc " critical pairs found.)\n")
	   else
	     (dbgc "(";
	      dbgc (string_of_int (List.length cps));
	      dbgc " ";
	      dbgc name;
	      dbgc " critical pairs found:\n";
	      List.iter (pr_cp dbgc) cps;
	      dbgc ")\n"))
    in
    let _ = 
      pr_cps "reorganizing" reorg_cps;
      if nonempty reorg_cps then
	err "The grammar has critical pairs that need additional reorganizing rules to resolve (see report.txt).";
      pr_cps "parsing" parsing_cps
    in
      
    let _ = if empty ptrs then
      err "The grammar has no productions" in
      
    let dirstr dir = if dir then "f" else "b" in
    let dirlongstr dir = if dir then "forward" else "backward" in
    let ntvar dir d s = (dirstr dir)^(string_of_int d)^s in
    let prodvar dir i j = (dirstr dir)^"_"^(string_of_int i)^"_"^(string_of_int j) in
    let forw = true in
    let backw = false in
    let vars = trie_new() in
    let nextvar = ref 0 in
      (* convert a variable name to a unique associated int *)
    let varint (s:string) : int =
      match trie_lookup vars s with
	  None ->
	    let v = !nextvar in
	      incr nextvar;
	      trie_insert vars s v;
	      v
	| Some(v) -> v
    in
    let declare_var v = 
      let _ = varint v in ()
(*	kon dbg (fun dbg -> dbg "declare_var "; dbg v; dbg " = "; dbg (string_of_int i); dbg "\n") *)
    in
      
      (* we declare variables first, just to figure out how many we have *)

      (* declare all the variables we are maybe going to need for states in rhs's of productions *)
    let len_ptrs = ref 0 in
    let _ = 
      List.iter
	(fun (i,lhs,_,_) ->
	   incr len_ptrs;
	   let len = List.length lhs in
	     for j = 0 to len do
	       declare_var (prodvar forw i j);
	       declare_var (prodvar backw i j);
	     done)
	ptrs 
    in

      (* rind maps rule numbers to their rules *)
    let rind = Array.make !len_ptrs None in
    let _ = 
      List.iter
	(fun x ->
	   let (i,_,_,_) = x in
	     rind.(i) <- Some(x))
	ptrs
    in
      
      (* declare all the variables we are going to need for states for nonterminals *)

      List.iter
	(fun s ->
	   declare_var (ntvar forw 1 s);
	   declare_var (ntvar backw 1 s);
	   declare_var (ntvar forw 2 s);
	   declare_var (ntvar backw 2 s))
	(trie_strings nts);

      (* initialize some other data structures once we have declared all variables (so we know how many there are) *)

      (* if varint s = i, then revvars.(i) = s *)
      let revvars = Array.make !nextvar "" in
      let _ = 
	List.iter (fun s -> let i = varint s in revvars.(i) <- s) (trie_strings vars)
      in
	
      let _ = kon dbg (fun dbg -> dbg "(Number of variables: "; dbg (string_of_int !nextvar); dbg ".)\n") in

      (* detmap.(i) is a trie which maps terminals to lists of states.  Whenever we have a transition from
	 state i to state j, where the transition is labeled by terminal t, then we will ensure
	 that state j equals the states to which detmap.(i) maps t. This is to enforce that the
	 the automaton we are constructing is deterministic. *)
      let detmap = Array.init !nextvar (fun i -> trie_new()) in

      let string_of_reason (s,i,j) = "("^s^","^(string_of_int i)^","^(string_of_int j)^")" in
      let pr_reasons os rs =
	List.iter (fun r -> os " "; os (string_of_reason r)) rs
      in

      (* equivalence on ints *)
      let uf = Uf.mk_equiv !nextvar in
      let unionv i1 i2 r = 
	if i1 <> i2 then
	  (kon dbg 
	     (fun dbg ->
		let f i = 
		  dbg (string_of_int i);
		in

		  dbg "(union ";
		  f i1;
		  dbg " ";
		  f i2;
		  dbg ")\n");
	   Uf.union uf i1 i2 r)
	else
	  false
      in
      let union v1 v2 r = 
	let i1 = varint v1 in
	let i2 = varint v2 in
	  if i1 <> i2 then
	    (kon dbg 
	       (fun dbg ->
		  let f v i = 
		    dbg v;
		    dbg "(";
		    dbg (string_of_int (fst (Uf.find uf i)));
		    dbg ")"
		  in

		    dbg "(union ";
		    f v1 i1;
		    dbg " ";
		    f v2 i2;
		    dbg " by ";
		    pr_reasons dbg r;
		    dbg ")\n");
	     Uf.union uf i1 i2 r) 
	  else
	    false
      in

      let print_uf () = 
	kon dbguf
	  (fun dbg ->
	     dbg "(Union-find structure:\n";
	     Uf.print_equiv uf false dbg (fun i -> revvars.(i)^" ("^(string_of_int i)^")") string_of_reason;
	     dbg ")\n")
      in

      (* code to construct the run-rewriting system for the current
	 TRS with the current union-find structure *)
      let construct_rrs() = 
	let varint v = fst (Uf.find uf (varint v)) in
	  sort_rules 
	    (List.map
	       (fun (i,lhs,rhs,ot) -> 
		  (* for each parsing rewrite rule *)

		  (* this helper translates the part of the lhs
		     starting at index j from the left, into a list of
		     elements of the form (p1, t, s, p2), where t is
		     ast_type, s is the symbol, and p1 and p2 are
		     state pairs. *)
		  let rec helper j lhs = 
		    match lhs with
			[] -> []
		      | (t,s)::lhs' -> 
			  let pr j = (varint (prodvar forw i j), varint (prodvar backw i j)) in
			    (pr j, t, s, pr (j+1))::(helper (j+1) lhs')
		  in 
		  let lhs' = helper 0 lhs in
		  let pr d = (varint (ntvar forw d rhs), varint (ntvar backw d rhs)) in
		    (i,lhs',(pr 1, rhs, pr 2), ot))
	       ptrs)
      in
      let print_cur_rrs adbg = 
	kon adbg (fun adbg ->
		    adbg "The run-rewriting system is currently:\n";
		    print_rrs adbg (construct_rrs()))
      in

	(* now assert the required equalities *)

	print_cur_rrs dbg;
	wr dbg "(Adding equalities to connect nonterminals with the start and ends of the rhs's of their productions.)\n";

	(* assert the equalities between variables for nonterminals and the variables
	   at the start and end of the rhs's of their productions *)

	(* pind maps nonterminals to the prules where those nonterminals are on the rhs *)
	let pind = trie_new() in
	  List.iter
	    (fun x ->
	       let (i,lhs,rhs,_) = x in
	       let len_lhs = List.length lhs in
	       let a dir d j = let _ = union (ntvar dir d rhs) (prodvar dir i j) [] in () in
		 trie_cons pind rhs x;
		 a forw 1 0;
		 (* we do not need to say that all ways to create the rhs end in the same state (whether going
		    forward or backward).  So we do not need:
		    a backw 1 0;
		    a forw 2 len_lhs; *)
		 a backw 2 len_lhs)
	    ptrs;     
	  wr dbg "(Done adding equalities to connect nonterminals with the start and ends of the rhs's of their productions.)\n";
	  print_uf ();
	  print_cur_rrs dbg;
	  wr dbg "(Adding equalities to connect uses of nonterminals in rhs's of productions to the definitions of those nonterminals,\n";
	  wr dbg "and record constraints needed to enforce determinism.)\n";

	  (* assert the equalities between variables for nonterminals
	     and variables for positions where those nonterminals are
	     used in the lhs's of productions *)
	  let detstates = ref [] in
	    List.iter
	      (fun (i,lhs,rhs,_) ->
		 let rec helper j lhs = 
		   match lhs with
		       [] -> ()
		     | (_,s)::lhs' ->
			 let a dir d j' = let _ = union (ntvar dir d s) (prodvar dir i j') [(s,i,j')] in () in
			   if (is_nt s) then
			     (a forw 1 j; 
			      a forw 2 (j+1);
			      a backw 1 j; 
			      a backw 2 (j+1))
			   else
			     (* s is a terminal, so we need to update the detmap for forward and
				backward states *)
			     (let a dir j j' = 
				let v1 = varint (prodvar dir i j) in
				let v2 = varint (prodvar dir i j') in
				  kon dbg
				    (fun dbg ->
				       dbg "(need deterministic ";
				       dbg (dirlongstr dir);
				       dbg " edge from ";
				       dbg (string_of_int v1);
				       dbg " on ";
				       dbg s;
				       dbg " to ";
				       dbg (string_of_int v2);
				       dbg "\n");
				  detstates := v1 :: !detstates;
				  trie_cons detmap.(v1) s v2
			      in
				a forw j (j+1);
				a backw (j+1) j;
			     );
			   helper (j+1) lhs'
		 in
		   helper 0 lhs)
	      ptrs;
	    detstates := uniq compare !detstates;
	    
	    wr dbg "(Done adding equalities connecting uses of nonterminals to their definitions, and recording constraints for determinism.)\n";
	    print_uf ();
	    print_cur_rrs dbg;
	    wr dbg "(Now propagating equalities enforcing determinism until we see no change.)\n";

	    let changed = ref true in
	    let detstates = !detstates in 
	    let rec loop() = 
	      changed := false;
	      wr dbg "Looping through detstates.\n";
	      List.iter
		(fun v ->
		   let (v',r) = Uf.find uf v in
		     kon dbg (fun dbg -> 
				dbg "Considering state "; 
				dbg (string_of_int v); 
				dbg ", currently equal to "; 
				dbg (string_of_int v');
				dbg ".\n");
		     List.iter
		       (fun s ->
			  match trie_lookup detmap.(v) s with
			      None | Some([]) -> err "Internal error 1 in findaut."
			    | Some(v2::v2s) ->
				(* we now need to union all nodes in v2s and
				   all nodes which v' is mapped to by the detmap
				   with string s, with the node v2 *)
				let merge vs = 
				  List.iter
				    (fun v2' ->
				       changed := !changed || unionv v2' v2 r)
				    vs
				in
				  merge v2s;
				  match trie_lookup detmap.(v') s with
				      None -> trie_cons detmap.(v') s v2
				    | Some(v2s') ->
					merge v2s')
		       (trie_strings detmap.(v)))
		detstates;
	      if !changed then loop()
	    in
	      loop();
	      wr dbg "(Done propagating equalities enforcing determinism.)\n";
	      
	      Uf.uniquify_reasons uf compare;
	      
	      (* to avoid critical pairs, we need to satisfy certain disjunctions of disequalities between
		 states.  diseqs is the set of (representations of) such disjunctions that are false in
		 our current equivalence relation. *)
	      let diseqs = ref [] in
		List.iter
		  (fun c ->
		     let (ind,common,(_,_,_,_,_,r1,r2)) = c in
		     let Rule((id1,_),_,_) = r1 in
		     let Rule((id2,_),_,_) = r2 in
		     let lencommon = List.length common in (* ### seems to be off *)
		     let checkeq v1 v2 = 
		       kon dbguf (fun dbguf ->
				    dbguf "(Checking disequality between ";
				    dbguf v1;
				    dbguf " and ";
				    dbguf v2;
				    dbguf ")\n");
		       Uf.are_equiv uf (varint v1) (varint v2)
		     in
		       kon dbg (fun dbg -> 
				  dbg "(Checking disequalities for the following critical pair:\n";
				  pr_cp dbg c;
				  dbg ")\n");
		       match checkeq (prodvar forw id1 ind) (prodvar forw id2 0) with
			   None -> ()
			 | Some(r) ->
			     match checkeq (prodvar backw id1 (ind+lencommon)) (prodvar backw id2 lencommon) with
				 None -> ()
			       | Some(r') -> (* record the pair of reasons that the two disequalities fail to hold *)
				   diseqs := (ind, common, r1, r2, r , r') :: !diseqs)
		  parsing_cps;
		wr dbguf "(Done checking disequalities)\n";
		let to_char s = 
		  let s = (unquote s) in
		    if s = "\\t" then '\t'
		    else if s = "\\\\" then '\\'
		    else if s = "\\n" then '\n'
		    else if String.length s <> 1 then
		      err ("internal error mapping terminal '"^s^"' to a character.")
		    else
		      s.[0]
		in
		let varint v = fst (Uf.find uf (varint v)) in
		let construct_aut dir = 
		  let trans = ref [] in
		    List.iter
		      (fun (i,lhs,rhs,_) ->
			 let rec helper j lhs = 
			   match lhs with
			       [] -> ()
			     | (_,s)::lhs' ->
				 let edge j j' = (varint (prodvar dir i j), to_char s, varint (prodvar dir i j')) in
				 let j' = j+1 in
				 if is_ter s then
				   trans := (if dir = forw then edge j j' else edge j' j)::!trans;
				 helper j' lhs'
			 in
			   helper 0 lhs)
		      ptrs;
		    let (s,f) = (varint (ntvar dir 1 start_symbol),varint (ntvar dir 2 start_symbol)) in
		    let (s,f) = if dir = forw then (s,f) else (f,s) in
		      (s, uniq compare !trans, f)
		in
		let faut = construct_aut forw in
		let baut = construct_aut backw in

		  write_aut_dot (name^"_forward") string_of_int faut;
		  write_aut_dot (name^"_backward") string_of_int baut;

		  if nonempty !diseqs then
		    (
		      (* compute the transitive closure of the tree computed by compute_after.
			 So after will map nonterminal s to all those nonterminals s' which it can
			 generate (i.e., where s ->* w s' w'), but which cannot generate it. *)
		      let rnd' = rnd+1 in
		      let stopping = rnd' >= !max_rounds in
		      let dbgh = if stopping then dbgtop else dbg in
		      let after = compute_after is_nt ptrs in
			kon dbgh
			  (fun dbgh ->
			     dbgh "(The one-step after graph:\n";
			     print_trie dbgh (print_strings dbgh " ") after;
			     dbgh ")\n");
			let after = list_trie_tc_tree after in
			let is_after s s' = 
			  match trie_lookup after s with
			      None -> false
			    | Some(ss) -> List.mem s' ss 
			in
			let rename_nt s i j = s^"."^(string_of_int i)^"_"^(string_of_int j) in
			let modrls = Array.make !len_ptrs [] in
			let newrls = ref [] in
			  kon dbgh
			    (fun dbgh ->
			       dbgh "(The after graph:\n";
			       print_trie dbgh (print_strings dbgh " ") after;
			       dbgh ")\nOur automata could not resolve some critical pairs.\n");
			  print_uf();
			  print_cur_rrs dbgh;
			  let reasons = ref [] in
			  let sort_reasons =
			    (* sort in increasing order according to the after ordering above,
			       and for equal nonterminals (same equivalence class, including if they are
			       the same nonterminal), sort so as to prefer occurrences in longer lhs's *)
			    uniq 
			      (fun (s,i,j) (s',i',j') -> 
				 if (is_after s s') then
				   -1 (* s is greater *)
				 else if (is_after s' s) then
				   1 (* s' is greater *)
				 else
				   match rind.(i), rind.(i') with
				       Some(_,lhs,_,_), Some(_,lhs',_,_) ->
					 let len1 = List.length lhs in
					 let len2 = List.length lhs' in
					   compare len2 len1
				     | _ , _ -> err "Internal error 2 in findaut")
			  in
			    List.iter
			      (fun (ind,common,r1,r2,r,r') ->
				 (* for each false disequality *)
				 let rs = sort_reasons (r @ r') in
				   kon dbgh
				     (fun dbgh ->
					let Rule((id1,_),_,_) = r1 in
					let Rule((id2,_),_,_) = r2 in
					  dbgh "(The overlap of rules ";
					  dbgh (string_of_int id1);
					  dbgh " and ";
					  dbgh (string_of_int id2);
					  dbgh " -- which is ";
					  dbgh (string_of_int ind);
					  dbgh " symbols into rule ";
					  dbgh (string_of_int id1);
					  dbgh " on substring ";
					  print_strings dbgh " " common;
					  dbgh " -- cannot be prevented.\n";
					  dbgh "The combined reasons are:\n ";
					  pr_reasons dbgh rs;
					  dbgh ")\n");	 
				   let select_reason rs = 
				     let common_rs = List.filter (fun (s,i,j) -> List.mem s common) rs in
				       List.hd (if nonempty common_rs then common_rs else rs)
				   in
				     reasons := (select_reason rs) :: !reasons)
			      !diseqs;
			    
			    let reasons = sort_reasons !reasons in
			      List.iter
				(fun (s,i,j) ->

				   (* copy the rules for nonterminal s, and use modrls to record the fact that we should
				      rename the occurrence (of s) at position j in rule i *)
				   
				   let s' = rename_nt s i j in
				     stringset_add nts s'; (* add new symbol to table of nts *)
				     
				     match trie_lookup pind s with
					 None -> err "Internal error 3 in findaut"
				       | Some(rls) ->
					   (* rls is the list of rules with s on the rhs *)
					   stringset_add nts s';
					   modrls.(i) <- (s,j)::modrls.(i); 
					   newrls := (List.map (fun (i',lhs,rhs,ot) -> 
								  let i'' = !len_ptrs in
								    (* rename any occurrence of s in the lhs of the new rule to s' *)
								  let lhs' = List.map (fun (d,s1) -> 
											 (d, if s = s1 then s' else s1)) lhs in
								    incr len_ptrs;
								    (i'',lhs',s',ot)) rls) @ !newrls;
				)
				reasons;
			      
			      (* rename nonterminals in the rules according to modrls *)
			      let ptrs' = 
				List.map
				  (fun x ->
				     let (i,lhs,rhs,ot) = x in
				     let rec update cur js lhs = 
				       match js,lhs with
					   [],_ -> lhs
					 | _::_,[] -> err "Internal error 4 in findaut"
					 | (s,j)::js',(q,x)::lhs' -> 
					     if x = s && (cur = j || cur+1 = j) then
					       (q,rename_nt x i j)::(update (cur+1) js' lhs')
					     else
					       (q,x)::(update (cur+1) js lhs')
				     in
				     let js = uniq (fun (s,j) (s',j') -> 
						      let lhs' = List.map (fun (q,x) -> x) lhs in
							compare (list_pos s lhs') (list_pos s' lhs')) modrls.(i) in
				       kon dbgh
					 (fun dbgh ->
					    if nonempty js then
					      (dbgh "(Renaming nonterminals at positions ";
					       List.iter (fun (s,j) -> dbgh " ("; dbgh s; dbgh ","; dbgh (string_of_int j); dbgh ")") js;
					       dbgh " of rule ";
					       dbgh (string_of_int i);
					       dbgh ")\n"));
				       (i,update 0 js lhs, rhs, ot))
				  ptrs
			      in
				
				if stopping then
				  err "We could not construct an automaton for the grammar; see report.txt.\n"
				else
				  wr dbg "Refining the parsing TRS to try to avoid the above violations.\n";
				round rnd' (ptrs' @ (sort_rules !newrls))
		    )
		  else
		    (kon dbgtop
		       (fun dbgtop ->
			  dbgtop "We constructed automata resolving all the nondeterminism in the grammar.\n");
		     
		     let the_rrs = construct_rrs() in
		       
		       (faut,baut,the_rrs))
  in
    round 0 ptrs
;;


