type ('a, 'b) u_plus = Inj1 of 'a | Inj2 of 'b

let starting_time = Unix.gettimeofday();;

let trunc3 x = (floor (1000.0 *. x)) /. 1000.0;; 

let cursecs() : string = (string_of_float (trunc3 (Unix.gettimeofday() -. starting_time)));;

let string_of_bool b = if b then "true" else "false";;

let print_bool os b = os (string_of_bool b);;

let elapsed os = 
  os "(Time elapsed: ";
  os (cursecs());
  os ")\n";;

let sym_print = ref false;;

let err (s:string) =
  print_string s;
  print_string "\n";
  exit 1;;

let intersect (l1:'a list) (l2:'a list) : 'a list =
  List.filter (fun x -> List.mem x l1) l2;;

let rec map_end (f : 'a -> 'b) (l : 'a list) (l2:'b list) : 'b list =
  match l with
      [] -> l2
    | a::l' -> (f a)::(map_end f l' l2);;

let rec all_pairs (l1:'a list) (l2:'b list) (accum:('a * 'b) list) : ('a * 'b) list =
  match l2 with
      [] -> accum
    | b::l2' ->
	all_pairs l1 l2' (map_end (fun a -> (a,b)) l1 accum);;

let all_pairs (l1:'a list) (l2:'b list) : ('a * 'b) list = all_pairs l1 l2 [];;

