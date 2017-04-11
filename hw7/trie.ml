open Intmap;;
open Char;;

(***************************************************)
(* inttries                                        *)
(*                                                 *)
(* These map lists of ints to values.              *)
(***************************************************)

type 'a inttrieh = 
    Tnone 
  | Texact of int list * 'a
  | TnextMap of 'a option * ('a inttrieh intmap)

(* to avoid dependence on OCaml 3.12: *)
let bindings (m:'a inttrieh intmap) : (int * 'a inttrieh) list =
  let li = ref [] in
    intmap_iter m (fun k v -> li := (k,v)::!li);
    List.rev !li;;

(* if an int has value more than this, we will switch to Maps instead of arrays *)
let val_cutoff = 128;;

type 'a inttrie = ('a inttrieh) ref;;

let inttrie_update (t:'a inttrie) (s:int list) (a:'a option) : unit = 
  let h = !t in
  let rec inttrieh_update (t:'a inttrieh) (s:int list) (a:'a option) : 'a inttrieh = 
    match t with 
	Tnone -> 
	  (match a with
	       None -> t
	     | Some(v) -> Texact(s,v))
      | Texact(s',v') ->
	  (match a with
	      None ->
		(* check if we are removing exactly s *)
		if s = s' then
		  Tnone
		else
		  t
	     | Some(v) ->
		 if s = s' then
		   Texact(s',v)
		 else
		   let newt = TnextMap(None,intmap_empty) in
		     (* insert both value into the new trie *)
		     inttrieh_update (inttrieh_update newt s' (Some(v'))) s a)
      | TnextMap(o,m) ->
	  match s with
	      [] -> TnextMap(a,m)
	    | c::s' ->
		let h' = 
		  match intmap_lookup m c with
		    Some(x) -> x
		  | None -> Tnone
		in
		  TnextMap(o, intmap_insert m c (inttrieh_update h' s' a))
  in
    t := (inttrieh_update h s a);;

