module OrderedInt =
struct
  type t = int
  let compare (x:int) (y:int) = compare x y
end;;

module IntMap = Map.Make(OrderedInt);;

type 'a intmap = 'a IntMap.t;;

type intset = unit intmap;;

let intmap_empty = IntMap.empty;;
let intmap_insert (m : 'a intmap)(i : int)(x : 'a) : 'a intmap = IntMap.add i x m;;
let intmap_lookup (m : 'a intmap)(i : int) : 'a option =
  try 
    Some (IntMap.find i m)
  with
    _ -> None;;
let intmap_contains(m : 'a intmap)(i : int) : bool = IntMap.mem i m;;

let intmap_cons (m : 'a list intmap)(i : int)(x : 'a) : 'a list intmap =
  match intmap_lookup m i with
    None -> intmap_insert m i [ x ]
  | Some(xs) -> intmap_insert m i (x :: xs);;

let intmap_list_lookup (m : 'a list intmap)(i : int) : 'a list =
  match intmap_lookup m i with
    None -> []
  | Some(l) -> l;;

let intmap_iter(m : 'a intmap)(f : (int -> 'a -> unit)) : unit = IntMap.iter f m;;

let intmap_bindings(m : 'a intmap) : (int * 'a) list = IntMap.bindings m;;

let intset_empty = IntMap.empty;;
let intset_contains = intmap_contains;;
let intset_insert (m : intset)(x : int) = intmap_insert m x ();;
let intset_ints(m : intset) : int list = List.map fst (intmap_bindings m);;
