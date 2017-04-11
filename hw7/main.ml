open Arg;;
open Util;;
open Trie;;
open Compile_agda;;

let infile = ref stdin;;
let dbg_overall = ref true;;
let print_rr_terms = ref false;;
let print_parse_seq = ref false;;
let rewrite_rules_only = ref false;;
let continue_with_nonterminating = ref false;;
let skip_analyses = ref false;;
let compute_dfa = ref false;;

let set_infile a =
  Gra2srs_util.fname := a; 
  infile := open_in a
;;

let parse_tree : Term.term option ref = ref None;;

let usage = "Usage: gratr [options] <file>\n";;

let analysis_options =
    ["--rewrite-rules-only", Set rewrite_rules_only,
     " Stop after analyzing the rewriting rules (in the Rules) section for termination and local confluence.\n";
     "--continue-with-nonterminating", Set continue_with_nonterminating,
     " Continue even if we cannot confirm that the rewriting rules are terminating.\n";
     "--skip-analyses", Set skip_analyses,
     " Skip the analyses of the rewrite rules.\n";
     "--print-raw",               Set Term.print_raw, 
     " Print terms in a raw form.";
     "--no-eos", Set Grammar.no_eos, 
     " Do not add _sos and _eos symbols for the start and end of the input string (default is to add them).";
     "--debug-rewriting", Set Localconf.dbg_rewriting,
     " Debug rewriting during local-confluence testing.";
     "--debug-local-confluence", Set Localconf.dbg_local_conf,
     " Debug local-confluence testing.";
     "--debug-local-confluence-micro", Set Localconf.dbg_local_conf_micro,
     " Micro-level debugging of local-confluence testing.";
     "--debug-cps", Set Localconf.dbg_cps,
     " Debug the computation of critical pairs in local-confluence testing.";
     "--no-debug-overall", Clear dbg_overall, 
     " Do not write to the report file for the overall process of analysis.";
     "--debug-convert-grammar", Set Parsing_trs.dbg_convert_grammar, 
     " Debug the conversion of a grammar to a TRS.";
     "--debug-grammar-to-ast",          Set Grammar.dbg_grammar_to_ast,
     " Debug the conversion of an EBNF grammar to a BNF grammar.";
     "--debug-gen-aut", Set Aut.dbg_gen_aut, 
     " Debug the process of generating an automaton approximating the grammar.";
     "--debug-gen-aut-micro", Set Aut.dbg_gen_aut_micro, 
     " Debug the process of creating an automaton from edge descriptions computed in the gen-aut step.";
     "--debug-compilation-to-agda", Set Compile_agda.dbg_compile_to_agda, 
     " Debug compilation to Agda.";
     "--debug-ambiguity-check", Set Ambig.dbg_ambig, 
     " Print debug information for the ambiguity check";
     "--agda-emit-deriv", Set Compile_agda.emit_deriv, 
     " Emit the Agda soundness proof for parse trees.";
     "--compute-dfa",Set compute_dfa,"Compute a deterministic Moore machine (experimental)"
    ];;

let main () : unit =
  Arg.parse (align analysis_options) set_infile usage;
  
  if (!Aut.dbg_gen_aut_micro) then
    Aut.dbg_gen_aut := true;

  let parsed =
    let lexbuf = Lexing.from_channel !infile in
    Gra2srs_parse.main Gra2srs_lex.token lexbuf 
  in
  match parsed with
    None -> ()
  | Some(x) ->
     let Gra2srs_syntax.Grammar(_,(_,gname),_,_,_,_,_,_,_) = x in
     let reportfile = 
       let reportfile_name = gname^"_report.txt" in
       try
	 open_out reportfile_name
       with
	 _ ->
	 print_string "There was a problem opening ";
	 print_string reportfile_name;
	 print_string ", which we will use to report on the analysis of the grammar.\n";
	 exit 1
     in
     
     set_debugger_out reportfile;

     let dbg = debugger dbg_overall in

     wr dbg ("Beginning processing of grammar "^gname^".\n");

     elapsed (wr dbg);
     let g = Grammar.to_ast x in
     wr dbg "Converted grammar to AST for grammars.\n";
     let (Grammar.Grammar(gname,start,_,
			  (Grammar.SyntacticNts(syn_nts),Grammar.ReadingNts(read_nts),Grammar.RecognizingNts(rec_nts),
			   Grammar.Terminals(ters)),
			  syn_prods,lex_prods,reorganizing_trs)) = g in

     if trie_contains rec_nts start then
       err "The start symbol of the grammar is a recognizing lexical nonterminal (this is not allowed).\n";

     kon dbg (fun dbg -> Grammar.dump_grammar dbg g);
     
     let (ctor_tps,embedding,ptrs) = Parsing_trs.convert_grammar g in
     
     kon dbg
	 (fun dbg ->
	  dbg "(The parsing TRS for the grammar is:\n";
	  Parsing_trs.print_parsing_trs dbg ptrs;
	  dbg ")\n");

     if !skip_analyses then
       wr dbg "(Skipping termination and local confluence checks for the reorganizing rewriting rules.)\n"
     else
       (let sn = Termination.terminating reorganizing_trs in
	if sn then
	  (wr dbg "(The reorganizing TRS is terminating.)\n";
           match Complexity.dc reorganizing_trs with
           | Some n -> wr dbg (Format.sprintf "(Derivational complexity of the reorganizing TRS: O(n^%d))\n" n)
           | None -> wr dbg "(Derivational complexity of the reorganizing TRS: unknown)\n" )
	else
	  (wr dbg "(The reorganizing TRS might be non-terminating (cannot tell for sure).)\n";
	   if (not !continue_with_nonterminating) then
	     (print_string "The rewriting rules cannot be confirmed to be terminating.\n";
	      print_string "Run gratr with --continue-with-nonterminating to continue past this point.\n";
	      exit 1));


	let lc = Localconf.locally_confluent reorganizing_trs in
	if nonempty lc then
	  (print_string "The term-rewriting system for parse trees is not locally confluent.\n";
	   print_string "See ";
	   print_string gname;
	   print_string "_report.txt for details.\n";
	   kon dbg
	       (fun dbg ->
		dbg "(----------------------------------------------------\n";
		dbg "The rules for rewriting parse trees are not locally confluent.\n";
		dbg (string_of_int (List.length lc));
		dbg " critical pairs found:(\n";
		List.iter (Localconf.print_cp dbg) lc;
		dbg ")\n");
	   exit 1);
	wr dbg "(Local confluence of the reorganizing TRS: true)\n\n");
     
     if !rewrite_rules_only then
       (wr dbg "(We are stopping early, since the --rewrite-rules-only flag was given.)\n";
	exit 1);

     elapsed (wr dbg);

     if !compute_dfa then
       Builddfa.dfa_from_grammar gname start ptrs ters;

     let (lendec_rrs,unit_rrs,scc_num,sr,rr,nts) =
       Genrtn.gen_rtn dbg gname start ptrs reorganizing_trs ters in
     
     compile_to_agda g ctor_tps embedding (trie_contains ters) start [] (lendec_rrs @ unit_rrs) reorganizing_trs scc_num sr rr nts;
     
     close_out reportfile
;;

main();;
