(** A module for derivational complexity analysis. *)

open Num
open Format

(** Lists *)

let rec index ?(i = 0) = function
  | [] -> []
  | x :: xs -> (i, x) :: index ~i:(i + 1) xs

let rec power = function
  | [] -> [ [] ]
  | x :: xs ->
      let yss = power xs in 
      yss @ List.map (fun ys -> x :: ys) yss

let sum l = List.fold_left (+) 0 l

let concat_map f l = List.concat (List.map f l)

let rec map_filter f p = function
  | [] -> []
  | x :: xs when p x -> f x :: map_filter f p xs
  | _ :: xs          -> map_filter f p xs

let rec unique = function
  | [] -> []
  | x :: xs -> x :: unique (List.filter (fun y -> x <> y) xs)

let subset xs ys = List.for_all (fun x -> List.mem x ys) xs

let diff xs ys = List.filter (fun x -> not (List.mem x ys)) xs

let big_union xss = unique (List.concat xss)

let reverse xs = List.map (fun (x, y) -> (y, x)) xs


(** The Simplex Method *)

type matrix = { b : int array; nb : int array; a : num array array }

(* Solve an equation v with respect to column i. *)
let solve_vector v i =
  let x = v.(i) in
  for j = 0 to Array.length v - 1 do
    v.(j) <- (if j = i then Int 1 else minus_num v.(j)) // x
  done

let substitute u i v =
  let x = u.(i) in
  for j = 0 to Array.length u - 1 do
    u.(j) <- (if j = i then Int 0 else u.(j)) +/ x */ v.(j)
  done

let pivot d r s =
  solve_vector d.a.(r) s;
  for i = 0 to Array.length d.a - 1 do 
    if i <> r then substitute d.a.(i) s d.a.(r)
  done;
  let tmp = d.b.(r) in 
  d.b.(r)  <- d.nb.(s);
  d.nb.(s) <- tmp

let find_s d =
  let c = d.a.(Array.length d.a - 1) in
  let l = ref [] in
  for i = 1 to Array.length c - 1 do
    if c.(i) >/ Int 0 then l := i :: !l
  done;
  match !l with
  | [] -> raise Not_found
  | i :: is -> 
      let f i1 i2 = if d.nb.(i1) < d.nb.(i2) then i1 else i2 in
      List.fold_left f i is

let find_r d s = 
  let f i = d.a.(i).(0) // d.a.(i).(s) in
  let l = ref [] in
  for i = 0 to Array.length d.a - 2 do 
    if d.a.(i).(s) </ Int 0 then l := (i, f i) :: !l 
  done;
  match !l with
  | [] -> raise Not_found
  | z :: zs ->
      let f (i, x) (j, y) = 
	if x >/ y || (x =/ y && d.b.(i) <= d.b.(j)) then (i, x) else (j, y) in
      fst (List.fold_left f z zs)

let find_r_for_a d = 
  let l = ref [] in
  for i = 0 to Array.length d.a - 2 do 
    l := (i, d.a.(i).(0)) :: !l 
  done;
  match !l with
  | [] -> raise Not_found
  | z :: zs ->
      let f (i, x) (j, y) = 
	if x </ y || (x =/ y && d.b.(i) <= d.b.(j)) then (i, x) else (j, y) in
      fst (List.fold_left f z zs)

let simplex d =
  try
    while true do
      let s = find_s d in
      let r = find_r d s in
      pivot d r s;
    done
  with
    Not_found -> ()

let make_row a i =
  let m = Array.length a.(i) in
  let f = function 
    | 0 -> minus_num a.(i).(m - 1)
    | 1 -> Int 1 
    | j -> a.(i).(j - 2) in
  Array.init (m + 2) f

let unit n i x =
  Array.init n (fun ii -> if i = ii then x else Int 0)

let make_aux a = 
  let n = Array.length a in
  let f i = 
    if i = n then unit (Array.length a.(0) + 1) 1 (Int ~-1) else make_row a i in
  Array.init (n + 1) f

let is_feasible a =
  List.for_all
    (fun v -> v.(Array.length v - 1) <=/ Int 0)
    (Array.to_list a)

let rec range ?(i=0) n = 
  if i < n then i :: range ~i:(i + 1) n else []
  

