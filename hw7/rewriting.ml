open Trie;;
open Grammar;;
open Trs;;
open Util;;
open Term;;

let rec right_strs (t:term) : string list =
  match strip_normal t with
      App(f,[arg1;arg2]) ->
	(match strip_normal arg1 with
	     App(g,_) ->
	       f::g::(right_strs arg2)
	   | _ -> [f])
    | App(f,args) -> [f]
    | _ -> []
;;

let right_str (t:term) : string = String.concat " " (right_strs t);;

let compute_rewrite_map (rs:rule list) : rule list trie =
  let ind = trie_new() in
    List.iter
      (fun r ->
	 let Rule(_,lhs,_) = r in
	 let str = right_str lhs in
	   trie_cons ind str r)
      rs;
    ind;;

let print_rewrite_map (os:string -> unit) (rm:rule list trie) : unit =
  trie_print
    os
    (fun rs ->
       List.iter (fun r -> os "\n  "; print_rule os r) rs;
       os "\n")
    rm;;

let rec do_match (subst:term option array) (t1:term) (t2:term) : bool =
  match t1 with
      Var(x) ->
	(match subst.(x) with
	     None -> subst.(x) <- Some(t2); true
	   | Some(t1') -> do_match subst t1' t2)
    | Normal(t1') -> do_match subst t1' t2
    | App(f1,args1) ->
	let t2 = strip_normal t2 in
	match t2 with
	    Var(_) | Normal(_) (* should not happen *) -> false
	  | App(f2,args2) ->
	      if f1 <> f2 then
		false
	      else
		match_args subst args1 args2
and match_args (subst:term option array)  (args1:term list) (args2:term list) : bool =
  match args1,args2 with
      t1::args1',t2::args2' ->
	if do_match subst t1 t2 then
	  match_args subst args1' args2'
	else
	  false
    | [],[] -> true
    | _,_ -> false (* we will treat different arity uses of the same function as uses
		      of different functions *);;

(* match t1 as pattern against t2 as target.
   We assume t1's vars are renamed away from t2's.  maxv should be an upper bound on vars in t1.  *)
let do_match (dbg:debugger_t) (maxv:int) (t1:term) (t2:term) : term option array option =
  let subst = Array.make (maxv+1) None in
    kon dbg
      (fun dbg ->
	 dbg "(do_match ";
	 print_term dbg t1;
	 dbg " and ";
	 print_term dbg t2;
	 dbg "\n");
    if (do_match subst t1 t2) then
      (wr dbg "found match.)\n";
       (*print_trie (print_term dbg) subst;
       dbg "\n)\n"; *)
       Some(subst))
    else
      (wr dbg "no match.)\n";
       None);;

let rec apply_subst (subst:term option array) (t:term) : term =
  match t with
      Var(x) -> 
	(match subst.(x) with
	     None -> t
	   | Some(t') -> t')
    | Normal(t') -> apply_subst subst t'
    | App(f,args) ->
	App(f,List.map (apply_subst subst) args);;

(* handle the special case for our multi-arity string-append *)
let normalize_string_append dbg t =
  let rec helper t =
    kon dbg
      (fun dbg ->
	 dbg "(normalize_string_append.helper ";
	 print_term dbg t;
	 dbg "\n");
    let t = strip_normal t in
    let ret = 
      match t with
	  App(f,args) -> 
	    if f = Trs.string_append then
	      if empty args then
		(false,true,t)
	      else
		let (b,args') = helper_args (List.tl args) in
		  (b,true,App(f, (const (string_of_int ((List.length args') - 1))) :: args'))
	    else
	      (false, false, t)
	| _ -> (false, false, t)
    in
    kon dbg
      (fun dbg ->
	 let (b1,b2,t') = ret in
	   dbg "changed = ";
	   print_bool dbg b1;
	   dbg ", is-string-append = ";
	   print_bool dbg b2;
	   dbg ", resulting term = ";
	   print_term dbg t';
	   dbg ")\n");
      ret
  and helper_args args = 
    match args with
	[] -> (false,[])
      | arg::args' -> 
	  let (b2,args2) = helper_args args' in

	  match helper arg with
	      (_,true,App(_,lenarg::args1)) ->
		(true,args1 @ args2)
	    | _ -> (b2, arg :: args2)
  in 
  let (changed,is_string_append,t') = helper t in
    if changed then
      Some(t')
    else
      None
;;

(* singleton iff we did not rewrite anything.
   We return the list in order from newest to oldest.
*)
let rec rewrite_top (dbg:debugger_t) (rewritemap:rule list trie) (t:term) : term list =
  let rec try_rules (rs:rule list) : term list =
    match rs with
	[] -> [t]
      | r::rs' ->
	  let Rule((_,maxv2),lhs,rhs) = r in
	    kon dbg
	      (fun dbg ->
		 dbg "trying rule\n  ";
		 print_rule dbg r);
	    match do_match nodbg maxv2 lhs t with
		None -> try_rules rs'
	      | Some(u) -> 
		  let newt = apply_subst u rhs in
		    (rewrite_top dbg rewritemap newt)@[t]
  in
    match normalize_string_append dbg t with
	Some(t') -> 
	  wr dbg "normalized string-append term\n";
	  [t' ; t]
      | None ->
	  let str = right_str t in
	    kon dbg
	      (fun dbg ->
		 dbg "(rewrite_top ";
		 print_term dbg t;
		 dbg "\n";
		 
		 dbg "(Looking for any rules matching a prefix of:  ";
		 dbg str;
		 dbg " )\n");
	    let ret = 
	      let rs = List.concat (List.map snd (trie_lookup_prefix rewritemap str)) in
		try_rules rs
	    in
	      kon dbg
		(fun dbg ->
		   dbg "rewrite_top returning ";
		   List.iter (fun t -> dbg "::"; print_term dbg t) ret;
		   dbg ")\n");
	      ret
;;

(* maxv should be an upper bound on the max var in t 

   we return the terms in order from newest to oldest, including the original term.
*)
let rec rewrite_inner (dbg:debugger_t) (mark_normal:bool) (rewritemap:rule list trie) (t:term) : term list =
  kon dbg
    (fun dbg ->
       dbg "(rewrite_inner ";
       print_term dbg t;
       dbg "\n");

  let ret = 
    match t with
	Var(x) -> [t]
      | Normal(t') -> [t']
      | App(f,args) ->
	  (* return in order from oldest (least rewritten) to newest *)
	  let rec do_inner prev_args args =
	    kon dbg
	      (fun dbg ->
		 dbg "(do_inner prev_args = ";
		 print_args dbg prev_args;
		 dbg "; args = ";
		 print_args dbg args;
		 dbg "\n");
	    let ret = 
	      match args with
		  [] -> []
		| arg::args' ->
		    let rs = rewrite_inner dbg mark_normal rewritemap arg in
		    let c = do_inner (prev_args @ [List.hd rs]) args' in
		      if singleton rs then
			(* we did not rewrite arg *)
			(wr dbg "(Singleton rs.)\n";
			 c)
		      else
			(wr dbg "(Calling map_end.)\n";
			 (* call List.rev so that we can get rs in order from oldest to most recent *)
			 map_end (fun r -> App(f,prev_args @ [r] @ args')) (List.rev rs) c)
	    in
	      kon dbg 
		(fun dbg ->
		   dbg "do_inner returning: ";
		   List.iter (fun t -> dbg "::"; print_term dbg t) ret;
		   dbg ")\n");
	      ret
	  in
		  
	  let tmp = dot_flatten t in
	    if eq_term nodbg t tmp then
	      (* we did not dot-flatten t *)
	      let ts = List.rev (do_inner [] args) in
	      let ts = if empty ts then t::ts else ts in
		(* ts is now in order from most recent to oldest, starting with the current term *)
	      let ts' = rewrite_top dbg rewritemap (List.hd ts) in
		if singleton ts' then
		  ts
		else
		  (rewrite_inner dbg mark_normal rewritemap (List.hd ts')) @ (List.tl ts') @ (List.tl ts)
	    else
	      (* we did dot-flatten t *)
	      (kon dbg
		 (fun dbg ->
		    dbg "(Flattened dot expression to: "; 
		    print_term dbg tmp; 
		    dbg ")\n");
	       (rewrite_inner dbg mark_normal rewritemap tmp) @ [t])
  in
  let ret = 
    if mark_normal then 
      match ret with
	  t::ret' -> (Normal(t))::ret'
	| _ -> err "Internal error2 in rewrite_inner"
    else ret 
  in
    kon dbg
      (fun dbg ->
	 dbg "rewrite_inner returning ";
	 List.iter (fun t -> dbg "::"; print_term dbg t) ret;
	 dbg ")\n");
    ret
;;

let rewrite_inner_rules (dbg:debugger_t) (mark_normal:bool) (rs:rule list) (t:term) : term list =
  rewrite_inner dbg mark_normal (compute_rewrite_map rs) t;;

let rewrite_inner_trs (dbg:debugger_t) (mark_normal:bool) (s:trs) (t:term) : term list =
  match s with
      Trs(rs) -> rewrite_inner_rules dbg mark_normal rs t;;
