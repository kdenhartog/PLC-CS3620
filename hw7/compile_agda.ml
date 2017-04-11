open Ast;;
open Util;;
open Grammar;;
open Rewrite_rules;;
open Term;;
open Trie;;
open Tree;;
open Trs;;

let string_str = "string";;
let dbg_compile_to_agda = ref false;;
let use_string_encoding = ref false;;
let use_string_encoding_wf = ref false;;
let emit_deriv = ref false;;

let recent_agda = "2.5.X";;
let earlier_agda = "2.4.2.4";;
let agda_version = recent_agda;; 

let comment os n = 
  os "--";
  for i = 1 to n do
    os "-"
  done;
  os "\n"
;;

let box os len str = 
  comment os len;
  os "-- ";
  os str;
  os "\n";
  comment os len;
  os "\n";
;;

let rec print_string_as_list os s cur len = 
  if cur < len then
    (os "\'";
     os (String.make 1 s.[cur]);
     os "\' :: ";
     print_string_as_list os s (cur + 1) len)
  else
    os "[]"
;;
let print_string_as_list os s =
  os "(";
  print_string_as_list os s 0 (String.length s);
  os ")"
;;

(* return the type of ctor h *)
let sym_rettp ctor_tps (h:string) = 
  match trie_lookup ctor_tps h with
      None -> err ("Internal error2 compiling to Agda:"^h);
    | Some(_,rettp) -> rettp		
;;

(* return the type of the given term from the return type of its head *)   
let term_tp ctor_tps (t : term) : string =
  match get_head_symbol t with
      None -> err "Internal error1 compiling to Agda\n"
    | Some(h) -> sym_rettp ctor_tps h
;;