(* [A|b]x >= 0 *)
let feasible_solution a = 
  let m = Array.length a and n = Array.length a.(0) in
  let d = { a = a;
	    nb = Array.init n (fun i -> i - 2);
	    b  = Array.init m (fun i -> n + i - 2) } in
  pivot d (find_r_for_a d) 1;
  simplex d;
  if List.mem ~-1 (Array.to_list d.b) then 
    None
  else 
    let pairs =
      List.map (fun i -> (d.nb.(i), Int 0))    (range (Array.length d.nb)) @
      List.map (fun i -> (d.b.(i), a.(i).(0))) (range (Array.length d.b - 1)) in
    Some (Array.init (Array.length a.(0) - 2) (fun i -> List.assoc i pairs))


let principal_solution_aux a =
  let n = ref 0 in
  Array.iter (fun v -> n := max !n (Array.length v)) a;
  let aa = 
    Array.make_matrix (Array.length a + 1) (!n + 2) (Int 0) in
  let vv = Array.make !n (Int 0) in
  for k = 0 to Array.length a - 1 do
    for i = 0 to Array.length aa - 2 do
      aa.(i).(0) <- (if i = k then Int ~-1 else Int 0);
      aa.(i).(1) <- Int 1;
      for j = 2 to Array.length aa.(i) - 1 do
	aa.(i).(j) <- a.(i).(j - 2)
      done
    done;
    aa.(Array.length aa - 1).(0) <- Int 0;
    aa.(Array.length aa - 1).(1) <- Int ~-1;
    for j = 2 to Array.length aa.(Array.length aa - 1) - 1 do
      aa.(Array.length aa - 1).(j) <- Int 0
    done;
    match feasible_solution aa with
    | None -> ()
    | Some v -> Array.iteri (fun i x -> vv.(i) <- x +/ v.(i)) vv;
  done;
  for i = 0 to Array.length vv - 1 do
    let k = 
      num_of_big_int (Ratio.denominator_ratio (ratio_of_num vv.(i))) in
    for j = 0 to Array.length vv - 1 do
      vv.(j) <- vv.(j) */ k
    done
  done;
  vv

let incr_vector v i = v.(i) <- v.(i) +/ num_of_int 1

let decr_vector v i = v.(i) <- v.(i) -/ num_of_int 1

let vector a (ls, rs) = 
  let v = Array.make (List.length a) (Num.num_of_int 0) in
  let f xs = List.map (fun x -> List.assoc x a) xs in
  List.iter (incr_vector v) (f ls);
  List.iter (decr_vector v) (f rs);
  v

let principal_solution cs =
  let a = reverse (index (unique (concat_map (fun (l, r) -> l @ r) cs))) in
  let v = principal_solution_aux (Array.of_list (List.map (vector a) cs)) in
  List.map (fun (x, i) -> (x, int_of_num v.(i))) a


(** Terms *)

type simple_term = 
  | V of int
  | F of string * simple_term list

let print pr sep ppf = function
  | [] -> ()
  | x :: xs ->
      pr ppf x;
      List.iter (Format.fprintf ppf (sep ^^ "%a") pr) xs 

let rec print_term ppf = function
  | V x -> fprintf ppf "x%d" x
  | F (f, ts) -> fprintf ppf "%s(%a)" f (print print_term ",") ts

let print_rule ppf (l, r) = 
  fprintf ppf "%a -> %a" print_term l print_term r

let print_rules ppf rules = 
  List.iter (fun rule -> fprintf ppf "%a@." print_rule rule) rules


let rec variables_aux = function
  | V x -> [x]
  | F (f, ts) -> concat_map variables_aux ts

(* Var(t) *)
let variables t = unique (variables_aux t)

let rec linear_aux xs = function
  | [] -> true
  | V x :: ts -> not (List.mem x xs) && linear_aux (x :: xs) ts
  | F (f, ss) :: ts -> linear_aux xs (ss @ ts)

let linear t = linear_aux [] [t]

let rec subterms = function
  | V _ as t -> [t]
  | F (_, ts) as t -> t :: concat_map subterms (unique ts)

let proper_subterms t = List.filter (fun s -> s <> t) (subterms t)

(* |t|_x *)
let rec count_variables x = function
  | V y when x = y -> 1 
  | V _       -> 0
  | F (f, ts) -> sum (List.map (count_variables x) ts)

