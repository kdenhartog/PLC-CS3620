(* ASTs for grammars *)

open Trie;;
open Util;;
open Term;;
open Trs;;

let no_eos = ref false;;

let dbg_grammar_to_ast = ref false;;

type role = Reading (* for rules which will record matching substrings *)
	    | Recognizing (* for rules intended to match input sequences but not record the matching substring *) ;;

(* Prod(rulename,lhs,rhs) *)
type production = Prod of string * string * string list;;
type lexical = Lex of role * string * string list;;
type definition = Def of string * string list;;

type syntacticNts = SyntacticNts of stringset;;
type readingNts = ReadingNts of stringset;;
type recognizingNts = RecognizingNts of stringset;;
type terminals = Terminals of stringset;;
type nullable_t = Nullable of stringset;;

type grammar = 
    Grammar of string (* name of grammar *)
      * string (* original start symbol *)
      * string option (* whitespace symbol if any *)
      * (syntacticNts (* the syntactic nonterminals *) 
	 * readingNts (* the lexical reading nonterminals *)
	 * recognizingNts (* the lexical recognizing nonterminals *)
	 * terminals (* terminal symbols *)
	) 
      * production list (* syntactic productions *)
      * lexical list (* lexical productions *)
      * trs (* rewrite rules *);; 

let sos_terminal = "'$'";;
let eos_terminal = "'!'";;

let print_core_prod (os:string -> unit) (r:role) (s:string) (ss:string list) : unit = 
  os s; 
  (match r with Reading -> os " ->" | Recognizing -> os " =>") ;
  List.iter (fun x -> os " "; os (safe_string x)) ss;
  os " .\n";;

let print_production (os:string -> unit) (Prod(rn,s,ss)) : unit =
  os rn; os " : ";
  print_core_prod os Reading s ss;;

let print_vars (os:string -> unit) (s:trs) : unit = 
  let max_var (Trs(rs)) : int =
    max_elt 0 (List.map (fun (Rule((_,vn),_,_)) -> vn) rs) in
    List.iter (fun n -> os " x"; os (string_of_int n)) (numlist (max_var s));;

let print_productions (os:string -> unit) (ps: production list) : unit =
  os "Syntactic\n\n";
  List.iter (print_production os) ps;;

let print_lexical (os:string -> unit) (Lex(r,s,ss)) : unit =
  print_core_prod os r s ss;;

let print_lexicals (os:string -> unit) (ls: lexical list) : unit =
  if nonempty ls then
    (os "Lexical\n\n";
     List.iter (print_lexical os) ls)
;;

let opt_print (os:string -> unit) (s:string) (v:string option) : unit =
  (match v with
       None -> ()
     | Some(s2) ->
	 os s;
	 os "\n\n";
	 os s2;
	 os "\n\n"
  );;

let grammar_name (Grammar(name,_,_,_,_,_,_)) = name;;

let print_grammar (os:string -> unit) (Grammar(name,start,ows,computed,ps,lexs,s)) (print_rules:bool) : unit =
  os name; 
  os "\n\n";
  os "Start\n\n";
  os start;
  os "\n\n";
  opt_print os "Whitespace" ows;
  os "\n\n";
  print_productions os ps;
  os "\n\n";
  print_lexicals os lexs;
  if print_rules then
    (os "\n\nVars\n\n";
     print_vars os s;
     os "\n\nRules\n\n";
     print_trs os s;
     os "\n\n");;

let dump_grammar (os:string -> unit) (g:grammar) : unit =
  let Grammar(_,_,_,o,_,_,_) = g in
    print_grammar os g true ;
    (match o with
	 (SyntacticNts(syn_nts),ReadingNts(read_nts), RecognizingNts(recog_nts), Terminals(ter_syms)) ->
	   os "Syntactic non-terminals (defined by syntactic productions):\n  ";
	   stringset_print os syn_nts;
	   os "\n\nReading non-terminals (defined by lexical ->-productions):\n  ";
	   stringset_print os read_nts;
	   os "\n\nRecognizing non-terminals (defined by lexical =>-productions):\n  ";
	   stringset_print os recog_nts;
	   os "\n\nTerminal symbols:\n  ";
	   stringset_print os ter_syms;
	   os "\n\n";
    );
    os "\n\n";;