let inttrie_lookup (t:'a inttrie) (s:int list) = 
  let h = !t in
  let rec inttrieh_lookup t (s:int list) = 
    match t with
	Tnone -> None
      | Texact(s',v) ->
	  if s = s' then Some(v) else None
      | TnextMap(o,m) ->
	  (match s with
	       [] -> o
	     | c::s' -> 
		match intmap_lookup m c with
		  None -> None
		| Some(x) -> 
		   inttrieh_lookup x s')
  in
    inttrieh_lookup h s;;

let rec is_prefix (l1:'a list) (l2:'a list) : bool =
  match l1,l2 with
      x::l1',y::l2' -> if x = y then is_prefix l1' l2' else false
    | [],_ -> true
    | _,_ -> false;;

(* we return a list of pairs (s',v) where s' is a prefix of s and the trie maps s' to v. *)
let inttrie_lookup_prefix (t:'a inttrie) (s:int list) : (int list * 'a) list = 
  let rec inttrieh_lookup t (pref:int list) (s:int list) = 
    match t with
	Tnone -> []
      | Texact(s',v) ->
	  if is_prefix s' s then [(List.rev_append pref s', v)] else []
      | TnextMap(o,m) ->
	  let l1 = 
	    match o with
		None -> []
	      | Some(v) -> [(List.rev pref,v)]
	  in
	  (match s with
	       [] -> l1
	     | c::s' -> 
		 l1 @
		   (match intmap_lookup m c with
		      Some(t) ->
		      (inttrieh_lookup t (c::pref) s')
		    | None -> []))
  in
  let h = !t in
    inttrieh_lookup h [] s;;

let inttrie_domain (t:'a inttrie) : int list list = 
  let h = !t in
  let rec helper (t : 'a inttrieh) (sofar : int list) (strs : int list list) : int list list =
    match t with 
	Tnone -> strs
      | Texact(l,v) -> ((List.rev sofar) @ l)::strs
      | TnextMap(o,m) -> 
	  match o with
              None -> helper_map (bindings m) sofar strs
            | Some(trm) -> helper_map (bindings m) sofar ((List.rev sofar)::strs)
  and helper_map (m : (int * 'a inttrieh) list) (sofar : int list) (strs : int list list) : int list list =
    match m with
	[] -> strs
      | (k,v)::m' ->
	  let elem_strings = helper v (k::sofar) strs in
	    helper_map m' sofar elem_strings
  in
    helper h [] [];;

(* we return a list of values to which the trie maps s @ s', for any s'. *)
let inttrie_lookup_extension (t:'a inttrie) (s:int list) : 'a list = 
  let rec helper t (s:int list) = 
    match t with
	Tnone -> []
      | Texact(s',v) ->
	  if is_prefix s s' then [v] else []
      | TnextMap(o,m) ->
	  match s with
	      [] -> 
		let t1 = ref t in
		  (List.map (fun k -> 
			       match inttrie_lookup t1 k with 
				   Some(v) -> v
				 | None -> print_string "Internal error in inttrie_lookup_extension"; exit 1)
		     (inttrie_domain t1))
	    | c::s' -> 
		(match intmap_lookup m c with
		   Some(t) -> helper t s'
		 | None -> [])
  in
  let h = !t in
    helper h s;;

let inttrie_new () : 'a inttrie = ref (Tnone);;
let inttrie_insert (t:'a inttrie) (s:int list) (a:'a) : unit = inttrie_update t s (Some(a));;
let inttrie_remove (t:'a inttrie) (s:int list) : unit = inttrie_update t s None;;
let inttrie_update (t:'a inttrie) (s:int list) (a:'a option) : unit = inttrie_update t s a;;
let inttrie_contains (t:'a inttrie) (s:int list) : bool =
  match (inttrie_lookup t s) with
      Some(_) -> true
    | _ -> false;;

let inttrie_clear (t:'a inttrie) : unit = 
  t := Tnone;;
let inttrie_clone (t:'a inttrie) : 'a inttrie =
  let t2 = inttrie_new () in
    List.iter (fun s -> inttrie_update t2 s (inttrie_lookup t s)) (inttrie_domain t);
    t2;;
(* add contents of t2 to t1, overwriting bindings in t1 if there are any for the same string *)
let inttrie_merge(t1:'a inttrie)(t2:'a inttrie):unit = 
  List.iter
    (fun s ->
       match inttrie_lookup t2 s with
	   None -> () (* should not happen *)
	 | Some(v) -> 
	     inttrie_insert t1 s v)
    (inttrie_domain t2);;

let inttrie_print (os:string -> unit) (print_intlist : int list -> unit) (print_value : 'a -> unit) (t:'a inttrie) : unit = 
  os "(";
  List.iter (fun x -> 
	       print_intlist x; 
	       os " -> ";
	       (match (inttrie_lookup t x) with
		    None -> os "[internal error, missing string]" (* should never happen *)
		  | Some(d) -> print_value d);
	       os "\n")
    (inttrie_domain t);
  os ")";;

type intlist_set = unit inttrie;;
let intlist_set_new = inttrie_new ;;
let intlist_set_add (t: intlist_set) (s:int list) : unit = inttrie_update t s (Some());;
let intlist_set_remove (t: intlist_set) (s:int list) : unit = inttrie_update t s None;;
let intlist_set_contains (t: intlist_set) (s:int list) : bool = inttrie_contains t s;;
let intlist_set_ints (t: intlist_set) : int list list = inttrie_domain t;;
let intlist_set_clear (t: intlist_set) : unit = inttrie_clear t;;
let intlist_set_clone (t: intlist_set) : intlist_set = inttrie_clone t;;
let print_intlist_set (os:string -> unit) (os_intlist : int list -> unit) (t: intlist_set) : unit = 
  let first = ref true in
  List.iter (fun s -> if !first then first := false else os " "; os_intlist s) (intlist_set_ints t);;

let inttrie_cons (t:'a list inttrie) (s:int list) (a:'a) = 
  match inttrie_lookup t s with
      None -> inttrie_insert t s [a]
    | Some(l) -> inttrie_insert t s (a::l);;
  
let list_inttrie_lookup (t:'a list inttrie) (s:int list) =
  match inttrie_lookup t s with
    None -> []
  | Some(l) -> l
;;

let intlist_set_of_intlists (ss : int list list) : intlist_set =
  let t = inttrie_new () in
    List.iter (intlist_set_add t) ss;
    t
;;


(***************************************************)
(* tries                                           *)
(***************************************************)

let rec intlist_of_string s i =
  if (i = String.length s) then
    []
  else
    (Char.code s.[i])::(intlist_of_string s (i+1));;

let intlist_of_string s = intlist_of_string s 0;;

let rec string_of_intlist l i iend s =
  if i = iend then s
  else
    (String.set s i (Char.chr (List.hd l));
     string_of_intlist (List.tl l) (i+1) iend s);;

let string_of_intlist l = 
  let len = (List.length l) in
    string_of_intlist l 0 len (String.create len);;

type 'a trie = 'a inttrie;;
let max_char = 127;;
let trie_new () = inttrie_new ();;
let trie_insert (t:'a trie) (s:string) (a:'a) : unit = inttrie_update t (intlist_of_string s) (Some(a));;
let trie_remove (t:'a trie) (s:string) : unit = inttrie_update t (intlist_of_string s) None;;
let trie_lookup (t:'a trie) (s:string) = inttrie_lookup t (intlist_of_string s);;
let trie_lookup_prefix (t:'a trie) (s:string) = (List.map (fun (pref,v) -> (string_of_intlist pref,v))
						   (inttrie_lookup_prefix t (intlist_of_string s)));;
let trie_lookup_extension (t:'a trie) (s:string) = (inttrie_lookup_extension t (intlist_of_string s));;
let trie_update (t:'a trie) (s:string) (a:'a option) = inttrie_update t (intlist_of_string s) a;;
let trie_contains (t:'a trie) (s:string) : bool = inttrie_contains t (intlist_of_string s);;
let trie_strings (t:'a trie) : string list = 
  List.map string_of_intlist (inttrie_domain t);;
let trie_clear (t:'a trie) : unit = inttrie_clear t;;
let trie_clone (t:'a trie) : 'a trie = inttrie_clone t;;
let trie_merge (t1:'a trie)(t2:'a trie) : unit = inttrie_merge t1 t2;;
let trie_print (os:string -> unit) (print_value : 'a -> unit) (t:'a trie) : unit = 
  inttrie_print os (fun l -> os (string_of_intlist l)) print_value t;;
let trie_cons (t:'a list trie) (s:string) (a:'a) = 
  match trie_lookup t s with
      None -> trie_insert t s [a]
    | Some(l) -> trie_insert t s (a::l);;

let trie_append (t:'a list trie) (s:string) (l:'a list) = 
  match trie_lookup t s with
      None -> trie_insert t s l
    | Some(l') -> trie_insert t s (l @ l');;
  
let list_trie_lookup (t:'a list trie) (s:string) : 'a list =
  match trie_lookup t s with
      None -> []
    | Some(l) -> l;;
  
let list_trie_dump (t:'a list trie) : (string * 'a list) list =
  let rec aux acc = function
    | nt::nts -> aux ((nt,list_trie_lookup t nt)::acc) nts
    | [] -> acc
  in
  aux [] (trie_strings t)
;;
  

let list_trie_uniq (t:'a list trie) (cmp:'a -> 'a -> int) : unit =
  List.iter
    (fun s ->
     match trie_lookup t s with
       None -> () (* should not happen *)
     | Some(rs) -> trie_insert t s (Util.uniq cmp rs))
    (trie_strings t);;    

(* compute transitive closure of a tree represented as a list trie *)
let list_trie_tc_tree (t : 'a list trie) : 'a list trie =
  let t' = trie_new() in
  let rec tc (x:'a) : 'a list = 
    match trie_lookup t' x with
	None -> 
	  let xs' = 
	    (match trie_lookup t x with
		 None -> []
	       | Some(xs) ->
		   xs @ (List.concat (List.map tc xs)))
	  in
	    trie_insert t' x xs';
	    xs'
      | Some(xs) -> xs
  in
    List.iter (fun x -> let _ = tc x in ()) (trie_strings t);
    t'
;;

(**************************************************)
(* stringsets                                     *)
(**************************************************)

type stringset = unit trie

let stringset_add_b (t:stringset) (s:string) : bool =
  if trie_contains t s then
    false
  else
    (trie_insert t s ();
     true);;
let stringset_add (t:stringset) (s:string) : unit =
  let _ = stringset_add_b t s in
    ();;

let stringset_disjoint (s1:stringset) (s2:stringset) : bool = 
  List.for_all (fun s -> not (trie_contains s1 s)) (trie_strings s2)
;;

let stringset_overlapping (s1:stringset) (s2:stringset) : bool = 
  List.exists (trie_contains s1) (trie_strings s2)
;;

let stringset_intersect (s1:stringset) (s2:stringset) : stringset = 
  let sset = trie_new() in
    List.iter (fun s -> let _ = stringset_add sset s in ())
      (List.filter (trie_contains s1) (trie_strings s2));
    sset
;;

let stringset_union (s1:stringset) (s2:stringset) : stringset = 
  let sset = trie_new() in
    List.iter (stringset_add sset) (trie_strings s1);
    List.iter (stringset_add sset) (trie_strings s2);
    sset
;;

let stringset_trie_lookup (t:stringset trie) (s:string) : stringset =
  match trie_lookup t s with
      None -> 
	let sset = trie_new() in
	  trie_insert t s sset;
	  sset
    | Some(sset) -> sset;;

(* add v to the stringset associated by t1 with s.  Return false
   if v was already there, and true otherwise (i.e., we truly added v). *)
let stringset_trie_add_b (t1:stringset trie) (s:string) (v:string) : bool =
  let sset = stringset_trie_lookup t1 s in
    if trie_contains sset v then
      false
    else
      (trie_insert sset v ();
       true)
;;
let stringset_trie_add (t1:stringset trie) (s:string) (v:string) : unit =
  let _ = stringset_trie_add_b t1 s v in ();;

let stringset_of_strings (ss : string list) : stringset =
  let t = trie_new() in
    List.iter (stringset_add t) ss;
    t
;;

(* add all strings from ss to s1, returning true iff we actually added something *)
let stringset_include_strings_b(s1:stringset) (ss:string list) : bool=
  let added = ref false in
    List.iter (fun s -> 
		 if not (trie_contains s1 s) then
		   (added := true;
		    trie_insert s1 s ()))
      ss;
    !added
;;
let stringset_include_strings(s1:stringset) (ss:string list) : unit =
  let _ = stringset_include_strings_b s1 ss in ();;

let stringset_include_b(s1:stringset) (s2:stringset) : bool=
  stringset_include_strings_b s1 (trie_strings s2)
;;

let stringset_subset (s1:stringset) (s2:stringset) : bool = 
  let rec helper ss =
    match ss with
	[] -> true
      | s::ss' ->
	  if not (trie_contains s2 s) then
	    false
	  else
	    helper ss'
  in
    helper (trie_strings s1);;

(* add the stringset sset to the stringset associated by t1 with s, returning
   true iff we actually added something. *)
let stringset_trie_include_b (t1:stringset trie) (s:string) (sset:stringset) : bool =
  match trie_lookup t1 s with
      None -> 
	 (match (trie_strings sset) with
	      [] -> false
	    | _ -> (* sset is non-empty *)
		trie_insert t1 s (trie_clone sset);
		true
	 )
    | Some(sset2) -> stringset_include_b sset2 sset;;
let stringset_trie_include (t1:stringset trie) (s:string) (sset:stringset) : unit =
  let _ = stringset_trie_include_b t1 s sset in ();;

let stringset_trie_include_strings_b (t1:stringset trie) (s:string) (ss:string list) : bool =
  match trie_lookup t1 s with
      None -> 
	(match ss with
	     [] -> false
	   | _ -> (* sset is non-empty *)
	       trie_insert t1 s (stringset_of_strings ss);
	       true
	)
    | Some(sset2) -> stringset_include_strings_b sset2 ss;;
let stringset_trie_include_strings (t1:stringset trie) (s:string) (ss:string list) : unit =
  let _ = stringset_trie_include_strings_b t1 s ss in ();;

(* copy the stringset for s2 into s1, returning true iff we actually added something *)
let stringset_trie_pull_b (t:stringset trie) (s1:string) (s2:string) : bool =
  stringset_trie_include_b t s1 (stringset_trie_lookup t s2) 
let stringset_trie_pull (t:stringset trie) (s1:string) (s2:string) : unit =
  let _ = stringset_trie_pull_b t s1 s2 in ();;

let stringset_print(os:string -> unit)(s:stringset) : unit =
  List.iter (fun s -> os s; os " ") (trie_strings s);;

let stringset_trie_print(os:string -> unit)(s:stringset trie) : unit =
  trie_print os (stringset_print os) s;;  

(**************************************************)
(* string_relations                               *)
(**************************************************)

type string_relation = stringset trie * stringset trie;;

let string_relation_new () = (trie_new(),trie_new());;

let string_relation_add (r:string_relation) (s1:string) (s2:string) : unit =
  let (fw,bk) = r in
    stringset_trie_add fw s1 s2;
    stringset_trie_add bk s2 s1
;;

let string_relation_include (r:string_relation) (s1:string) (s2:stringset) : unit =
  List.iter (fun s -> string_relation_add r s1 s) (trie_strings s2);;

let string_relation_image (r:string_relation) (s:string) : stringset =
  let (fw,bk) = r in
    stringset_trie_lookup fw s
;;

let string_relation_preimage (r:string_relation) (s:string) : stringset =
  let (fw,bk) = r in
    stringset_trie_lookup bk s
;;

let print_string_relation (os:string->unit) (r:string_relation) : unit =
  let (fw,bk) = r in
    os "((Forward mapping:\n";
    stringset_trie_print os fw;
    os ")\n(Backward mapping:\n";
    stringset_trie_print os bk;
    os "))\n"
;;

(**************************************************)
(* string tries                                   *)
(**************************************************)
let stringtrie_lookup_if (t : string trie) (s : string) =
  match trie_lookup t s with
      None -> s
    | Some(s') -> s'
;;
