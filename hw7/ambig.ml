(* test an nfa for ambiguity *)

open Aut;;
open Parsing_trs;;
open Trie;;
open Util;;

let dbg_ambig = ref false;;

(* return Some(s) iff s has two accepting runs in n; otherwise, return
   None. We assume d is a dfa for n. The algorithm is to count the number of
   runs in n of every loop-free path in d. *)
let test_ambiguity(aut : nfa) : string list option = 
  let dbg = debugger dbg_ambig in
  let (sm,next,eps) = aut in
  let (tbl,revtbl) = sm in
  let explored = inttrie_new() in
  
  let rec explore(a : int)(b : int)(diff : bool)(prevstr : int list) : string list option =
    kon 
      dbg
      (fun dbg ->
	dbg "(explore ";
	dbg (string_of_int a);
	dbg " ";
	dbg (string_of_int b);
	dbg " ";
	dbg (string_of_bool diff);
	dbg " ";
	print_syms dbg sm prevstr;
	dbg "\n");
    let ret = 
      if inttrie_contains explored [ a ; b ] then
	None
      else
	(inttrie_insert explored [ a ; b ] ();
	 if eps_final aut a && eps_final aut b && diff then
	   Some(List.map (fun x -> revtbl.(x)) (List.rev prevstr))
	 else
	   match next.(a) , next.(b) with
	     Some(sym,a') , Some(sym',b') ->
	     if sym = sym' then
	       explore a' b' (diff || a <> b) (sym :: prevstr)
	     else
	       None
	   | None , _ ->
	      let rec try_epss(aa : int list) : string list option =
		match aa with
		  [] -> None
		| a' :: aa' -> 
		   match explore a' b diff prevstr with
		     None -> try_epss aa'
		   | Some(l) -> Some(l)
	      in
	      try_epss eps.(a)
	   | _ , None ->
	      let rec try_epss(bb : int list) : string list option =
		match bb with
		  [] -> None
		| b' :: bb' -> 
		   match explore a b' diff prevstr with
		     None -> try_epss bb'
		   | Some(l) -> Some(l)
	      in
	      try_epss eps.(b))
    in
    wr dbg ")\n";
    ret
  in
  explore start_state start_state false []
;;
