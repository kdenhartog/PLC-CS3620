open Ambig;;
open Aut;;
open Parsing_trs;;
open Trie;;
open Util;;

let dfa_from_grammar(gname:string)(start:string)(ptrs:parsing_trs)(ters:stringset) : unit =
  let dbg = debugger dbg_gen_aut in
  let n = build_nfa start ptrs ters in
  
  (* print the nfa *)
  let pr_nfa name n = 
    kon dbg (fun dbg ->
	      print_nfa dbg name n);
    write_nfa_dot name n
  in

  pr_nfa gname n;
  
  let n = collapse_cycles n in
  
  pr_nfa (gname^"Collapsed") n;

  flush stdout;

  let d = nfa_to_dfa n in

  kon dbg (fun dbg -> print_dfa dbg (gname^"Det") d);
  
  write_dfa_dot (gname^"Det") d;

  (match test_ambiguity n with
     None -> wr dbg "The collapsed NFA is not ambiguous.\n"
   | Some(s) -> kon dbg
		    (fun dbg ->
		      dbg "The collapsed NFA is ambiguous, on the following string: ";
		      print_strings dbg " " s;
		      dbg "\n"));


;;