(* |t| *)
let rec size = function
  | V _       -> 1
  | F (_, ts) -> 1 + sum (List.map size ts)

(* Pos_F(t) *)
let rec function_positions = function
  | V x -> []
  | F (_, ts) ->
      let conss i ps = List.map (fun p -> i :: p) ps in
      [] :: concat_map 
              (fun (i, ti) -> conss i (function_positions ti))
              (index ts)

(* t|_p *)
let rec subterm_at p t =
  match p, t with
  | [], _ -> t
  | i :: q, F (_, ts) -> subterm_at q (List.nth ts i)
  | _ -> invalid_arg "subterm_at"

(* s[t]_p *)
let rec replace s t p =
  match s, p with
  | _, [] -> t
  | F (f, ss), i :: q ->
      (* F (f, [ if i = j then replace sj t q else sj | j, sj <- index ss ]) *)
      let g (j, sj) = if i = j then replace sj t q else sj in
      F (f, List.map g (index ss))
  | _ -> invalid_arg "replace"


(** Substitutions *)

type subst = (int * simple_term) list

let apply subst x = try List.assoc x subst with Not_found -> V x

(* t\sigma *)
let rec substitute subst = function
  | V x -> apply subst x
  | F (f, ts) -> F (f, List.map (substitute subst) ts)


(** Pattern matching *)

exception Not_matched

let rec pattern_match' subst = function 
  | [] -> subst
  | (V x as l, t) :: list 
    when List.mem_assoc x subst && substitute subst l = t -> 
      pattern_match' subst list 
  | (V x, t) :: list when not (List.mem_assoc x subst) -> 
      pattern_match' ((x, t) :: subst) list
  | (F (f, ss), F (g, ts)) :: list when f = g ->
      pattern_match' subst ((List.combine ss ts) @ list)
  | _ -> raise Not_matched

let pattern_match t1 t2 =
  let m = pattern_match' [] [t1, t2] in 
  assert (substitute m t1 = t2); m

let is_instance_of t1 t2 =
  try ignore (pattern_match t2 t1); true with Not_matched -> false


(** Unification *)

let bind x t subst =
  let rec loop = function
    | [] -> []
    | (y, term) :: subst'  when x <> y -> (y, substitute [x, t] term) :: loop subst'
    | _ :: subst' -> loop subst' in
  if V x = t then subst else
    (x, t) :: loop subst

exception Not_unifiable

let rec unify_aux subst = function
  | [] -> subst
  | (s, t) :: eqs when s = t -> unify_aux subst eqs
  | (V x, t) :: eqs 
  | (t, V x) :: eqs when not (List.mem x (variables t)) ->
      let f (l, r) = (substitute [x, t] l, substitute [x, t] r) in
      unify_aux (bind x t subst) (List.map f eqs)
  | (F (f, ss), F (g, ts)) :: eqs when f = g ->
      unify_aux subst ((List.combine ss ts) @ eqs)
  | _ -> raise Not_unifiable

let unifiable s t = 
  try ignore (unify_aux [] [(s, t)]); true
  with Not_unifiable -> false 

let mgu s t = unify_aux [] [s, t]


(** TRSs *)

type rule = simple_term * simple_term
type rules = rule list

let left_linear rules = List.for_all (fun (l, r) -> linear l) rules

let non_erasing_rule (l, r) = subset (variables l) (variables r)

let non_erasing rules = List.for_all non_erasing_rule rules

let non_duplicating_rule (l, r) =
  List.for_all (fun x -> count_variables x l >= count_variables x r) (variables l)

let length_reducing_rule (l, r) =
  size l >= size r && non_duplicating_rule (l, r)
  
let length_reducing rs =
  List.for_all length_reducing_rule rs


(** Critical pairs *)

let count = ref 0

let fresh () = incr count; !count

let rename_term t =
  let subst = List.map (fun x -> (x, V (fresh ()))) (variables t) in
  substitute subst t

let rename_rule (l, r) =
  let subst = List.map (fun x -> (x, V (fresh ()))) (variables l) in
  (substitute subst l, substitute subst r)

let variant (l1, r1) (l2, r2) =
  let lr1 = F ("->", [l1; r1]) 
  and lr2 = F ("->", [l2; r2]) in
  is_instance_of lr1 lr2 &&
  is_instance_of lr2 lr1

