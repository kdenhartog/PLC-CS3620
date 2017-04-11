open Localconf;;
open Parsing_trs;;
open Rewriting;;
open Sccs;;
open Term;;
open Trs;;
open Trie;;
open Util;;
open Rewrite_rules;;

module OrderedInt =
struct
  type t = int
  let compare (x:int) (y:int) = compare x y
end;;

module IntMap = Map.Make(OrderedInt);;

let dbg_gen_aut = ref false;;
let dbg_gen_aut_micro = ref false;;
let skip_unambiguity_check = ref true;; (* it is not clear the ambiguity check is correct, so skip it *)

type parsing_cp = (int * (string list) * Localconf.cp);;

(* test confluence of prs modulo the first together with the second
   trs.  The tuples (ind,common,cp) returned show the index into the
   left-overlapping rule at which a nontrivial common substring was
   found with the right-overlapping rule, giving rise to the given
   cp.  *)
let locally_confluent dbgtop (Trs(prs)) (Trs(rs)) : (parsing_cp list) =
  let dbg = debugger Localconf.dbg_local_conf in
  let dbgm = debugger Localconf.dbg_local_conf_micro in
  
  wr dbgtop "(Analyzing the rewriting rules for local confluence:\n";
  
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
	 lhs of r to (ind,pos,r), for each rule r, where ind is the
	 index into the lhs where the suffix starts, and pos is a
	 position representing that index (for benefit of
	 Localconf). *)
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
       trie_print dbgm (List.iter (print_pos_rule dbgm)) index;
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

       let lhs_str = (String.concat " " (right_strs_no_dot lhs)) in
       kon dbgm
	   (fun dbgm ->
	    dbgm "(Looking up the following string in the index:\n";
	    dbgm lhs_str;
	    dbgm ")\n");
       let overlapping = (List.concat
			    ((* overlaps where a prefix of lhs_str is (exactly) mapped by the trie *)
			      (List.map (fun (pref,rs) ->
					 List.map (fun r -> (pref,r)) rs)
					(trie_lookup_prefix index lhs_str))
			      @ (* overlaps where an extension of lhs_str is mapped by the trie *)
				(List.map (fun rs -> List.map (fun r -> (lhs_str,r)) rs)
					  (trie_lookup_extension index lhs_str))))
       in
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

