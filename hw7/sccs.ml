open Parsing_trs;;
open Trie;;
open Util;;

let dbg_sccs = ref false;;

(* This uses an algorithm from Cormen, Leiserson, and Rivest (CLR): do
   a depth-first search of the graph, recording vertices whenever
   exploration of their out-edges finishes; then do a second DFS on
   the inverse of the original graph, starting with the vertices that
   finished last in the first DFS search.  The resulting forest is
   proved in CLR to consist of SCCs. *)
let find_sccs (edges: (string * string list) list) : string list list =
  (* edge(x,y) holds iff there is a production x -> ... y ..., with y a nonterminal, 
     represented in ptrs. *)

  (* compute the graph and its inverse *)
  let edge_trie = trie_new() in
  let rev_edge = trie_new() in
  List.iter (fun (anc, children) -> 
	     trie_append edge_trie anc children;
	     List.iter (fun s -> trie_cons rev_edge s anc) children
	    ) edges;
  let mark = trie_new() in
  let finished = ref [] in

  let rec dfs (r:string list trie) (s:string) : unit =
    if not (trie_contains mark s) then
      (stringset_add mark s;
       List.iter (dfs r) (list_trie_lookup r s);
       finished := s::!finished)
  in

  let nodes = trie_strings edge_trie in
  List.iter (dfs edge_trie) nodes;
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

  !sccs
;;


let find_ptrs_sccs (is_nt:string -> bool) (ptrs:parsing_trs) : string list list =
  let rec compute_edges acc = function
    | (_,lhs,rhs,ot)::ps -> 
       let rec get_lhs_nts = function
	 | (_,s)::ss' ->
	    let r = get_lhs_nts ss' in
	    if is_nt s then
	      s::r
	    else
	      r
	 | [] -> []
       in
       let lhs_nts = get_lhs_nts lhs in
       compute_edges ((rhs, lhs_nts)::acc) ps
    | [] -> acc
  in
  
  find_sccs (compute_edges [] ptrs)
;;

(* return functions (1) telling whether a nonterminal is regular or not
   and (2) returning the same number for each member of a SCC in the
   generation graph of the grammar.  Also return the SCCs. *)
let compute_nt_info (ind : prule list trie) (ptrs : parsing_trs) : (string -> bool) * (string -> int) * (string list list) =
  let dbgm = debugger dbg_sccs in

  let (regular,scc_nums,sccs) =
    let generating (left:bool) (scc:string list) : bool =
      let scc_set = stringset_of_strings scc in
      let helper (id,lhs,_,ot) : bool = 
	match lhs with
	  [] -> false
	| x::lhs' ->
	   let lhs' = 
	     if left then
	       lhs'
	     else
	       let (lhs',_) = split_list_last lhs in
	       lhs'
	   in
	   List.exists (fun elt -> 
			match elt with
			| (_,s) -> trie_contains scc_set s) lhs'
      in
      (* look for a side of a rule with rhs in scc which satisfies the helper *)
      List.exists helper (List.concat (List.map (list_trie_lookup ind) scc))
    in
    let sccs = find_ptrs_sccs (trie_contains ind) ptrs in
    let scc_nums = trie_new() in
    let regular = trie_new() in 
    let next_scc = ref 0 in
    wr dbgm "(The SCCs of the grammar:\n";
    List.iter
      (fun scc -> 
       let sccnum = !next_scc in
       kon dbgm
	   (fun dbgm ->
	    dbgm "  ("; print_strings dbgm " " scc; dbgm "): ");
       incr next_scc;
       List.iter (fun s -> trie_insert scc_nums s sccnum) scc;
       let leftgen = generating true scc in
       let rightgen = generating false scc in
       let p b s = 
	 wr dbgm (if b then s else "not "^s);
	 wr dbgm "Generating "
       in
       p leftgen "Left";
       p rightgen "Right";
       wr dbgm "\n";
       if not leftgen || not rightgen then
	 List.iter (stringset_add regular) scc;
      )
      sccs;
    wr dbgm ")\n";
    (regular,scc_nums,sccs)
  in

  (* return -1 if we do not have an scc number -- this should only happen if sym is a terminal. *)
  let get_scc_num sym = 
    match trie_lookup scc_nums sym with None -> -1 | Some(i) -> i 
  in

  let is_regular sym =
    trie_contains regular sym
  in
 
  (is_regular, get_scc_num, sccs)
;;