let cp1 rule1 rule2 =
  let l1, r1 = rename_rule rule1 in
  let l2, r2 = rename_rule rule2 in
  let f p = 
    let mu = mgu l1 (subterm_at p l2) in
    (substitute mu (replace l2 r1 p), substitute mu r2) in
  let g p = 
    unifiable (subterm_at p l2) l1 && 
    (p <> [] || not (variant (l1, r1) (l2, r2))) in
  map_filter f g (function_positions l2)

let cp rules1 rules2 = 
  unique (concat_map (fun rule1 -> concat_map (cp1 rule1) rules2) rules1)

let mutual_cp rules1 rules2 =
  cp rules1 rules2 @ (reverse (cp rules2 rules1))

let forward_cp rules1 rules2 = 
  mutual_cp (reverse rules1) rules2


(** Rewriting *)

let root_step rules s = 
  let f (l, r) = substitute (pattern_match l s) r in
  let p (l, r) = is_instance_of s l in
  unique (map_filter f p rules)

let rewrite rules s =
  let f p = 
    List.map (fun t -> replace s t p) (root_step rules (subterm_at p s)) in
  big_union (List.map f (function_positions s))

let rec reachable rules ss u =
  ss <> [] &&
  (List.mem u ss || 
   reachable rules (unique (concat_map (rewrite rules) ss)) u)


(** Separation *)

let separable n rules rules1 rules2 =
  let p (s, t) =
    reachable rules (concat_map (rewrite rules) (rewrite rules2 s)) t in
  rules1 <> [] &&
  rules2 <> [] && 
  List.for_all p (forward_cp rules1 rules2)

let rec separate_aux n rules = function
  | [] -> None
  | rules1 :: l ->
      let rules2 = diff rules rules1 in
      if separable n rules rules1 rules2 then
	Some (rules1, rules2)
      else
	separate_aux n rules l

let separate n rules = 
  separate_aux n rules (power rules)

(** Context-dependent interpretations *)

type monomial = One | Var of int

let rec eval w ?(n = 0) = function
  | V _ -> 0
  | F (f, ts) -> 
      let g (i, t) = eval w ~n:(n + List.assoc (f, i) w) t in
      n + sum (List.map g (index ts))

let gt w (l, r) = eval w l > eval w r
  
let rec weight ?(l = []) = function
  | V x -> [(Var x, l)]
  | F (f, ts) ->
     let g (i, t) = weight ~l:((f, i) :: l) t in
     (One, l) :: concat_map g (index ts)

let constr l x = 
   (* [ m | y, ms <- l; x = y; m <- ms ] *)
   concat_map snd (List.filter (fun (y, ms) -> x = y) l)

let f (s, t) =
  let ws = weight s
  and wt = weight t in
  List.map
    (fun b -> (constr ws b, constr wt b)) 
    (One :: List.map (fun x -> Var x) (variables s ))

let quadratic rules =
  let w = principal_solution (concat_map f rules) in
  List.partition (gt w) rules

  
(* main function *)

let add_option x y =
  match x, y with
  | None, _ -> None
  | _, None -> None
  | Some m, Some n -> Some (m + n)

let max_option x y =
  match x, y with
  | None, _ -> None
  | _, None -> None
  | Some m, Some n -> Some (max m n)

let rec dc_aux rules = 
  if rules = [] then
    Some 0
  else
    match separate 5 rules with
    | Some (rules1, rules2) -> max_option (dc_aux rules1) (dc_aux rules2)
    | None ->	
	match quadratic rules with
	| [], _ -> None
	| strict, weak -> add_option (dc_aux weak) (Some 2) 


(* Conversion *)

open Term
open Trs
open Grammar

let rec simple_term = function
  | Var i -> V i
  | App (f, ts) -> F (f, List.map simple_term ts)
  | Normal t -> simple_term t

let simple_rule (Rule (_, l, r)) = 
  (simple_term l, simple_term r)

let simple_rules rules = 
  unique (List.map simple_rule rules)

let dc (Trs trs) = 
  let rules = simple_rules trs in
  if length_reducing rules && left_linear rules && non_erasing rules then
    dc_aux rules
  else
    None