let rtn_check_unambiguity sr mr rr nts start_symbol ind dbg is_nt same_scc = 
  let trie_trie_contains t s d =
    match trie_lookup t s with
    | Some(t') -> trie_contains t' d
    | None -> false
  in

  let gt_trie = trie_new() in
  
  let rec construct_gt nt seen =
    match trie_lookup gt_trie nt with
    | None -> 
       let t = trie_new() in
       trie_insert seen nt true;
       List.iter (
	   fun (_,r,_,_) -> (
	     List.iter (
		 function
		 | (_,x) -> 
		    if is_nt x && not (trie_contains t x) && not (trie_contains seen x) then (
		      if same_scc x nt then (
			wr dbg "Merging ";
 			wr dbg x;
			wr dbg "\n";
			List.iter (fun y -> trie_insert t y true) (trie_strings (construct_gt x seen))
		      )
		      else (
			wr dbg "Constructing ";
			wr dbg x;
			wr dbg "\n";
			trie_insert t x true;
			List.iter (fun y -> trie_insert t y true) (trie_strings (construct_gt x (trie_new())))
		      )
		    )
	       ) r;
	   )
	 ) (list_trie_lookup ind nt);
       
       List.iter (
	   fun nt -> trie_insert gt_trie nt t;
	 ) (trie_strings seen);

       t
    | Some(t') -> t'
  in
  
  let _ = construct_gt start_symbol (trie_new()) in
  
  wr dbg "\nChildren mappings:\n";
  List.iter (
      fun nt -> (
	wr dbg nt;
	wr dbg ":\t";
	(match trie_lookup gt_trie nt with
	 | None -> ()
	 | Some(t) -> List.iter (fun nt -> wr dbg nt; wr dbg " ") (trie_strings t));
	wr dbg "\n";
      )
    ) nts;
  wr dbg "\n\n\n\n";
  
  let suc frame = 
    match frame with
    | (id,call,pos,[]) -> frame
    | (id,call,pos,r::rs) -> (id,call,pos+1,rs)
  in
  
  let splice_hist f fs = 
    let (_,nt,_,_) = f in
    let rec aux = function
      | (_,nt',_,_)::xs ->
	 if nt = nt' then
	   f :: xs
	 else if same_scc nt nt' then
	   aux xs
	 else 
	   f :: fs
      | [] -> f :: fs
    in
    aux fs
  in

  let key frame = 
    let (id,_,pos,_) = frame in id ^ "," ^ (string_of_int pos)
  in
  

  let rec print_tabs n =
    if n > 0 then (
      wr dbg " ";
      print_tabs (n-1)
    )    
  in
  
  let visited = trie_new() in
  



  let rec search frames frames' tabs actRead actDiff mem = 
    match (frames,frames') with
    | (f::fs ,f'::fs') ->
       let (_,call,_,rule) = f in
       let (_,call',_,rule') = f' in
       let key1 = key f in
       let key2 = key f' in
       let hkey = key1 ^ ";" ^ key2 in
       print_tabs tabs;
       wr dbg hkey;
       wr dbg "\t";
       wr dbg "\n";
       if f = f' then
	 search fs fs' (tabs+1) actRead actDiff mem
       else if trie_contains mem hkey then
	 false
       else (
	 trie_insert mem hkey true;
	 match (rule, rule') with
	 | ((_,r)::rs, (_,r')::rs') ->
	    (match (is_nt r, is_nt r') with 
	     | (true, true) -> 
		if r = r' then 
		  search ((suc f)::fs) ((suc f')::fs') (tabs+1) true actDiff (trie_new())
		  || List.exists ( 
			 fun (pid,plhs,prhs,_) -> ( 
			   let newf = (pid,prhs,0,plhs) in 
			   search (splice_hist newf ((suc f)::fs)) (frames') (tabs+1) actRead actDiff mem
			 )
		       ) (list_trie_lookup ind r) 
		  || List.exists ( 
			 fun (pid',plhs',prhs',_) -> ( 
			   let newf' = (pid',prhs',0,plhs') in 
			   search (frames) (splice_hist newf' ((suc f')::fs')) (tabs+1) actRead actDiff mem
			 ) 
		       ) (list_trie_lookup ind r')
		else if trie_trie_contains gt_trie r r' then
		  List.exists ( 
		      fun (pid,plhs,prhs,_) -> ( 
			let newf = (pid,prhs,0,plhs) in 
			search (splice_hist newf ((suc f)::fs)) frames' (tabs+1) actRead true mem
		      )
		    ) (list_trie_lookup ind r) 
		else if trie_trie_contains gt_trie r' r then 
		  List.exists ( 
		      fun (pid',plhs',prhs',_) -> ( 
			let newf' = (pid',prhs',0,plhs') in 
			if f' = newf' then 
			  false 
			else 
			  search frames (splice_hist newf' ((suc f')::fs')) (tabs+1) actRead true mem
		      ) 
		    ) (list_trie_lookup ind r') 
		else if trie_contains visited (r ^ ";" ^ r') then (
		  wr dbg "inc1\n";
		  false (* incomplete *)
		)
		else if same_scc r r' then (
		  wr dbg "inc2\n";
		  false (* incomplete *)
		)
		else (
		  trie_insert visited (r ^ ";" ^ r') true; 
		  trie_insert visited (r' ^ ";" ^ r) true; 
		  List.exists ( 
		      fun (pid,plhs,prhs,_) -> ( 
			let newf = (pid,prhs,0,plhs) in 
			List.exists ( 
			    fun (pid',plhs',prhs',_) -> ( 
			      let newf' = (pid',prhs',0,plhs') in 
			      search (splice_hist newf ((suc f)::fs)) (splice_hist newf' ((suc f')::fs')) (tabs+1) actRead true (trie_new())
			    ) 
			  ) (list_trie_lookup ind r') 
		      ) 
		    ) (list_trie_lookup ind r) 
		) 
	     | (true, false) -> 
		List.exists ( 
		    fun (pid,plhs,prhs,_) -> ( 
		      let newf = (pid,prhs,0,plhs) in 
		      search (splice_hist newf ((suc f)::fs)) frames' (tabs+1) actRead true mem
		    ) 
		  ) (list_trie_lookup ind r) 
	     | (false, true) -> 
		List.exists ( 
		    fun (pid',plhs',prhs',_) -> ( 
		      let newf' = (pid',prhs',0,plhs') in 
		      search frames (splice_hist newf' ((suc f')::fs')) (tabs+1) actRead true mem
		    ) 
		  ) (list_trie_lookup ind r') 
	     | (false, false) -> 
		if r = r' then 
		  search ((suc f)::fs) ((suc f')::fs') (tabs+1) true actDiff (trie_new())
		else 
		  false 
	    )

	 | (z::zs, []) -> 
	    List.exists (
		fun f -> search frames (splice_hist f frames') (tabs+1) actRead actDiff mem
	      ) (list_trie_lookup rr call') 
	    || if fs' = [] then (
		 List.exists (
		     fun f -> search (frames@[f]) [f] (tabs+1) actRead actDiff mem
		   ) (list_trie_lookup mr call')
	       ) 
	       else 
		 search frames fs' (tabs+1) actRead actDiff mem
	 | ([], z::zs) -> 
	    List.exists (
		fun f -> search (splice_hist f frames) frames' (tabs+1) actRead actDiff mem
	      ) (list_trie_lookup rr call) 
	    || if fs = [] then (
		 List.exists (
		     fun f -> search [f] (frames'@[f]) (tabs+1) actRead actDiff mem
		   ) (list_trie_lookup mr call)
	       ) 
	       else 
		 search fs frames' (tabs+1) actRead actDiff mem
	 | ([], []) -> 
	    (* we can pop the frame off without searching any
	       further, because this ambiguity would be found by later
	       searches *)
	    search fs frames' (tabs+1) actRead actDiff mem || search frames fs' (tabs+1) actRead actDiff mem
       )

    | ([], []) -> (
      wr dbg "Reached an end\n";
      if actRead && actDiff then 
	wr dbg "AMBIG\n";
      actRead && actDiff
    )
    | _ -> false
  in

  
  let ambig = List.filter (
		  fun nt -> (
		    List.exists (
			fun ((id,lhs,rhs,_), (id',lhs',rhs',_)) -> (
			  wr dbg "Checking non-terminal ";
			  wr dbg nt;
			  wr dbg " productions ";
			  wr dbg id;
			  wr dbg " and ";
			  wr dbg id';
			  wr dbg "\n";
			  lhs = lhs' || search [(id,rhs,0,lhs)] [(id',rhs',0,lhs')] 0 false true (trie_new())
			)
		      ) (pairify (list_trie_lookup ind nt))
		  )
		) nts 
  in

  if List.length ambig > 0 then
    err "Ambiguity, see report file";

  let ambig = List.filter (
		  fun nt -> (
		    List.exists (
			fun f -> (
			  let (id,call,pos,_) = f in
			  List.exists (
			      fun f' -> (
				let (id',call',pos',_) = f' in
				wr dbg "Checking non-terminal ";
				wr dbg nt;
				wr dbg " memless return (";
				wr dbg id;
				wr dbg ", ";
				wr dbg (string_of_int pos);
				wr dbg ") and mem return (";
				wr dbg id';
				wr dbg ", ";
				wr dbg (string_of_int pos');
				wr dbg ")\n";
				search [f;f'] [f'] 0 false false (trie_new())
			      )
			    ) (list_trie_lookup mr nt)
			)
		      ) (list_trie_lookup rr nt)
		  )
		) nts;
  in

  if List.length ambig > 0 then
    err "Ambiguity, see report file";

  let ambig = List.filter (
		  fun nt -> (
		    List.exists (
			fun (f, f') -> (
			  let (id,_,pos,_) = f in
			  let (id',_,pos',_) = f' in
			  wr dbg "Checking non-terminal ";
			  wr dbg nt;
			  wr dbg " memless return (";
			  wr dbg id;
			  wr dbg ", ";
			  wr dbg (string_of_int pos);
			  wr dbg ") and memless return (";
			  wr dbg id';
			  wr dbg ", ";
			  wr dbg (string_of_int pos');
			  wr dbg ")\n";
			  search [f] [f'] 0 false false (trie_new())
			)
		      ) (pairify (list_trie_lookup rr nt))
		  )
		) nts 
  in

  if List.length ambig > 0 then
    err "Ambiguity, see report file";


;;


let find_nullpaths nulltrie =
  
  let conflicts = ref [] in
  let collapse = ref [] in
  
  let rec search orig_nt cur_nt context thru_prod path =
    if trie_contains path cur_nt then (
      if cur_nt = orig_nt then
	if thru_prod then
	  conflicts := (orig_nt, context)::!conflicts
	else 
	  collapse := (orig_nt, context)::!collapse

    )
    else (
      trie_insert path cur_nt true;
      List.iter (
	  fun (nt', context') -> search orig_nt nt' (cur_nt::context) (thru_prod || context' <> []) path
	) (list_trie_lookup nulltrie cur_nt);
    )
  in
  
  List.iter (
      fun nt -> search nt nt [] false (trie_new())
    ) (trie_strings nulltrie);
  
  (!conflicts, !collapse)	    
;;
  
let to_rrs (ptrs : parsing_trs) pch nbi =
  let rec convert_rule = function
    | ((a,b)::xs) -> SymElt(a,b) :: convert_rule xs
    | [] -> []
  in
  
    List.map (
	fun (id,lhs,rhs,ot) -> (
	  let hd = Id(id) in
	  let tl = Id(id ^ "_end") in
	  match (pch rhs lhs), (nbi rhs lhs) with
	  | true,true -> (id,(convert_rule lhs)@[tl],rhs,ot)
	  | true,false -> (id,(convert_rule lhs),rhs,ot)
	  | false,true -> (id,hd::(convert_rule lhs)@[tl],rhs,ot)
	  | false,false -> (id,hd::(convert_rule lhs),rhs,ot)
	)
      ) ptrs

;;


let gen_rtn (dbgtop:debugger_t)(name:string)(start_symbol:string)(ptrs:parsing_trs)(reorg_trs:trs)(ters:stringset)  =
  let dbg = debugger dbg_gen_aut in
  (*let dbgm = debugger dbg_gen_aut_micro in*)
  let dbgc = debugger Localconf.dbg_cps in 

  if empty ptrs then
    err "The grammar has no productions";
  
  let ind = index_ptrs ptrs in
  let nts = trie_strings ind in

  let (is_regular,scc_num,sccs) = compute_nt_info ind ptrs in
  let nullable_nts = get_nullable_nts ptrs dbgtop in
  let prenull = get_empty_scc_refs nullable_nts scc_num ptrs dbgtop in
  let (pre_conflicts, pre_collapse) = find_nullpaths prenull in
  
  if pre_conflicts <> [] then (
    wr dbg "Pre-Conflicts:\n";
    List.iter (
	fun (nt, cont) -> (
	  wr dbg nt;
	  wr dbg " from context ";
	  List.iter (
	      fun nt' -> (
		wr dbg nt';
		wr dbg ", ";
	      )
	    ) cont;
	  wr dbg "\n";
	)
      ) pre_conflicts;
    err "Epsilon cycles in grammar";
  );

  let pre_rings = find_sccs pre_collapse in
  let pre_ring_scc_num = trie_new() in
  
  wr dbg "\n\nThe following collapse cycles were detected in the grammar: \n\n";
  wr dbg "\tPre cycles: \n";
  iteri (
      fun i l -> (
	wr dbg "\t(";
	List.iter (
	    fun e -> (
	      trie_insert pre_ring_scc_num e i;
	      wr dbg e;
	      wr dbg ", ";
	    )
	  ) l;
	wr dbg ")\n";
      )
    ) pre_rings;
  wr dbg "\n\n";

  let is_nt nt = trie_contains ind nt in
  let same_scc nt1 nt2 = scc_num nt1 = scc_num nt2 in
  let pre_cyc_num nt = 
    match trie_lookup pre_ring_scc_num nt with
    | Some(n) -> n
    | None -> -1
  in
  let same_pre_cyc nt1 nt2 = let num1 = pre_cyc_num nt1 in num1 <> -1 && num1 = pre_cyc_num nt2 in

  let rec pre_cyc_head nt = function
    | [] -> false
    | (_,x) :: xs -> same_pre_cyc nt x
  in
  
  let sr,mr,rr,tl =
    let sr = trie_new() in
    let mr = trie_new() in
    let rr = trie_new() in
    let tl = trie_new() in

    List.iter (
	fun (id,lhs,rhs,t)  -> (
	  let r = (id,rhs,0,lhs) in
	  if not (pre_cyc_head rhs lhs) then
	    trie_cons sr rhs r
	  else (
	    trie_cons tl rhs r
	  );
	  let rec aux n = function
	    |  (_,x)::xs ->
		let r = (id,rhs,(n+1),xs) in
		if is_nt x then (
		  if same_scc rhs x then (
		    if xs <> [] then
		      trie_cons rr x r
		  )
		  else
		    trie_cons  mr x r
		);
		aux (n+1) xs
	    | _ -> ()
	  in
	  aux 0 lhs
	)
      ) ptrs;  

    sr,mr,rr,tl
  in

  let tail_rec r =
    let rec aux = function
      | (_,x)  :: xs ->
	 if trie_contains tl x then
	   Some(x)
	 else if trie_contains nullable_nts x then
	   aux xs
	 else
	   None
      | [] -> None
    in
    aux (List.rev r)
  in

  let needs_back_id nt r =
    match tail_rec r with
    | None -> false
    | Some(x) -> not (same_scc x nt && trie_contains tl nt)
  in

  if not (!skip_unambiguity_check) then
    rtn_check_unambiguity sr mr rr nts start_symbol ind dbg is_nt same_scc;

  let put pred arg = if pred then Some(arg) else None in

  let sr = List.map (fun s -> s, List.map (fun (id,rhs,p,lhs) -> (put (not (pre_cyc_head rhs lhs)) id, put (needs_back_id rhs lhs) (id ^ "_end"), lhs)) (list_trie_lookup sr s)) (trie_strings sr) in
  let tl = List.map (fun s -> s, List.map (fun (id,rhs,p,lhs) -> (None, put (needs_back_id rhs lhs) (id ^ "_end"), List.tl lhs)) (list_trie_lookup tl s)) (trie_strings tl) in


  let rrs = to_rrs ptrs pre_cyc_head needs_back_id in
  let unit_rrs = List.filter (fun (_,r,_,_) -> List.length r < 2) rrs in
  let lendec_rrs = List.filter (fun (_,r,_,_) -> List.length r > 1) rrs in

  let trs = Rewrite_rules.to_trs rrs in 
  let _ = (kon dbgtop
	       (fun dbg ->
		dbg ")\n(The parsing TRS that arises from the final automaton:\n";
		Parsing_trs.print_parsing_trs dbg ptrs;
		dbg ")\n(The TRS corresponding to the final parsing TRS:\n";
		print_trs dbg trs;
		dbg ")\n")) in

  (******************************************************************)
  (* now check the run-rewriting system for confluence              *)
  (******************************************************************)

  let cps = locally_confluent dbgc trs reorg_trs in
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
    kon dbgtop
	(fun dbg ->
	 if empty cps then
	   (dbg "(No ";
	    dbg name;
	    dbg " critical pairs found.)\n")
	 else
	   (dbg "(";
	    dbg (string_of_int (List.length cps));
	    dbg " ";
	    dbg name;
	    dbg " critical pairs found:\n";
	    List.iter (pr_cp dbg) cps;
	    dbg ")\n"))
  in
  let _ = 
    let check rule_kind cps = 
      pr_cps rule_kind cps;
      if nonempty cps then
	err ("The "^rule_kind^" rules have critical pairs that need additional reorganizing rules to resolve (see "
	     ^name^"_report.txt for details).");
    in
    check "reorganizing" reorg_cps;
    check "parsing" parsing_cps;
  in

  wr dbg "Ending generation of automaton from the parsing TRS (grammar).)\n";

  (*kon dbg
      (fun dbg ->
       dbg "(The parsing TRS consists of:\n(Unit rules:\n";
       Parsing_trs.print_parsing_trs dbg unit_ptrs;
       dbg ")\n(Length-decreasing rules:\n";
       Parsing_trs.print_parsing_trs dbg len_decreasing_ptrs;
       dbg ")\n");*)

  (lendec_rrs,unit_rrs,scc_num,sr,tl,nts)
;;
  
  
 