let compare_productions (Prod(name1,lhs1,rhs1)) (Prod(name2,lhs2,rhs2)) : int =
  let c = compare lhs1 lhs2 in
    if c <> 0 then
      c
    else
      compare rhs1 rhs2;;

let terminal_to_string (x:Gra2srs_syntax.__terminal__) : string = match x with (pd,s) -> s;;
let terminal_list_to_string_list = List.map terminal_to_string;;

let to_ast (Gra2srs_syntax.Grammar(_,(_,name),_,(_,start),ows',(_,ops), (_,olx),(_,ovs),(_,ors))) : grammar =
  let dbgc = debugger dbg_grammar_to_ast in
  let opt_list x =
    match x with
	Some(_,(_,x')) -> x'
      | None -> []
  in
  let ows = 
    match ows' with
	(_,Some(_,(_,f))) -> Some(f)
      | _ -> None
  in

  let ps = opt_list ops in
  let lx = opt_list olx in
  let vs = opt_list ovs in
  let rs = opt_list ors in

  (* vars tells which symbols are variables, while varnums maps variables to 
     integers (since our Var ctor takes an int).  We use curvar to hold the
     next int to use. *)
  let vars = Trie.trie_new() in
  let curvar = ref 0 in
  let currule = ref 0 in

  let rec convert_term (varnums:int trie) (t:Gra2srs_syntax.term) : term =
    match t with
	Gra2srs_syntax.App(_,f,_,Gra2srs_syntax.Args(p,arg,(_,args)),_) ->
	  App(terminal_to_string f,List.map (fun (_,arg) -> convert_term varnums arg) ((p,arg)::args))
      | Gra2srs_syntax.App(_,f,_,Gra2srs_syntax.Empty(_),_) ->
	  App(terminal_to_string f,[])
      | Gra2srs_syntax.Sym(_,(_,x)) ->
	  if trie_contains vars x then
	    Var(match trie_lookup varnums x with
		    None -> 
		      incr curvar;
		      trie_insert varnums x !curvar;
		      !curvar
		  | Some(x) -> x)
	  else
	    App(x,[]) 
  in
  let convert_rule (Gra2srs_syntax.Rule(_,t1,_,t2)) =
    let varnums = Trie.trie_new() in
      curvar := 0;
      let lhs = convert_term varnums t1 in
      let rhs = convert_term varnums t2 in
      let rl = Rule((string_of_int !currule,!curvar), lhs, rhs) in
	incr currule;
	rl
  in
  let convert_rules (rs:Gra2srs_syntax.rule list) : rule list =
    List.map convert_rule rs 
  in
  let prods_cache = trie_new() in 
  let lexs_cache = trie_new() in 
  let newps = ref [] in (* new productions we are adding *)
  let newls = ref [] in (* new lexicals we are adding *)
  let are_lexical = ref false in (* global flag saying whether we are adding lexical or syntactic productions *)

  let for_new_nt = ref "" in
  let for_new_rl = ref "" in
  let lex_role = ref Reading in

  let nt_num = ref 0 in
  let new_nt(nt:string) = incr nt_num; !for_new_nt^nt^"-"^(string_of_int !nt_num) in

  (* uniquify rule names *)
  let rulename_map = trie_new() in
  let start_rule (s:string) : string =
    let rulename (s:string) : string =
      if s = "embed" then s 
      else
	match trie_lookup rulename_map s with
	    None ->
	      trie_insert rulename_map s 1;
	      s
	  | Some(i) ->
	      trie_insert rulename_map s (i+1);
	      s^"/"^(string_of_int i)
    in
    let s' = rulename s in
      for_new_rl := s';
      s'
  in
  let pname_num = ref 0 in

  let add_prod_n (name:string)(lhs:string)(rhs:string list) : unit =
    let str = String.concat " " (lhs::rhs) in
      match trie_lookup prods_cache str with
	  None ->
	      newps := Prod(name,lhs,rhs)::!newps;
	      trie_insert prods_cache str name
	| Some(pn) -> 
	    wr dbgc "add_prod_n: cached rule ";
	    wr dbgc lhs;
	    wr dbgc " -> ";
	    print_strings (wr dbgc) " " rhs;
	    wr dbgc "\n"
  in
  let add_prod (lhs:string)(rhs:string list) : unit =
    let pn = !for_new_rl^"-"^(string_of_int !pname_num) in
      incr pname_num; 
      add_prod_n pn lhs rhs
  in
  let add_prod_c(are_lexical:bool)(lex_role:role)(lhs:string)(rhs:string list) : unit =
    if are_lexical then
      (let str = String.concat " " (lhs::rhs) in
	 match trie_lookup lexs_cache str with
	     None ->
	       newls := Lex(lex_role,lhs,rhs)::!newls;
	       let _ = stringset_add lexs_cache str in ()
	   | Some(_) -> ())
    else
      add_prod lhs rhs
  in
  let add_prod (lhs:string)(rhs:string list) : unit = add_prod_c !are_lexical !lex_role lhs rhs in
  let prim_cache = trie_new() in
  let conv_prim (p:Gra2srs_syntax.prim) : string = 
    match p with
	Gra2srs_syntax.PrimId(_,(_,s)) -> s
      | Gra2srs_syntax.PrimStringLit(_,(_,s)) -> 
	  (* we currently do not do the following:

	     pull quoted strings into the lexical rules, to
	     compact the automaton generated later *)
	  if !are_lexical || true (*String.length s <= 4 *)then
	    s
	  else 
	    match trie_lookup prim_cache s with
		None ->
		  (* pull string literals from productions into lexical rules *)
		  let nt = new_nt "-lex" in
		    add_prod_c true (* lexical *) Recognizing nt [s];
		    trie_insert prim_cache s nt;
		    nt
	      | Some(nt) -> nt
  in

  let rec conv_form (f:Gra2srs_syntax.form) : string list =
    kon dbgc (fun dbgc ->
		dbgc "(conv_form ";
		Gra2srs_pp.pp_form dbgc false f;
		dbgc "\n");
    let ret = 
      match f with
	  Gra2srs_syntax.Bar(_,fa,_,f') -> 
	    let ss1 = conv_forma fa in
	    let ss2 = conv_form f' in
	    let ntp = new_nt "-bar" in
	      add_prod ntp ss1;
	      add_prod ntp ss2;
	      [ntp]
	| Gra2srs_syntax.Forma(_,fa) -> conv_forma fa
    in
      wr dbgc "returning ";
      print_strings (wr dbgc) " " ret;
      wr dbgc ")\n";
      ret
  and conv_forma (Gra2srs_syntax.Seq(_,(_,al))) : string list =
    conv_atom_list al

  and conv_atom_list (l : Gra2srs_syntax.atom list) : string list = List.concat (List.map conv_atom l)

  and conv_atom (a:Gra2srs_syntax.atom) : string list =
    (* syms is the sequence for the translation of the body of 'a' (which could be terminal or nonterminal) *)
    wr dbgc "(conv_atom ";
    if dbg_on dbgc then Gra2srs_pp.pp_atom (wr dbgc) false a;
    wr dbgc "\n";
    let add_iter_rules (is_star:bool) (ss:string list) : string =
      let ntp = new_nt (if is_star then "-star" else "-plus") in
	add_prod ntp (if is_star then [] else ss);
	add_prod ntp (ss @ [ntp]);
	ntp
    in
    let conv_charset_prim (c:Gra2srs_syntax.charset_prim) : int list =
      (* s should be a string for a character literal or escaped char literal (e.g., "'a'" or "'\n'") *)
      let chrcode s = 
	Char.code (map_escaped s)
      in
	match c with
	    Gra2srs_syntax.Char(d,(_,l)) ->
	      let e = explode_quoted l in
		if List.length e <> 1 then
		  err ("Error"^(Gra2srs_util.string_of_pos d)^": a charset expression contains a literal which is not a single character.\n");
		[chrcode l]
	  | Gra2srs_syntax.Range(d,(_,l1),_,(_,l2)) ->
	      let e1 = explode_quoted l1 in
	      let e2 = explode_quoted l2 in
		if List.length e1 * List.length e2 <> 1 then
		  err ("Error"^(Gra2srs_util.string_of_pos d)^": a character range has bounds which are not single characters.\n");
		let c1 = chrcode l1 in
		let c2 = chrcode l2 in
		  if c1 > c2 then
		    err ("Error"^(Gra2srs_util.string_of_pos d)
			 ^": the lower bound in a character range is greater than the upper bound.\n");
		  let rec helper (cur:int) : int list =
		    if cur > c2 then
		      []
		    else
		      cur::(helper (cur+1))
		  in
		    helper c1
    in

    let invert_set (cs:int list) : int list =
      let max_char = 127 in
      let arr = Array.make (max_char + 1) false in
	List.iter (fun c -> arr.(c) <- true) printable_ascii;
	List.iter (fun c -> arr.(c) <- false) cs;
	let cs' = ref [] in
	  for i = 0 to max_char do
	    if arr.(i) then
	      cs' := i::!cs'
	  done;
	  List.rev !cs'
    in
      
    let ret = 
      let (ss,p) = 
	match a with
	    Gra2srs_syntax.Id(_,x,p) -> 
	      let x = conv_prim x in
		([x],p)
	  | Gra2srs_syntax.Marker(d,_) -> (["posinfo"], Gra2srs_syntax.Plain(d))
	  | Gra2srs_syntax.Paren(_,_,f,_,p) -> (conv_form f,p) 
	  | Gra2srs_syntax.Charset(d,(_,otilde),_,(_,cs),_,p) ->
	      let nt = new_nt "-range" in
	      let mk_str (c:int) : string = quote (String.escaped (String.make 1 (Char.chr c))) in
	      let chars = List.sort compare (List.concat (List.map conv_charset_prim cs)) in
	      let chars = 
		match otilde with
		    None -> chars
		  | Some(_) -> invert_set chars
	      in
	      let strs = List.map mk_str chars in
		List.iter (fun s -> add_prod nt [s]) strs;
		([nt], p)
      in
	match p with
	    Gra2srs_syntax.Star(_,_) -> [add_iter_rules true ss]
	  | Gra2srs_syntax.Plus(_,_) -> [add_iter_rules false ss]
	  | Gra2srs_syntax.Plain(_,_) -> ss
	  | Gra2srs_syntax.Qmark(_) -> 
	      let nt = new_nt "-opt" in
		add_prod nt ss;
		add_prod nt [];
		[nt]
    in
      kon dbgc (fun dbgc ->
		  dbgc "returning (";
		  print_strings dbgc " " ret;
		  dbgc "))\n");
      ret
  in
  let conv_prod_helper (name:string) (lhs:string) (f:Gra2srs_syntax.form option) : unit = 
    pname_num := 0;
    for_new_nt := lhs;
(*    if not (is_capitalized name) then
      err ("The name \""^name^"\" of a production is not capitalized (production names should be)."); *)
    let name = start_rule name in
(*      if is_capitalized lhs then
	err ("The lhs \""^lhs^"\" of a production is capitalized (nonterminals should be lowercase).");*)
      let rhs = (match f with Some(f) -> conv_form f | _ -> []) in
	add_prod_n name lhs rhs
  in
  let conv_prod (p:Gra2srs_syntax.prod) : unit = 
    match p with
	Gra2srs_syntax.Prod(_,(_,n),_,(_,s),_,(_,f),_) ->
	  conv_prod_helper n s f
      | Gra2srs_syntax.ProdUnnamed(_,(_,s),_,(_,f),_) ->
	  (* we will use the nonterminal as the production name *)
	  conv_prod_helper (String.capitalize s) s f
  in
  let conv_lex (p:Gra2srs_syntax.lex) : unit = 
    match p with
	Gra2srs_syntax.Lex(_,(_,lhs),o,(_,f),_) ->
	  pname_num := 0;
	  for_new_nt := lhs;
	  lex_role := (match o with
			   Gra2srs_syntax.LexArrow(_,_) -> Reading
			 | Gra2srs_syntax.LexThickArrow(_,_) -> Recognizing);
	  let rhs = (match f with Some(f) -> (conv_form f) | _ -> []) in
	    add_prod lhs rhs
  in
  let conv_prods (ps:Gra2srs_syntax.prod list) : production list =
    are_lexical := false;
    List.iter conv_prod ps; 
    List.rev !newps 
  in
  let conv_lexs (lx:Gra2srs_syntax.lex list) : lexical list =
    are_lexical := true;
    List.iter conv_lex lx;
    List.rev !newls 
  in

  wr dbgc "(Converting syntactic productions begins.\n";

    (* we are including an empty production for position information; this will be handled specially in the emitted code *)
  let syn_prods = (Prod("Posinfo","posinfo",[])) :: conv_prods ps in
  wr dbgc "Converting syntactic productions ends.)(Converting lexical productions begins\n";
  let all_lexs = conv_lexs lx in 
  wr dbgc "Converting lexical productions ends.)\n";
  let change_special s = 
    if s = "space" then (quote (Char.escaped ' '))(*"\' \'"*) else if s = "quote" then (quote (Char.escaped '\''))(*"\'\'\'"*) else s in
  let oopt_ws =
    match ows with
	None -> None
      | Some(ws) -> Some(ws,"opt_"^ws)
  in
  let (ws_str,opt_ws_str) = match oopt_ws with None -> ([],[]) | Some(ws,opt_ws) -> ([ws],[opt_ws]) in
  let rec process_side (is_lex:bool) ss = 
    match ss with
	[] -> []
      | s :: ss' ->
	  let s = change_special s in
	    if is_quoted s then
	      (if is_lex then [] 
	       else opt_ws_str)
	      @ (Util.explode_quoted s) @ (process_side is_lex ss')
	    else 
	      s::(process_side is_lex ss')
  in

  wr dbgc "(Processing sides of productions begins.\n";
  let syn_prods =
    List.map (fun (Prod(n,s,ss)) -> Prod(n,s,process_side false ss)) syn_prods in
  let all_lexs =
    List.map (fun (Lex(r,s,ss)) -> Lex(r,s,process_side true ss)) all_lexs in
  wr dbgc "Processing sides of productions ends.)\n";
  let is_reading (Lex(r,s,ss)) =
    match r with Reading -> true | _ -> false
  in
  wr dbgc "(Computing nonterminals and sides begins.\n";
  let find_nts sides = stringset_of_strings (List.map (fun (_,s,_) -> s) sides) in
  let syn_sides = List.map (fun (Prod(_,s,ss)) -> (Reading,s,ss)) syn_prods in
  let syn_nts = find_nts syn_sides in
  let lexes_to_sides = List.map (fun (Lex(r,s,ss)) -> (r,s,ss)) in
  let read_sides = lexes_to_sides (List.filter is_reading all_lexs) in
  let read_nts = find_nts read_sides in
  let recog_sides = lexes_to_sides (List.filter (fun l -> not (is_reading l)) all_lexs) in
  let recog_nts = find_nts recog_sides in
  let lex_nts = stringset_union read_nts recog_nts in

  wr dbgc "Computing nonterminals and sides ends.)\n";
  (* add a production for optional whitespace, if whitespace is requested *)
  let (all_lexs,read_sides,recog_sides) = 
    (match oopt_ws with
	 None -> (all_lexs,read_sides,recog_sides)
       | Some(ws,opt_ws) ->
	   if (trie_contains syn_nts opt_ws || trie_contains lex_nts opt_ws) then
	     (print_string "To incorporate whitespace \"";
	      print_string ws;
	      print_string "\", we need to introduce nonterminal \"";
	      print_string opt_ws;
	      print_string "\", which is already defined in the grammar.\n";
	      exit 1);
	   let new_lexs r = [Lex(r,opt_ws,[ws]); Lex(r,opt_ws,[])] in
	     stringset_add lex_nts opt_ws;
	     if trie_contains read_nts ws then
	       let new_ls = new_lexs Reading in
		 stringset_add read_nts opt_ws;
		 (new_ls @ all_lexs, (lexes_to_sides new_ls) @ read_sides, recog_sides)
	     else
	       (if not (trie_contains recog_nts ws) then
		  (print_string "Whitespace has been requested, but \"";
		   print_string ws;
		   print_string "\" is not a lexical nonterminal.\n";
		   exit 1);
		let new_ls = new_lexs Recognizing in
		  stringset_add recog_nts opt_ws;
		  (new_ls @ all_lexs, read_sides, (lexes_to_sides new_ls) @ recog_sides)))
  in
    
  let lex_sides = read_sides @ recog_sides in

  (* if we have ws, insert optional ws in front of every symbol in the syntactic
     productions which is not a syntactic nonterminal, except we will
     not insert optional ws in front of ws, opt_ws or a symbol preceded by either 
     ws or opt_ws. We have to watch for opt_ws here because we have already inserted
     opt_ws in front of certain string literals in syntactic productions. *)
  wr dbgc "(Inserting whitespace if requested begins.\n";
  let syn_prods = 
    match oopt_ws with
	None -> syn_prods
      | Some(ws,opt_ws) ->
	  let rec insert_ws (skip_to_next_unquoted:bool) (skip_next_non_ws:bool) (ss:string list) : string list =
	    match ss with
		[] -> []
	      | s::ss' ->
		  if s = ws || s = opt_ws then
		    (* if we see ws, we skip the next symbol if it is not ws (corner case) *)
		    s::(insert_ws true true ss')
		  else if skip_to_next_unquoted && is_quoted s then
		    s :: (insert_ws true false ss')
		  else if trie_contains syn_nts s then
		    s::(insert_ws false false ss')
		  else if skip_next_non_ws then
		    s::(insert_ws false false ss')
		  else if s = sos_terminal (* another corner case: we do not want to insert ws in front of _sos *) then
		    s::(insert_ws false false ss')
		  else
		    opt_ws::s::(insert_ws true false ss')
	  in
	    List.map (fun (Prod(n,s,ss)) -> Prod(n,s,insert_ws false false ss)) syn_prods
  in
    wr dbgc "Inserting whitespace if requested ends).\n";
  (* the above re-definition of syn_prods does not change syn_nts, only syn_sides *)
  let syn_sides = List.map (fun (Prod(_,s,ss)) -> (Reading,s,ss)) syn_prods in
  let all_sides = syn_sides @ lex_sides in

  let is_nt s = (trie_contains lex_nts s) || (trie_contains syn_nts s) in
  wr dbgc "(Computing terminals begins.\n";
  let ter_syms = 
    let ter = Trie.trie_new() in
      List.iter (fun (_,_,ss) -> List.iter (fun s -> 
					      wr dbgc ("[symbol "^s^"]\n"); 
					      if not (is_nt s) then stringset_add ter s) ss) all_sides;
      ter
  in
  wr dbgc "Computing terminals ends.)\n";
    
  (* perform some consistency checks on the grammar: *)

  (* the 3 sets of nonterminals are disjoint *)
  let check_intersection what1 s1 what2 s2 =
    let i = stringset_intersect s1 s2 in
    let is = trie_strings i in
      if nonempty is then
	(print_string "This grammar defines these symbols as both a ";
	 print_string what1;
	 print_string " symbol and a ";
	 print_string what2;
	 print_string " symbol:\n  ";
	 print_strings print_string " " is;
	 print_string "\n";
	 exit 1)
  in
  let check_not_used what1 sset what2 sides =
    List.iter (fun (r,s,ss) ->
		 List.iter (fun s -> 
			      if trie_contains sset s then 
				(print_string "A ";
				 print_string what2;
				 print_string " production of the grammar is using a ";
				 print_string what1;
				 print_string " symbol.\n";
				 print_string "\n1. The production: ";
				 print_core_prod print_string r s ss;
				 print_string "\n2. The symbol: ";
				 print_string s;
				 print_string "\n";
				 exit 1))
		   ss)
      sides
  in
  let legal_ter s =
    if (is_quoted s) then
      true
    else if s = eos_terminal then
      true
    else if s = sos_terminal then
      true
    else
      false
  in
  let check_ter (ter_strs:string list) =
    let illegal = List.filter (fun s -> not (legal_ter s)) ter_strs in
      if nonempty illegal then
	(print_string "The following symbols in the grammar are not generated by any productions:\n  ";
	 print_strings print_string " " illegal;
	 print_string "\n";
	 exit 1)
  in
    wr dbgc "(Performing checks on the productions begins.\n";
    check_intersection "syntactic" syn_nts "reading lexical" read_nts;
    check_intersection "syntactic" syn_nts "recognizing lexical" recog_nts;
    check_intersection "reading lexical" read_nts "recognizing lexical" recog_nts;

    check_not_used "syntactic" syn_nts "reading lexical" read_sides;
    check_not_used "syntactic" syn_nts "recognizing lexical" recog_sides;
(*    check_not_used "reading lexical" read_nts "recognizing lexical" recog_sides; *)
    
    check_ter (trie_strings ter_syms);

    wr dbgc "Performing checks on the productions ends.)\n";
    if not (is_nt start) then
      (print_string "The start symbol \"";
       print_string start;
       print_string "\" is not a nonterminal of the grammar.\n";
       exit 1);

    (* find nonterminals with a looping rule *)
    let _ = 
      let unit_index = trie_new() in
	List.iter (fun (_,s,ss) -> 
		     match ss with
			 [s'] -> trie_cons unit_index s s'
		       | _ -> ()) all_sides;
	let seen = trie_new() in
	let rec traverse_unit c n = 
	  if trie_contains seen n then
	    let c = List.rev c in
	      print_string "The grammar contains cyclic unit productions:\n  ";
	      print_strings print_string " ->* " c;
	      print_string " ->* ";
	      print_string (List.hd c);
	      print_string "\nThis makes the grammar ambiguous.\n";
	      exit 1
	  else
	    (stringset_add seen n;
	     List.iter (traverse_unit (n::c)) (list_trie_lookup unit_index n);
	     trie_remove seen n) 
	in
	  List.iter (traverse_unit []) (trie_strings unit_index)
    in


      (* initialize vars for the benefit of convert_rules *)
      List.iter (fun (_,x) -> Trie.trie_insert vars x ()) vs; 
      
      (* we will sanity check the rules in trs.ml *)

	Grammar(name,start,ows,
		(SyntacticNts(syn_nts), ReadingNts(read_nts), RecognizingNts(recog_nts), Terminals(ter_syms)),
		syn_prods, all_lexs, Trs(convert_rules rs))
;;

