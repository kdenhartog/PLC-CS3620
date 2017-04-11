open Rewrite_rules;;
open Trie;;
open Ast;;
open Trs;;
open Term;;
open Grammar;;
open Util;;

let rec cat_list (l : string list) (cat : string) : string =
  let rec aux acc = function
    | [] -> acc
    | x::[] -> acc ^ x
    | x::xs -> aux (acc ^ x ^ cat) xs
  in
  aux "" l
;;

let segment (l : 'a list) (size : int) : 'a list list =
  let rec aux acc glacc n = function
    | x :: xs -> if n >= size then aux (x :: []) (acc :: glacc) 1 xs else aux (x :: acc) glacc (n + 1) xs
    | [] -> acc::glacc
  in
  aux [] [] 0 l 
;;

let rec ocamlify s =
  stringMap (
      function
      | '-' -> '_'
      | x -> x
    ) (String.capitalize s)
;;

let rec ocamlify_id s = 
  stringMap (
      function
      |'/' -> '_'
      |'-' -> '_'
      | x -> x
    ) (String.capitalize s)
;;

let compile_ocaml g ctor_tps sr rr (rrs : rrs) (Trs reorg) nts scc_num start name =
  let (Grammar(gname,start,_,(SyntacticNts(syn_nts),ReadingNts(read_nts),RecognizingNts(rec_nts),_), prods,lexers,_)) = g in
  let output_file = open_out (name^".ml") in 
  let os = output_string output_file in

  os "module ";
  os (String.capitalize name);
  os " = struct\n";
  os "  type gratr2_nt = ";
  os (cat_list (List.map ocamlify nts) "\n\t\t  | ");
  

  os "\n\n";
  let decls = trie_new() in
  List.iter 
    (fun c -> 
     match trie_lookup ctor_tps c with
       None -> () (* should not happen *)
     | Some(input_decls,output_tp) ->
	trie_cons decls (ocamlify output_tp) (ocamlify c,List.map ocamlify input_decls))
    (trie_strings ctor_tps);
  let tps = trie_strings decls in
  let read_tps = trie_strings read_nts in
  let rec_tps = trie_strings rec_nts in
  iteri
    (fun i tp ->
     if i = 0 then 
       os "  type _"
     else
       os "   and _";
     os tp;
     os " = ";
     let ctors = list_trie_lookup decls tp in
     os (cat_list (List.map 
		     (fun (c,input_decls) -> 
		      (ocamlify_id c) ^ 
			if input_decls = [] then
			  ""
			else 
			  " of " ^ (cat_list (List.map (fun s -> "_" ^ s) input_decls) " * ") 
		     ) 
		     ctors) 
		  " | ");
     os "\n"
    )
    tps;
  List.iter (
      (fun tp -> 
       os "   and _";
       os (ocamlify tp);
       os " = string\n";
    )) read_tps;

  (* now print out the global parse-tree type *)

  let segment_map = trie_new() in

  os "\n\n";
  let segments = segment (
		     (List.map (fun tp -> let tp = ocamlify tp in (tp, tp ^ " of _" ^ tp)) tps)
		     @ 
		       (List.map (fun tp -> let tp = ocamlify tp in (tp, tp ^ " of _" ^ tp)) read_tps)
		     @ 
		       (List.map (fun tp -> let tp = ocamlify tp in (tp, tp)) rec_tps)
		   ) 246 in
  (match segments with
   | s :: [] -> (
     os "  type gratr2_parse_tree = ";
     os (cat_list (List.map (fun (_,x) -> x) s) "\n\t\t\t| ");
     os "\n\n";
   )
   | _ -> (
     iteri (
	 fun i s -> (
	   (if i = 0 then
	      os "\n  type gratr2_parse_tree_"
	    else 
	      os "\n  and gratr2_parse_tree_");
	   os (string_of_int i);
	   os " = "; 
	   os (cat_list (List.map (fun (tp,x) -> trie_insert segment_map tp i; x) s) "\n\t\t\t| ");
	 )
       ) segments;
     os "\n\n";
     os "  type gratr2_parse_tree = Pt0 of gratr2_parse_tree_0 ";
     let n = List.length segments in
     let rec aux m =
       if m < n then (
	 os "\n\t\t\t| Pt";
	 os (string_of_int m);
	 os " of ";
	 os "gratr2_parse_tree_";
	 os (string_of_int m);
       )
     in
     aux 1;
     os "\n\n";
  ));



  os "  type gratr2_rtn_input  = IC of string | NT of gratr2_nt\n";
  os "  type gratr2_parse_rule = gratr2_rtn_input list\n";
  os "  type gratr2_parse_call = string option * string option * gratr2_nt option * gratr2_parse_rule\n";
  os "  type gratr2_run_element = InputChar of string | Id of string | ParseTree of gratr2_parse_tree\n";
  os "  type gratr2_run = gratr2_run_element list\n";
  os "\n\n";

  os "  let gratr2_nt_to_string : gratr2_nt -> string = function\n";
  List.iter (
      fun nt -> (
	os "     | ";
	os (ocamlify nt);
	os " -> ";
	os "\"";
	os nt;
	os "\"";
	os "\n";
      )
    ) nts;
  os "  ;;\n\n";


  let os_rtn_elt e = 
    if e.[0] = '\'' then (
      os "IC ";
      e.[0] <- '"';
      e.[String.length e - 1] <- '"';
      os e;
    )
    else (
      os "NT ";
      os (ocamlify e);
    )
  in

  let os_maybe os = function
    | Some(x) -> os "Some "; os "\""; os x; os "\"";
    | None -> os "None"
  in


  os "  let gratr2_start : gratr2_nt -> gratr2_parse_call list = function\n";
  List.iter (
      fun (nt,sr) -> (
	os "    | ";
	os (ocamlify nt);
	os " -> ";
	List.iter (
	    fun (id, id', lhs) -> (
	      os "(";
	      os_maybe os id;
	      os ", ";
	      os_maybe os id';
	      os ", Some ";
	      os (ocamlify nt);
	      os ", ";
	      List.iter (
		  fun (_,e) -> (
		    os_rtn_elt e;
		    os " :: ";
		  ) 
		) lhs;
	      os "[]";
	      os ") :: ";
	    )
	  ) sr;
	os "[]\n";
      )
    ) sr;
  os "  ;;\n\n";

  os "  let start : gratr2_nt = ";
  os (ocamlify start);
  os "\n\n";

  os "  let gratr2_return : gratr2_nt option -> gratr2_parse_call list = function\n";
  List.iter (
      fun (nt, rr) -> (
	os "    | Some ";
	os (ocamlify nt);
	os " -> ";
	List.iter (
	    fun (id, id', lhs) -> (
	      os "(";
	      os_maybe os id;
	      os ", ";
	      os_maybe os id';
	      os ", Some ";
	      os (ocamlify nt);
	      os ", ";
	      List.iter (
		  fun (_,e) -> (
		    os_rtn_elt e;
		    os " :: ";
		  ) 
		) lhs;
	      os "[]";
	      os ") :: ";
	    )
	  ) rr;
	os "[]\n";
      )
    ) rr;
  os "    | _ -> []\n";
  os "  ;;\n\n";

  let rec print_term (t:term) (print_norm : unit -> unit) : unit =
    match t with
      Var(x) -> os "x"; os (string_of_int x)
    | Normal(t) -> print_term t print_norm
    | App(f,ts) ->  
       if ts = [] then
	 os f
       else (
	 print_norm();
	 os "(";
	 os f;
	 os "(";
	 iteri (fun i arg -> (if i <> 0 then os ", "); print_term arg print_norm) ts;
	 os ")";
	 os ")";
       )
  in

  (* return the type of ctor h *)
  let sym_rettp ctor_tps (h:string) = 
    match trie_lookup ctor_tps h with
      None -> err ("Internal error2 compiling to OCaml:"^h);
    | Some(_,rettp) -> rettp		
  in

  (* return the type of the given term from the return type of its head *)   
  let term_tp ctor_tps (t : term) : string =
    match get_head_symbol t with
      None -> err "Internal error1 compiling to OCaml\n"
    | Some(h) -> sym_rettp ctor_tps h
  in

  let rls = trie_new() in
  List.iter 
    (fun r ->
     let Rule(_,lhs,_) = r in
     trie_cons rls (term_tp ctor_tps lhs) r)
    reorg;
  let has_reorg nt = trie_contains rls nt in

  List.iter (
      fun nt -> (
	let rs = list_trie_lookup rls nt in
	if rs <> [] then (
	  let x = "_" ^ ocamlify nt in
	  let norm() = os "norm"; os x in
	  os "  let rec ";
	  norm();
	  os " : ";
	  os x;
	  os " -> ";
	  os x;
	  os " = function\n";
	  List.iter (
	      fun (Rule(_,lhs,rhs)) -> (
		os "    | ";
		print_term lhs (fun () -> ());
		os " -> ";
		print_term rhs norm;
		os "\n";
	      )
	    ) rs;
	  os "    | x -> x\n;;\n\n";
	)
      )
    ) nts;

  

  os "  let rewrite_rules : gratr2_run -> bool * int * gratr2_run = function\n";
  List.iter (
      fun (id, lhs, rhs, _) -> (
	os "    | ";
	let num = ref 0 in
	let next_num() =
	  let i = !num in
	  num := i + 1;
	  i
	in
	let rec aux ptargs = function
	  | SymElt(SubAst(_),x)::xs ->
	     let num = next_num() in
	     let pt = "pt" ^ (string_of_int num) in
	     let x' = ocamlify x in
	     os "ParseTree(";
	     (match trie_lookup segment_map x' with
	      | Some(i) -> 
		 os "Pt";
		 os (string_of_int i);
		 os "(";
		 os x';
		 os " ";
		 os pt;
		 os "))";
	      | None -> 
		 os x';
		 os " ";
		 os pt;
		 os ")";
	     );
	     os " :: ";
	     aux (pt :: ptargs) xs
	  | SymElt(NotInAst,x)::xs ->
	     if x.[0] = '\'' || x.[0] = '"' then (
	       os "InputChar ";
	       x.[0] <- '"';
	       x.[String.length x - 1] <- '"';
	       os x;
	     ) 
	     else (
	       let x' = ocamlify x in
	       os "ParseTree(";
	       (match trie_lookup segment_map x' with
		| Some(i) -> 
		   os "Pt";
		   os (string_of_int i);
		   os " ";
		   os x';
		   os ")";
		| None -> 
		   os x';
		   os ")";
	       );
	     );
	     os " :: ";
	     aux ptargs xs
	  | SymElt(SymOnly,x)::xs ->
	     os "InputChar ";
	     x.[0] <- '"';
	     x.[String.length x - 1] <- '"';
	     os x;
	     os " :: ";
	     aux (x::ptargs) xs
	  | Id(id)::xs ->
	     os "Id ";
	     os "\"";
	     os id;
	     os "\"";
	     os " :: ";
	     aux ptargs xs
	  | [] -> List.rev ptargs
	in
	
	let ptargs = aux [] lhs in
	os "rest";
	os " -> ";
	os "(";
	os "true";
	os ", ";
	os (string_of_int (List.length lhs));
	os ", ";
	os "ParseTree(";
	let x = ocamlify rhs in
	
	(match trie_lookup segment_map x with
	 | None -> 
 	    os x;
	    if has_reorg rhs then (
	      os "(";
	      os "norm_";
	      os x;
	      os " ";
	    );	
	    if trie_contains syn_nts rhs then (
	      os "(";
	      os (ocamlify_id id);
	      if ptargs <> [] then (
		os "(";
		os (cat_list ptargs ",");
		os ")";
	      );
	      os ")";
	    ) else if trie_contains read_nts rhs then (
	      if ptargs = [] then
		os " \"\""
	      else (
		os "(";
		os (cat_list ptargs "^");
		os ")";
	      );
	    );
	    if has_reorg rhs then 
	      os ")";
	 | Some(i) ->
	    os "Pt";
	    os (string_of_int i);
	    os "(";
	    os x;
	    if has_reorg rhs then (
	      os "(";
	      os "norm_";
	      os x;
	      os " ";
	    );	
	    if trie_contains syn_nts rhs then (
	      os "(";
	      os (ocamlify_id id);
	      if ptargs <> [] then (
		os "(";
		os (cat_list ptargs ",");
		os ")";
	      );
	      os ")";
	    ) else if trie_contains read_nts rhs then (
	      if ptargs = [] then
		os " \"\""
	      else (
		os "(";
		os (cat_list ptargs "^");
		os ")";
	      )
	    );
	    if has_reorg rhs then
	      os ")";
	    os ")";
	);
	os ") :: rest)\n";

      )
    ) rrs;

  os "    | x -> (false, 0, x)\n";
  os "  ;;\n\n";
  os "end\n\n";

  let output_file = open_out (name^"_main.ml") in 
  let os = output_string output_file in

  os "open Gratr2_ocaml;;\n";
  os "open Arg;;\n";
  os "open ";
  os (String.capitalize name);
  os ";;\n\n\n";
  os "module ";
  os (String.capitalize name);
  os "_main";
  os " = ";
  os "Gratr2_main";
  os "(";
  os (String.capitalize name);
  os ")";
  os ";;\n";
  os "open ";
  os (String.capitalize name);
  os "_main";
  os ";;\n\n";
  os "let infile = ref \"\";;\n";
  os "let show_run = ref false;;\n";
  os "let show_parsed = ref false;;\n";
  os "let debug_parse = ref false;;\n";
  os "let debug_rewrite = ref false;;\n\n";
  os "let usage = \"Usage: gratr [options] <file>\\n\";;\n\n";
  os "let analysis_options =\n";
  os "  [\"--showRun\", Set show_run,\n";
  os "   \" Show the parsed data as it exists after being rewritten.\";\n";
  os "   \"--showParsed\", Set show_parsed,\n";
  os "   \" Show the parsed data as it exists before being rewritten.\";\n";
  os "   \"--debugParsing\", Set debug_parse,\n";
  os "   \" Debug the parsing process.\";\n";
  os "   \"--debugRewriting\", Set debug_rewrite,\n";
  os "   \" Debug the rewriting process.\";\n";  
  os "  ]\n";
  os ";;\n\n";
  os "let main () : unit =\n";
  os "  Arg.parse (align analysis_options) (fun x -> infile := x) usage;\n";
  os "  let read =\n";
  os "    let ic = open_in !infile in\n";
  os "    let n = in_channel_length ic in\n";
  os "    let s = String.create n in\n";
  os "    really_input ic s 0 n;\n";
  os "    close_in ic;\n";
  os "    (s)\n";
  os "  in\n\n";  
  os "  match gratr2_parse read !debug_parse with\n";
  os "  | Fail(n) ->\n";
  os "     prerr_string \"Parsing error\\n\";\n";
  os "     prerr_string \"Characters read before failure:\\n\";\n";
  os "     prerr_string (String.sub read 0 n);\n";
  os "     prerr_string \"\\n\";\n";
  os "  | Run(parsed) ->\n";
  os "     let parsed = List.rev parsed in\n";
  os "     if !show_parsed then\n";
  os "       print_string (run_to_string parsed);\n\n";
  os "     let run = rewrite parsed !debug_rewrite in\n";
  os "     if !show_run then\n";
  os "       print_string (run_to_string run);\n\n";
  os "     if List.length run > 1 then\n";
  os "       prerr_string \"Rewriting error\\n\"\n\n";
  os ";;\n\n";
  os "main();;\n";
;;