let print_types_and_reorganizing_rules (g:grammar) (name:string) (ctor_tps:tp_ctxt) (embedding:string trie)
                                       (nts:stringset) (Trs(reorg))  = 
  let dbg = debugger dbg_compile_to_agda in
  let (Grammar(gname,start,_,(SyntacticNts(_),ReadingNts(read_nts),RecognizingNts(rec_nts),_), prods,lexers,_)) = g in
  let outfile = open_out (gname^"-types.agda") in
  let os = output_string outfile in
  let decls = trie_new() in

  box os 80 "Types for parse trees";

  os "module ";
  os gname;
  os "-types where\n\n";
  os "open import lib\n";
  os "open import parse-tree\n";

  wr dbg "ctor_tps: ";
  List.iter 
    (fun c -> 
       wr dbg c;
       wr dbg " ";
       if c <> "Posinfo" then
	 match trie_lookup ctor_tps c with
	     None -> () (* should not happen *)
	   | Some(input_decls,output_tp) ->
	       trie_cons decls output_tp (c,input_decls))
    (trie_strings ctor_tps);
  wr dbg "\n";
  let strsort = List.sort String.compare in
  let tps = strsort (trie_strings decls) in
  let etps = strsort (trie_strings embedding) in
  let read_tps = "posinfo" :: strsort (trie_strings read_nts) in
  let rec_tps = strsort (trie_strings rec_nts) in
  let getrep t = stringtrie_lookup_if embedding t in
    kon dbg (fun dbg -> 
	       dbg "Emitting definitions for these types: ";
	       print_strings dbg ", " tps;
	       dbg "\n");

  (* emit type definitions.  The ones for parse trees will all be mutually inductive as a precaution. *)

    os "\n";
  List.iter
    (fun nt ->
     os nt;
     os " = ";
     os string_str;
     os "\n")
    read_tps;
  if nonempty read_tps then
    os "\n";

  if nonempty tps then
    os "mutual\n\n";

  List.iter 
    (fun tp ->
     os "  data ";
     os tp;
     os " : Set where \n";
     let ctors = list_trie_lookup decls tp in
     List.iter
       (fun (c,input_decls) ->
	os "    ";
	os c;
	os " : ";
	List.iter
	  (fun tp' -> os tp'; os " → ")
	  input_decls;
	os tp;
	os "\n")
       (List.sort (fun (s1,_) (s2,_) -> String.compare s1 s2) ctors);
     os "\n"
    )
    tps;

  os "-- embedded types:\n";
  List.iter
    (fun nt -> 
       os nt;
       os " : Set\n";
       os nt;
       os " = ";
       os (getrep nt);
       os "\n")
    etps;
  os "\n";

  (* now print out the global parse-tree type *)


  os "data ParseTreeT : Set where\n";
  let add_rec_ctor tp =
    os "  parsed-";
    os tp;
    os " : ";
    os (getrep tp);
    os " → ParseTreeT\n"
  in
  List.iter add_rec_ctor tps;
  List.iter add_rec_ctor etps;
  List.iter add_rec_ctor read_tps;
  (* the recognized types have no parse trees, but they still get
	   a ctor in ParseTreeT, just to mark the place where they were
	   recognized (for benefit of subsequent run-rewriting). *)
  List.iter (fun tp -> 
	     os "  parsed-";
	     os tp;
	     os " : ParseTreeT\n")
	    rec_tps;
  

  os "\n";
  


  


  box os 40 "Parse tree printing functions";
  let toString tp = tp ^ "ToString" in

  List.iter
    (fun nt ->
     os (toString nt);
     os " : ";
     os nt;
     os " → string\n";
     os (toString nt);
     os " x = \"(";
     os nt;
     os " \" ^ x ^ \")\"\n")
    read_tps;
  if nonempty read_tps then
    os "\n";

  if nonempty tps then
    os "mutual\n";

  List.iter 
    (fun tp ->
     os "  ";
     os (toString tp);
     os " : ";
     os tp;
     os " → string\n";
     let ctors = list_trie_lookup decls tp in
     List.iter
       (fun (c,input_decls) ->
	os "  ";
	os (toString tp);
	os " (";
	os c;
	let _ = List.fold_left (fun n _ -> 
				os " x";
				os (string_of_int n);
				n+1) 0 input_decls in
	os ") = \"";
	if nonempty input_decls then
	  os "(";
	os c;
	os "\"";
	let _ = List.fold_left (fun n tp' ->
				os " ^ \" \" ^ (";
				os (toString tp');
				os " x";
				os (string_of_int n);
				os ")";
				n+1) 0 input_decls in
	os " ^ \"";
	if nonempty input_decls then
	  os ")";
	os "\"\n")
       ctors;
     os "\n"
    )
    tps;

  os "ParseTreeToString : ParseTreeT → string\n";
  let add_clause_toString tp =
    os "ParseTreeToString (parsed-";
    os tp;
    os " t) = ";
    os (toString (getrep tp));
    os " t\n"
  in
  List.iter add_clause_toString tps;
  List.iter add_clause_toString etps;
  List.iter add_clause_toString read_tps;
  List.iter (fun tp ->
	     os "ParseTreeToString parsed-";
	     os tp;
	     os " = \"[";
	     os tp;
	     os "]\"\n")
	    rec_tps;
  os "\n";


  
  (* now print the reorganizing rules *)
  let rec print_norm_term (t:term) : unit =
    match t with
      Var(x) -> os "x"; os (string_of_int x)
    | Normal(t) -> print_norm_term t
    | App(f,ts) ->  
       if empty ts then
	 os f
       else
	 (os "(norm-";
	  os (sym_rettp ctor_tps f);
	  os " (";
	  os f;
	  os " ";
	  List.iter (fun arg -> os " "; print_norm_term arg) ts;
	  os ") ";
	  os ")")
  in	

  box os 40 "Reorganizing rules";

  (* group rules by return type of left-hand side (so rls maps types to the set of rules whose lhs's have that type) *)
  let rls = trie_new() in
  List.iter 
    (fun r ->
     let Rule(_,lhs,_) = r in
     trie_cons rls (term_tp ctor_tps lhs) r)
    reorg;

    let printed_mutual = ref false in
      List.iter
	(fun rettp -> 
	   let rs = list_trie_lookup rls rettp in
	   let norm() = os "  norm-"; os rettp in
	     if (not !printed_mutual) then
	       (os "mutual\n\n";
		printed_mutual := true);


               if (agda_version = recent_agda) then
                 os "  {-# TERMINATING #-}\n"
               else
                 os "  {-# NO_TERMINATION_CHECK #-}\n";
	     norm();
	     os " : (x : ";
	     os rettp;
	     os ")";
	     os " → ";
	     os rettp;
	     os "\n";

	     List.iter
	       (fun (Rule(_,lhs,rhs)) ->
		  norm();
		  os " ";
		  print_term_prefix os lhs;
		  os " = ";
		  print_norm_term rhs;
		  os "\n")
	       rs;

	     norm();
	     os " x = x\n\n";
	)
	(trie_strings nts);

      if !use_string_encoding then
	(
	  box os 40 "Functions related to the string encoding";

	  os "parse-tree-checker : (nt : 𝕃 char) → ParseTreeT → 𝔹\n";
	  let checkfun recog tp =
	    os "parse-tree-checker ";
	    print_string_as_list os tp;
	    if recog then
	      (os " parsed-";
	       os tp)
	    else
	      (os " (parsed-";
	       os tp;
	       os " _)");
	    os " = tt\n"
	  in
	    List.iter (checkfun false) tps;
	    List.iter (checkfun false) read_tps;
	    List.iter (checkfun true) rec_tps;
	    os "parse-tree-checker _ _ = ff\n\n";

	    os "parse-tree-get-string : ParseTreeT → maybe string\n";
	    List.iter 
	      (fun tp ->
		 os "parse-tree-get-string (parsed-";
		 os tp;
		 os " x) = (just x)\n"
	      )
	      read_tps;
	    os "parse-tree-get-string _ = nothing\n\n";

	    os "parse-tree-builder : (nt : 𝕃 char) → (octor : maybe (𝕃 char)) → (args : (𝕃 (char ⊎ ParseTreeT)))";
	    os " → maybe ParseTreeT\n";
	    List.iter 
	      (fun tp ->
		 let ctors = list_trie_lookup decls tp in
		   List.iter
		     (fun (c,input_decls) ->
			os "parse-tree-builder ";
			print_string_as_list os tp;
			os " (just ";
			print_string_as_list os c;
			os ") (";
			let cnt = ref 0 in
			  List.iter
			    (fun tp' -> os "(inj₂ (parsed-"; os tp'; os " x"; os (string_of_int !cnt); os ")) :: "; incr cnt)
			    input_decls;
			  os "[]) = just (parsed-";
			  os tp;
			  os " (norm-";
			  os tp;
			  os " (";
			  os c;
			  for i = 0 to (!cnt - 1) do
			    os " x";
			    os (string_of_int i);
			  done;
			  os ")))\n")
		     ctors;
	      )
	      tps;
	    List.iter 
	      (fun tp ->
		 os "parse-tree-builder ";
		 print_string_as_list os tp;
		 os " (just ";
		 print_string_as_list os "concat";
		 os ") xs with parse-tree-string-concat parse-tree-get-string xs\n";
		 os "... | nothing = nothing\n";
		 os "... | just cs = just (parsed-";
		 os tp;
		 os " cs)\n"
	      )
	      read_tps;
	    List.iter 
	      (fun tp ->
		 os "parse-tree-builder ";
		 print_string_as_list os tp;
		 os " nothing xs = just parsed-";
		 os tp;
		 os "\n"
	      )
	      rec_tps;
	    os "parse-tree-builder _ _ _ = nothing\n\n";

	    os "ptrsd : ParseTreeRecSD ptr\n";
	    os "ptrsd = record { parse-tree-checker = parse-tree-checker ; parse-tree-builder = parse-tree-builder }\n\n";

	    os "-- for use with runtime-only; set to ff to get compile-time evaluation\n";
	    os "gratr-runtime-only : 𝔹\n";
	    os "gratr-runtime-only = tt\n\n"
	);



      (os,outfile)
;;

let print_isParseTree_and_derivations (os, outfile) (g:grammar) (name:string)  (ctor_tps:tp_ctxt) (nts:stringset) (Trs(reorg))(unit_ptrs:rrs)(len_decreasing_ptrs:rrs)  =  
  let (Grammar(gname,start,_,(SyntacticNts(_),ReadingNts(read_nts),RecognizingNts(rec_nts),_), prods,lexers,_)) = g in

    (* isParseTree datatypes *)
    box os 40 "Detailed Parse Tree";
    os "data isParseTree : ParseTreeT → 𝕃 char → string → Set where\n";
    
    let ipt_proc = trie_new () in
      
    let rcat_list sep l = cat_list sep (List.rev l) in

    let print_ipt (id,lhs,nt,ot) =
      if trie_contains ipt_proc id then None 
      else (
	trie_insert ipt_proc id true;
	os "  parsed-";
	os nt;
	os "-";
	os id;
	os " : ";


	let rec collect_lhs_elts implicit_args list_args ast_args ipt_args grammar_rule derivation n = function
	  | Id(id) :: rest -> collect_lhs_elts implicit_args list_args ast_args ipt_args grammar_rule derivation n rest
	  | SymElt(SubAst(_) , s):: rest -> (
	      let sq = "\"" ^ s ^ "\"" in
	      let list_arg = "l" ^ (string_of_int n) in
	      let ast_arg = "a" ^ (string_of_int n) in
	      let implicit_arg = "{" ^ list_arg ^ " : 𝕃 char}{" ^ ast_arg ^ " : " ^ s ^ "}" in
	      let ipt_arg = "isParseTree (parsed-" ^ s ^ " " ^ ast_arg ^ ") " ^ list_arg ^ " " ^ sq in
	      let gram_arg = "inj₁ " ^ sq in
		collect_lhs_elts (implicit_arg::implicit_args) (list_arg::list_args) (ast_arg::ast_args) (ipt_arg::ipt_args) (gram_arg::grammar_rule) ((false,s)::derivation) (n+1) rest
	    )
	  | SymElt(SymOnly, s) :: rest -> (
	      let s2 = String.sub s 1 ((String.length s) - 2) in
	      let sarr = "[ " ^ s ^ " ]" in
	      let sq = "\"" ^ s2 ^ "\"" in
	      let gram_arg = "inj₂ " ^ s in
		collect_lhs_elts implicit_args (sarr::list_args) (sq::ast_args) ipt_args (gram_arg::grammar_rule) ((true,s)::derivation) n rest
	    )
	  | SymElt(NotInAst, s) :: rest -> (
	      if s.[0] = '\''
	      then (
		let sarr = "[ " ^ s ^ " ]" in
		let gram_arg = "inj₂ " ^ s in
		  collect_lhs_elts implicit_args (sarr::list_args) ast_args ipt_args (gram_arg::grammar_rule) ((true,s)::derivation) n rest
	      ) else (
		let sq = "\"" ^ s ^ "\"" in
		let list_arg = "l" ^ (string_of_int n) in
		let implicit_arg = "{" ^ list_arg ^ " : 𝕃 char}" in
		let ipt_arg = "isParseTree parsed-" ^ s ^ " " ^ list_arg ^ " " ^ sq in
		let gram_arg = "inj₁ " ^ sq in
		  collect_lhs_elts (implicit_arg::implicit_args) (list_arg::list_args) ast_args (ipt_arg::ipt_args) (gram_arg::grammar_rule) ((false,s)::derivation) (n+1) rest
	      );
	    )
	  | [] -> (implicit_args, list_args, ast_args, ipt_args, grammar_rule, derivation, n)
	in

	let (ima, la, aa, ipta, grmr, deriv, n) = collect_lhs_elts [] [] [] [] [] [] 0 lhs in
	  os (rcat_list "" ima);
	  if List.length ima > 0 then
	    os " → ";
	  os (rcat_list " → " ipta);
	  
	  if List.length ipta > 0 then
	    os " → ";
	  
	  os "isParseTree ";

	  (match ot with
	     | None -> 
		 os "parsed-";
		 os nt;
	     | Some(t) ->
		 os "(parsed-";
		 os nt;
		 os " ";
		 (match get_head_symbol t with
		    | None -> err "Internal error compiling to Agda"
		    | Some(h) ->
			match trie_lookup ctor_tps h with
			  | None -> 
			      if List.length aa = 0
			      then os "\"\""
			      else
				(
				  if List.length aa = 1
				  then os (List.hd aa)
				  else(
				    os "(";
				    os (rcat_list " ^ " aa);
				    os ")"
				  )
				)
			  | Some(_,rettp) -> (
			      if List.length aa = 0
			      then os id
			      else (
				os "(";
				os "norm-";
				os nt;
				os " (";
				os id;
				os " ";
				os (rcat_list " " aa);
				os "))"
			      )
			    )
		 );
		 os ")";
	  );
	  os " ";

	  if List.length la = 0 then 
	    os "[]"
	  else if List.length la = 1 then (
	    os (List.hd la)
	  )
	  else (
	    os "(";
	    os (rcat_list " ++ " la);
	    os ")"
	  );
	  os " ";
	  os "\"";
	  os nt;
	  os "\"";
	  os "\n";
	  Some (nt, grmr, id, deriv, n)
      )
    in

    let rec iter acc = function
      | p::ps -> (match (print_ipt p) with
		    | None -> iter acc ps
		    | Some(j) -> iter (j::acc) ps)
      | [] -> acc
    in
    let res = iter (iter [] len_decreasing_ptrs) unit_ptrs in

      (* Output grammar *)
      os "\n\n\n";
      box os 40 "Grammar";    

      os "open import grammar string _=string_ ≡string-to-= =string-to-≡\n\n";
      
      let rec print_grammar = function
	| (nt,ts,_,_,_)::rs -> (
	    os "\"";
	    os nt;
	    os "\"";
	    os " ⇒ ";
	    if List.length ts > 0 then (
	      os "(";
	      os (rcat_list " :: " ts);
	      os " :: [])";
	    ) else os "[]";
	    os " ::\n  ";
	    print_grammar rs
	  ) 
	| [] -> os "[])\n"
      in

      let rec print_deriv gr = function
	| (nt,_,id,deriv,n)::rs -> (
	    if n = 0 then (
	      os "deriv ";
	      os "parsed-";
	      os nt;
	      os "-";
	      os id;
	    ) else (
	      os "deriv ";
	      os "(parsed-";
	      os nt;
	      os "-";
	      os id;
	      os " ";
	      let rec argEnum = function
		| 0 -> []
		| k -> ("a" ^ (string_of_int k)) :: argEnum (k-1)
	      in
		os (rcat_list " " (argEnum n));
		os ")"
	    );
	    os " = ";
	    os "step 0 ";
	    os (string_of_int gr);
	    os " refl refl refl refl ";
	    if deriv = [] then 
	      os "end"
	    else (
	      os "(";
	      let rec aux n acc = function 
		| ((true,s)::ss) -> aux n (("self-deriv " ^ s)::acc) ss
		| ((false,s)::ss) -> aux (n+1) (("(deriv a" ^ (string_of_int n) ^ ")")::acc) ss
		| [] -> acc
	      in
		os (rcat_list " deriv++ " (aux 1 [] (List.rev deriv)));
		os ")"
	    );
	    os "\n";
	    print_deriv (gr+1) rs
	  )
	| [] -> os "\n"
      in

	os ("\n\ng : grammar{" ^ (string_of_int ((List.length prods) + (List.length lexers))) ^ "}\n");
	 os "g = (\"";
	 os start;
	 os "\" ,\n  "; 
	 print_grammar res;
	 
	 
	 (* Print the derivation proofs *)
	 os "\n\n\n";
	 box os 40 "Derivations";   
	 
	 os "\nself-deriv : (s : char) → derivation{g = g} [ inj₂ s ] [ s ]\nself-deriv s = end\n";
	 os "\nderiv : ∀{nt : string}{s : 𝕃 char}{T : ParseTreeT} → isParseTree T s nt → derivation{g = g} [ inj₁ nt ] s\n";
	 print_deriv 0 res;


;;

let print_state_runelement os s =
  os "(Id ";
  os (string_of_int s);
  os ")"
;;


(* elt is an element of a lhs of a prule from a parsing_trs.  We
   will print it out as an input pattern *)
let print_pattern os is_terminal elt lexicalOffset =
  let pr_char s = 
    os "(InputChar ";
    os s;
    os ")"
  in
    match elt with
      | SymElt(tp,s) ->
	  (match tp with
	       NotInAst ->
		 if is_terminal s then
		   (pr_char s; Some (true, s))
		 else
		   (if !emit_deriv then
		     (let id = lexicalOffset() in
			os "(ParseTree{l";
			os (string_of_int id);
			os "}{\"";
			os s;
			os "\"}{parsed-";
			os s;
			os "}";
			os " ipt";
			os (string_of_int id);
			os ")")
		   else
		     (os "(ParseTree parsed-";
		      os s;
		      os ")");
		    Some(false,""))
	     | SymOnly -> pr_char s; Some (true, s)
	     | SubAst(i) ->
		 if !emit_deriv then
		   (os "(ParseTree{l";
		    let id = lexicalOffset () in
		      os (string_of_int id);
		      os "}";
		      os "{\"";
		      os s;
		      os "\"}";
		      os "{";
		      os "parsed-";
		      os s;
		      os " x";
		      os (string_of_int id);
		      os "}";
		      os " ipt";
		      os (string_of_int id);
		      os ")")
		 else
		   (os "(ParseTree (parsed-";
		    os s;
		    os " x";
		    os (string_of_int i);
		    os "))");
		 Some (false, "")
	  )
      | Id(id) -> 
	  os "(";
	  os "Id ";
	  os "\"";
	  os id;
	  os "\"";
	  os ")";
	  None;
;;

(* print the rhs of a prule from a parsing_trs as an element of type ParseTreeT in Agda. *)
let print_return_parse_tree_deriv os ctor_tps id nt ot maxId =
  if maxId = 0 then (
    os "parsed-";
    os nt;
    os "-";
    os id
  )
  else (
    os "(parsed-";
    os nt;
    os "-";
    os id;
    os " ";
    let rec print_ipts k = 
      if k < maxId then (
	os " ipt";
	os (string_of_int k);
	print_ipts (k+1)
      ) else ()
    in
    print_ipts 0;
    os ")"
  )
;;

let print_return_parse_tree_noderiv os ctor_tps id nt ot  =
  match ot with
      None -> 
	os "parsed-";
	os nt;
    | Some(t) ->
	os "(parsed-";
	os nt;
	os " ";
	(match get_head_symbol t with
	   | None -> (* this could happen if this is an embedding production *)
	       print_term_prefix os t
	   | Some(h) ->
	       match trie_lookup ctor_tps h with
		 | None -> 
		     (* must be string append *)
		     print_term_prefix os t
		 | Some(_,rettp) -> 
		     os "(norm-";
		     os rettp;
		     os " ";
		     print_term_prefix os t;
		     os ")"
	);
	os ")"
;;



let emit_len_dec_rule (os:string -> unit)(fun_name:string)(is_terminal:string -> bool)(ctor_tps:tp_ctxt) len_dec id lhs rhs ot =
  os fun_name;
  os " {- ";
  os id;
  os "-} (";
  let argId = ref 0 in
  let lexicalOffset() = (
    let i = !argId in
    incr argId;
    i
  )
  in
  
  let cons = if !emit_deriv then " ::' " else " :: " in
  let consimp = if !emit_deriv then "_::'_{lc}" else "_::_" in

  let rec aux acc = function
    | e :: [] -> (
	os consimp;
	let res = print_pattern os is_terminal e lexicalOffset in
	  os " rest) ";
	  match res with 
	    | Some(r) -> r::acc
	    | None -> acc
      )
    | e :: es -> (
	let res = print_pattern os is_terminal e lexicalOffset in
	  os cons;
	  match res with 
	    | Some(r) -> aux (r::acc) es 
	    | None -> aux acc es
      )
    | [] -> acc
  in

  let ipt_args = aux [] lhs in

  let pr_parse_tree() = 
    os "(ParseTree ";
    if !emit_deriv then
      print_return_parse_tree_deriv os ctor_tps id rhs ot !argId
    else
      print_return_parse_tree_noderiv os ctor_tps id rhs ot;
    os " ::' rest";
    os " , ";
    os (string_of_int (List.length lhs));
    os ")"
  in

  if !emit_deriv && len_dec && (List.length ipt_args) > 1 then (
    let rec aux k last_char numchar = function
      | (true,s)::rest -> (
	os "[ ";
	os s;
	os " ]";
	os " :: ";
	aux k true (numchar+1) rest
      )
      | (false,s)::rest -> (
	os "l";
	os (string_of_int k);
	os " :: ";
	aux (k+1) false numchar rest
      )
      | [] -> os "[]"
    in
    os "= just (assocRun ";
    os "(";
    aux 0 false 0 (List.rev ipt_args);
    os ") lc ";
    pr_parse_tree();
    os ")";
  )
  else
    (os "= just ";
     pr_parse_tree());
    os "\n";
;;
  
  
let print_len_dec_ptrs (os:string -> unit)(fun_name:string)(is_terminal:string -> bool)(ctor_tps:tp_ctxt)(ptrs:rrs):unit =
  os fun_name;
  if !emit_deriv then
    os " : {lc : 𝕃 char} → (r : Run lc) → maybe (Run lc × ℕ)\n"
  else
    os " : Run → maybe (Run × ℕ)\n";
  List.iter
    (fun (id,lhs,rhs,ot) ->
       if id = "Posinfo" then
	 os "len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)\n"	 
       else
	 emit_len_dec_rule os fun_name is_terminal ctor_tps true id lhs rhs ot)
    ptrs;
  os fun_name;
  os " x = nothing\n\n"
;;

let print_run_rewriting_rules (os:string -> unit)(is_terminal:string -> bool) (ctor_tps:tp_ctxt)
    (unit_ptrs:rrs)(len_decreasing_ptrs:rrs)(opad : int option):unit =
  
  os "open import run ptr\n";
  if !emit_deriv then
    os "open deriv\n\n"
  else
    os "open noderiv\n\n";

  box os 40 "Length-decreasing rules";

  print_len_dec_ptrs os "len-dec-rewrite" is_terminal ctor_tps len_decreasing_ptrs;

  os "rrs : rewriteRules\n";
  os "rrs = record { len-dec-rewrite = len-dec-rewrite }\n";
;;

(*
let agda_nt_t = trie_new();;
let agda_nt_next = ref 0;;

let agda_nt_name nt = 
  match trie_lookup agda_nt_t nt with
      Some(s) -> s
    | None ->
	let c = !agda_nt_next in
	let nt_str = "_" ^ (String.make 1 (Char.chr ((c mod 26) + 97))) ^ nt in
	  incr agda_nt_next;
	  trie_insert agda_nt_t nt nt_str;
	  nt_str	  
;;
*)

let agda_nt_name nt = "_" ^ nt;;

let print_rtn (name : string)(os : string -> unit) scc_num start start_rules return_rules nts=
  os "data gratr2-nt : Set where\n";
  List.iter (
      fun nt -> (
	os "  ";
	os (agda_nt_name nt);
	os " : gratr2-nt\n";
      )
    ) nts;

  os "\n\n";

  os "gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹\n";
  List.iter (
      fun nt -> (
	let nt_str = agda_nt_name nt in
	  os "gratr2-nt-eq  ";
	  os nt_str;
	  os " ";
	  os nt_str;
	  os " = tt\n";
      )
    ) nts;
  if List.length nts > 1 then
    os "gratr2-nt-eq _ _ = ff\n\n\n"
  else
    os "\n";
  
  os "open import rtn gratr2-nt\n\n\n";

  let os_maybe os = function
    | Some(x) -> os "just "; os "\""; os x; os "\"";
    | None -> os "nothing";
  in
  
  let start_dec = name ^ "-start" in
  os start_dec;
  os " : ";
  os "gratr2-nt → 𝕃 gratr2-rule";
  os "\n";
  List.iter (
      fun (nt, start_rules) -> (
	os start_dec;
	os " ";
	os (agda_nt_name nt);
	os " = ";
	List.iter (
	    fun (id, id', lhs) -> (
	      os "(";
	      os_maybe os id;
	      os " , ";
	      os_maybe os id';
	      os " , just ";
	      os (agda_nt_name nt);
	      os " , ";
	      List.iter (
		  fun (o,x) -> (
		    if x.[0] = '\'' then(
		      os "inj₂ ";
		      os x;
		    ) else (
		      os "inj₁ ";
		      os (agda_nt_name x);
		    );
		    os " :: ";
		  )
		) lhs;
	      os "[])";
	      os " :: ";
	    )
	  ) start_rules;
	os "[]\n";
      )      
    ) start_rules;
  os "\n\n";

  let return_dec = name ^ "-return" in
  os return_dec;
  os " : ";
  os "maybe gratr2-nt → 𝕃 gratr2-rule";
  os "\n";
  List.iter (
      fun (nt, return_rules) -> (
	os return_dec;
	os " (just _";
	os nt;
	os ") = ";
	List.iter (
	    fun (id, id', lhs) -> (
	      os "(";
	      os_maybe os id;
	      os " , ";
	      os_maybe os id';
	      os " , just _";
	      os nt;
	      os " , ";
	      List.iter (
		  fun (o,x) -> (
		    if x.[0] = '\'' then(
		      os "inj₂ ";
		      os x;
		    ) else (
		      os "inj₁ ";
		      os (agda_nt_name x);
		    );
		    os " :: ";
		  )
		) lhs;
	      os "[])";
	      os " :: ";
	    )
	  ) return_rules;
	os "[]\n";
      )      
    ) return_rules;
  os return_dec;
  os " _ = []\n";
  os "\n";

  let rtn_dec = name ^ "-rtn" in
  os rtn_dec;
  os " : ";
  os "gratr2-rtn";
  os "\n";
  os rtn_dec;
  os " = ";
  os "record { ";
  os "start = ";
  os (agda_nt_name start);
  os " ; ";
  os "_eq_ = gratr2-nt-eq ; ";
  os "gratr2-start = ";
  os start_dec;
  os " ; ";
  os "gratr2-return = ";
  os return_dec;
  os " }";
;;

(* This function should be expanded to include run rewriting rules
    and anything else that need to be compiled *)
let compile_to_agda (g:grammar)(ctor_tps:tp_ctxt)(embedding:string trie)
                    (is_terminal : string -> bool)(start:string)(unit_ptrs:rrs)
                    (len_decreasing_ptrs:rrs)(reorganizing_rules : trs) scc_num start_rules end_rules nts : unit = 
  let dbg = debugger dbg_compile_to_agda in
  let (Grammar(name,_,_,(SyntacticNts(nts'),_,_,_),_,_,_)) = g in
  let output_file = open_out (name^".agda") in 
  let os = output_string output_file in

  wr dbg "(Compilation to agda begins.\n";

  os ("module "^name^" where\n\n");

  os "open import lib\n";
  os "\n";

  os "open import ";
  os name;
  os "-types public\n";

  (* these go in separate files *)
  let (os',outfile') = print_types_and_reorganizing_rules g name ctor_tps embedding nts' reorganizing_rules in
    if !emit_deriv then
      print_isParseTree_and_derivations (os',outfile') g name ctor_tps nts' reorganizing_rules unit_ptrs len_decreasing_ptrs
    else
      (os' "isParseTree : ParseTreeT → 𝕃 char → string → Set\n";
       os' "isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}\n\n");

    os' "ptr : ParseTreeRec\n";
    os' "ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }\n";
    os' "\n";
    
    close_out outfile';
    
  box os 80 "Run-rewriting rules";

  print_rtn name os scc_num start start_rules end_rules nts;
  os "\n\n";

  print_run_rewriting_rules os is_terminal ctor_tps unit_ptrs len_decreasing_ptrs None;
  
  close_out output_file;


  let output_file = open_out (""^name^"-main.agda") in 
  let os = output_string output_file in

  os ("module "^name^"-main where\n\n");

  os "import parse\n";

  os "open import lib\n";
  os "open import ";
  os name;
  os "-types\n";
  os "import ";
  os name;
  os "\n\n";

  os ("module parsem = parse " ^ name ^ ".gratr2-nt ptr\n");
  
  let mname = if !emit_deriv then "pderiv" else "pnoderiv" in

  os "open parsem\n";
  os ("open parsem." ^ mname ^ " " ^ name ^ ".rrs ");
  os (name ^ "." ^ name);
  os "-rtn\n";
  os "open import run ptr\n";
  if !emit_deriv then
    os "open deriv {- from run.agda -}\n"
  else
    os "open noderiv {- from run.agda -}\n";
  os "\n";

  os "process-";
  os start;
  os " : ";
  os start;
  os " → string\n";
  os "process-";
  os start;
  os " s = \"\"\n";
  os "\n";

  if !emit_deriv then
    (os "process : {lc : 𝕃 char} → Run lc → string\n";
     os "process (ParseTree{s = \"";
     os start;
     os "\"}";
     os "{parsed-";
     os start;
     os " p} ipt ::' []')";
     os " = process-";
     os start;
     os " p\n";
     os "process r = \"Parsing failure (run with -\" ^ \"-showParsed).\\n\"\n";
     os "\n";
     os "putStrRunIf : {lc : 𝕃 char} → 𝔹 → Run lc → IO ⊤\n";
     os "putStrRunIf tt r = putStr (Run-to-string r) >> putStr \"\\n\"\n";
     os "putStrRunIf ff r = return triv\n")
  else
    (os "process : Run → string\n";
     os "process (ParseTree (parsed-";
     os start;
     os " p) :: [])";
     os " = process-";
     os start;
     os " p\n";
     os "process r = \"Parsing failure (run with -\" ^ \"-showParsed).\\n\"\n";
     os "\n";
     os "putStrRunIf : 𝔹 → Run → IO ⊤\n";
     os "putStrRunIf tt r = putStr (Run-to-string r) >> putStr \"\\n\"\n";
     os "putStrRunIf ff r = return triv\n");

  os "\n";
  os "processArgs : (showRun : 𝔹) → (showParsed : 𝔹) → 𝕃 string → IO ⊤ \n";
  os "processArgs showRun showParsed (input-filename :: []) = (readFiniteFile input-filename) >>= processText\n";
  os "  where processText : string → IO ⊤\n";
  os "        processText x with runRtn (string-to-𝕃char x)\n";
  os "        processText x | s with s\n";
  os "        processText x | s | inj₁ cs = putStr \"Characters left before failure : \" >> putStr (𝕃char-to-string cs) >> putStr \"\\nCannot proceed to parsing.\\n\"\n";
  os "        processText x | s | inj₂ r with putStrRunIf showRun r | rewriteRun r\n";
  os "        processText x | s | inj₂ r | sr | r' with putStrRunIf showParsed r'\n";
  os "        processText x | s | inj₂ r | sr | r' | sr' = sr >> sr' >> putStr (process r')\n";
  os "                                     \n";
  os "processArgs showRun showParsed (\"--showRun\" :: xs) = processArgs tt showParsed xs \n";
  os "processArgs showRun showParsed (\"--showParsed\" :: xs) = processArgs showRun tt xs \n";
  os "processArgs showRun showParsed (x :: xs) = putStr (\"Unknown option \" ^ x ^ \"\\n\")\n";
  os "processArgs showRun showParsed [] = putStr \"Please run with the name of a file to process.\\n\"\n";
  os "\n";
  os "main : IO ⊤\n";
  os "main = getArgs >>= processArgs ff ff\n";
  os "\n";
  close_out output_file;
  wr dbg "Compilation to agda ends.)\n";;

