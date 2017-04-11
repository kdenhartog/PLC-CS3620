open Util;;

(* union find *)

(* we represent a union-find data structure on a set of ints as an
   array a, where a.(i) = (j,r) means that node i points to node j in
   the union-find data structure, and the list r of reasons (of some
   arbitrary type 'a) explains why. *)
type 'a equiv_t = (int * ('a list)) array;;

(* make a new union-find data structure for representing an
   equivalence on the ints {0,...,size-1}. *)
let mk_equiv(size:int) : 'a equiv_t = Array.init size (fun x -> (x,[]));;

let rec find(a:'a equiv_t)(i:int) : int * ('a list) =
  let x = a.(i) in
  let (pi,r) = x in
    if i = pi then
      x
    else
      (* perform path compression, appending the reasons *)
      let (pi',r') = find a pi in
      let n = (pi', r @ r') in
	a.(i) <- n;
	n;;

let findr(a : 'a equiv_t)(i : int) : int = let (j,_) = find a i in j;;

let uniquify_reasons(a:'a equiv_t)(cmp:'a -> 'a -> int) : unit =
  let maxi = (Array.length a) - 1 in
    for i = 0 to maxi do
      let (pi,ri) = a.(i) in
	a.(i) <- (pi, uniq cmp ri)
    done;;

(* We enforce that representatives (returned by find) will always be
   the smallest number in the equiv class. 

   Return true iff i and j were not already equal.
*)
let union(a:'a equiv_t)(i:int)(j:int)(r:'a list) : bool =
  let (pi,ri) = find a i in
  let (pj,rj) = find a j in
    if pi = pj then
      false
    else
      (if pj < pi then
	 a.(pi) <- (pj,r @ ri @ rj)
       else
	 a.(pj) <- (pi,r @ ri @ rj);
       true)
;;

(* if i and j are equal according to a, return a list of the reasons why.
   Otherwise return None *)
let are_equiv(a:'a equiv_t)(i:int)(j:int) : 'a list option =
  let (pi,ri) = find a i in
  let (pj,rj) = find a j in
    if pi = pj then
      Some(ri @ rj)
    else
      None;;

(* if showtriv is true, we will print bindings when i is mapped by e to i; otherwise, we won't. *)
let print_equiv(a:'a equiv_t)(showtriv:bool)(os:string -> unit)(showint:int -> string)(showreason:'a -> string) : unit =
  let maxi = (Array.length a) - 1 in
    os "(\n";
    for i = 0 to maxi do
      let (v,r) = a.(i) in
	if showtriv || i <> v then
	  (os " ";
	   os (showint i);
	   os " -> ";
	   os (showint v);
	   if nonempty r then
	     (os " by ";
	      print_strings os ", " (List.map showreason r));
	   os "\n");
    done;
    os ")\n";;