let pairify (l:'a list) : ('a * 'a) list =
  let rec outer n acc = function
    | x::xs -> (
      let rec inner m acc x = function 
	| y::ys -> if m = n then acc else inner (m+1) ((y,x)::acc) x ys
	| [] -> acc
      in
      outer (n+1) ((inner 0 [] x l) @ acc) xs
    )
    | [] -> acc
  in
  outer 0 [] l
;;

let singleton_expected (l:'a list) : 'a =
  match l with
      [x] -> x
    | _ -> err "Internal error in singleton_expected.";;

let rec max_elt (x:'a) (l:'a list) : 'a =
  match l with
      [] -> x
    | a::l' ->
	let c = compare x a in
	  if c < 0 then
	    max_elt a l'
	  else
	    max_elt x l';;
	  
let max (x:'a) (y:'b) =
  let c = compare x y in
    if c < 0 then
      y
    else
      x
;;

let rec add_list (l:int list) : int =
  match l with
      [] -> 0
    | x::l' -> x+(add_list l');;

let rec pow (x:int) (y:int) : int =
  if y <= 0 then 1
  else x * (pow x (y-1));;

let rec numlist (i:int) : int list =
  if (i < 0) then []
  else
    i::(numlist (i-1));;

let print_string_flush x = print_string x; flush stdout;;

let debugger_out = ref stdout;;
let set_debugger_out (o:out_channel) : unit = 
  debugger_out := o;;

type debugger_t = (string -> unit) option;;

let nodbg : debugger_t = None;;

let debugger (b:bool ref) : debugger_t =
  let outfile = !debugger_out in
    if !b then Some(fun s -> output_string outfile s; flush outfile) else None
;;

let wr (dbg:debugger_t) (s:string) : unit = 
  match dbg with
      None -> ()
    | Some(os) -> os s
;;

let dbg_on (dbg:debugger_t) : bool = 
  match dbg with
      None -> false
    | _ -> true;;

let kon (dbg:debugger_t) (k:(string -> unit) -> unit) : unit =
  match dbg with
      None -> ()
    | Some(os) -> k os;;

let dbgif (b:bool ref) (f:unit -> unit) : unit =
    if !b then f();;

let nonempty (x:'a list) : bool =
  match x with
      [] -> false
    | _ -> true;;

let empty (x:'a list) : bool =
  match x with
      [] -> true
    | _ -> false;;

let singleton (x:'a list) : bool =
  match x with
      [y] -> true
    | _ -> false;;

let rec append_all_to_all (l1:'a list list) (l2:'a list list) (accum : 'a list list list) : 'a list list =
  match l1 with
      [] -> List.concat accum
    | l1e::l1' ->
	append_all_to_all l1' l2 ((List.map (List.append l1e) l2)::accum);;

let append_all_to_all(l1:'a list list) (l2:'a list list) : 'a list list = append_all_to_all l1 l2 [];;

let cons_to_all (a:'a) (ls : 'a list list) : 'a list list = List.map (fun l -> a::l) ls;;

let rec prefix (l1:'a list) (l2:'a list) : bool =
  match l1,l2 with
      a::l1',b::l2' ->
	if a <> b then
	  false
	else
	  prefix l1' l2'
    | [],_ -> true
    | _,_ -> false;;

let rec contains_prefix (ss : 'a list list) : bool =
  match ss with
      s::ss' ->
	if List.exists (fun s' -> prefix s s' || prefix s' s) ss' then
	  true
	else
	  contains_prefix ss'
    | [] -> false
;;

let print_list (os:string -> unit)(ose : 'a -> unit)(sep:string)(ss : 'a list) : unit =
  match ss with
      [] -> ()
    | s::ss' ->
	ose s;
	List.iter (fun s -> os sep; ose s) ss';;

let print_strings (os:string -> unit) (sep:string) (ss:string list) : unit =
  print_list os os sep ss;;

let print_ints (os:string -> unit) (sep:string) (ss:int list) : unit =
  print_strings os sep (List.map string_of_int ss);;

let rec list_eq (cmp:'a -> 'a -> int) (l1:'a list) (l2:'a list) : bool =
  match l1,l2 with
      a1::l1', a2::l2' ->
	if cmp a1 a2 = 0 then
	  list_eq cmp l1' l2'
	else
	  false
    | [],[] -> true
    | _,_ -> false;;

(* we assume l is non-empty *)
let rec split_list_last (l:'a list) : 'a list * 'a =
  match l with
      [a] -> ([],a)
    | x::l' -> 
	let (l'',y) = split_list_last l' in 
	  (x::l'',y)
    | _ -> raise (Failure("split_list_last"))
;;

let rec list_last (l:'a list) : 'a =
  let (_,x) = split_list_last l in x
;;

let list_first (l:'a list) : 'a =
  match l with 
      [] -> raise (Failure("list_first")) 
    | s::_ -> s 
;;

let cat_list (cat : string) (l : string list) : string =
  let rec aux acc = function
    | [] -> acc
    | x::[] -> acc ^ x
    | x::xs -> aux (acc ^ x ^ cat) xs
  in
  aux "" l
;;

let rec list_range (l:'a list) (first :int)(len:int) : 'a list =
  if len = 0 then
    []
  else
    match l with
	[] -> []
      | a::l' ->
	  if first = 0 then
	    a::(list_range l' first (len-1))
	  else
	    list_range l' (first-1) len;;

let rec lift_option (l : 'a option list) : 'a list option =
  match l with
      [] -> Some([])
    | a::l' ->
	match a, lift_option l' with
	    None,_ | _, None -> None
	  | Some(x),Some(l2) -> Some(x::l2);;

let rec keep_some (l:'a option list) : 'a list =
  match l with
      [] -> []
    | None::l' -> keep_some l'
    | Some(x)::l' -> x::(keep_some l')
;;

let rec charlist_of_string s i =
  if (i = String.length s) then
    []
  else
    s.[i]::(charlist_of_string s (i+1));;

let charlist_of_string s = charlist_of_string s 0;;

let rec string_of_charlist l i iend s =
  if i = iend then s
  else
    (String.set s i (List.hd l);
     string_of_charlist (List.tl l) (i+1) iend s);;

let string_of_charlist l = 
  let len = (List.length l) in
    string_of_charlist l 0 len (String.create len);;

let quote (s:string) : string =
  "\'"^s^"\'";;

(* we assume s begins and ends with a single quote.  We will turn this
   into a list of its characters, counting escape sequences and
   UTF-8 characters as single characters. *)
let explode_quoted (s:string) : string list =
  let rec explode_quoted (s:string) : string list =
    let n = String.length s in
      if n = 0 then
	[s]
      else
	if s.[0] = '\'' then
	  helper s 1 n
	else
	  [s]
  and helper (s:string) (i:int) (n:int) : string list =
    if i >= (n-1) then
      []
    else
      let c = s.[i] in
      let code = Char.code c in
      let quote (cs:char list) : string =
	quote (string_of_charlist cs)
      in
	if c = '\\' then
	  (quote [ '\\' ; s.[i+1] ])::(helper s (i+2) n)
	else if code >= 252 then
	  (quote [s.[i] ; s.[i+1] ; s.[i+2] ; s.[i+3] ; s.[i+4] ; s.[i+5]])::(helper s (i+6) n)
	else if code >= 248 then
	  (quote [s.[i] ; s.[i+1] ; s.[i+2] ; s.[i+3] ; s.[i+4]])::(helper s (i+5) n)
	else if code >= 240 then
	  (quote [s.[i] ; s.[i+1] ; s.[i+2] ; s.[i+3]])::(helper s (i+4) n)
	else if code >= 224 then
	  (quote [s.[i] ; s.[i+1] ; s.[i+2]])::(helper s (i+3) n)
	else if code >= 192 then
	  (quote [s.[i] ; s.[i+1]])::(helper s (i+2) n)
	else 
	  (quote [c])::(helper s (i+1) n)
  in
    explode_quoted s
;;

let strip_quotes (s:string) : string option =
  let len = String.length s in
    if len < 2 then
      None
    else
      if s.[0] = '\'' && s.[len-1] = '\'' then
	Some(String.sub s 1 (len-2))
      else
	None;;

let unquote (s:string) : string =
  match strip_quotes s with
      None -> err "Internal error in unquote"
    | Some(s) -> s
;;

let is_quoted (s:string) : bool =
  match strip_quotes s with
      None -> false
    | _ -> true;;

let rec and_list default l =
  match l with
      [] -> default 
    | x::l' -> 
	if x then
	  and_list default l'
	else
	  false
;;

let rec or_list default l =
  match l with
      [] -> default
    | x::l' -> 
	if x then
	  true
	else
	  or_list default l'
;;

(* we assume s is nonempty *)
let is_capitalized (s:string) : bool = 
  Char.uppercase (s.[0]) = s.[0];;

  (* return a list of all the lists resulting from concatenating
     a list in l1 with a list in l2 *)
let mix (l1:'a list list) (l2:'a list list) : 'a list list =
  List.map (fun (x,y) -> x @ y) (all_pairs l1 l2)
;;

let loop() = 
  print_string_flush "Looping...\n";
  let rec loop() = loop()
  in loop();;

let rec nums cur max =
  if cur > max then
    []
  else
    cur::(nums (cur+1) max);;

let printable_ascii = [9; 10] @ (nums 32 126);;

(* we assume s is three or four characters long; e.g. "'a'" or "'\n'" *)
let map_escaped s =
  if s = "'\\n'" then '\n'
  else if s = "'\\t'" then '\t'
  else if s = "'\\\\'" then '\\'
  else s.[1];;

(* return a list of positions i where f returns true for arr.(i) *)
let filter_array (f:'a -> bool) (arr : 'a array) : int list =
  let iend = (Array.length arr) - 1 in
  let l = ref [] in
    for i = 0 to iend do
      if f arr.(i) then
	l := i::!l
    done;
    !l
;;

let opt_array_domain (arr : 'a option array) : int list =
  filter_array (fun x -> match x with None -> false | _ -> true) arr;;

let bool_array_domain (arr : bool array) : int list =
  filter_array (fun x -> x) arr;;

let list_array_domain (arr : 'a list array) : int list =
  filter_array nonempty arr;;

let rec take (n:int) (l:'a list) : 'a list =
  if n <= 0 then []
  else
    match l with
	[] -> []
      | x::l' -> x::(take (n-1) l');;

let rec take_some (l:'a option list) : 'a list =
  match l with
      [] -> []
    | None::l' -> take_some l'
    | Some(x)::l' -> x::(take_some l')
;;

(* return a pair of 
   1. the longest prefix of l where all elements satisfy p, 
   2. the rest of the list following that prefix *)
let rec matching_prefix (p : 'a -> bool) (l : 'a list) : 'a list * 'a list=
  match l with
      [] -> ([],[])
    | a::l' -> 
	if p a then
	  let (e,s) = matching_prefix p l' in
	    (a::e,s)
	else
	  ([],l)
;;

let rec list_suffixes (l:'a list) : 'a list list =
  match l with
      [] -> [[]]
    | x::l' -> l::(list_suffixes l')
;;

let rec enumerate cur bnd =
  if cur >= bnd then []
  else cur :: (enumerate (cur+1) bnd)
;;

type ('a , 'b) or_t = LeftOr of 'a | RightOr of 'b;;

(* split the given string, but avoid single quotes *)
let split_string (c:char)(s:string) : string list =
  let rec helper (inquotes:bool) (c:char) (cur:char list) (rest:char list) : char list list =
    match rest with
	[] -> [List.rev cur]
      | c'::rest' ->
	  if inquotes then
	      helper (not (c' = '\'')) c (c'::cur) rest'
	  else
	    if c=c' then
	      (List.rev cur)::(helper inquotes c [] rest')
	    else
	      helper (c' = '\'') c (c'::cur) rest'
  in
    List.map string_of_charlist (helper false c [] (charlist_of_string s));;

let uniq (cmp : 'a -> 'a -> int) (l : 'a list) : 'a list = 
  let rec drop_dups (l:'a list) : 'a list =
    match l with
	[] -> []
      | [x] -> [x]
      | x::y::l' -> 
	  let r = drop_dups (y::l') in
	    if (cmp x y = 0) then r else x::r 
  in
  drop_dups (List.sort cmp l);;

let list_pos (x:'a) (l:'a list) : int =
  let rec helper n l =
    match l with
	[] -> -1
      | y::l' -> 
	  if x = y then 
	    n
	  else
	    helper (n+1) l'
  in
    helper 0 l;;

let blanks (num:int) : string = String.make num ' ';;

let string_of_char = String.make 1;;

let rec repeat (x:'a)(n:int) : 'a list =
  if n <= 0 then
    []
  else
    x::(repeat x (n-1))
;;

let rec iterih (f : int -> 'a -> unit)(l: 'a list)(c:int) : unit =
  match l with
      [] -> ()
    | x :: xs -> f c x; iterih f xs (c + 1);;

(* for compatibility with OCaml version < 4.00 *)
let iteri (f : int -> 'a -> unit)(l: 'a list) : unit = iterih f l 0;;
  
let rec stringMaph(f : char -> char)(s:string)(c:int)(len:int) : string = 
  if c >= len then ""
  else (Char.escaped (f s.[c])) ^ (stringMaph f s (c + 1) len);;

(* for compatibility with OCaml version < 4.00 *)
let rec stringMap(f : char -> char)(s:string) : string = stringMaph f s 0 (String.length s);;

(* we want to coalesce elements of type 'a into elements of type 'b.  We assume that all elements which can be coalesced
   occur next to each other in the list.  We assume a function of injecting an element of type 'a to type 'b, and
   then functions for checking if we can coalesce a 'a and a 'b element, and for actually doing the coalescing *)
let rec coalesce_list(inject : 'a -> 'b)(can_coalesce : 'a -> 'b -> bool)(coalesce : 'a -> 'b -> 'b)(l : 'a list) : 'b list =
  match l with
    [] -> []
  | x :: xs -> 
     match coalesce_list inject can_coalesce coalesce xs with
       [] -> inject x :: []
     | y :: ys -> if can_coalesce x y then coalesce x y :: ys else inject x :: y :: ys
;;
