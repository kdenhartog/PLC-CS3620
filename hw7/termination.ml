(** This moudle provides a termination method for reorganizing TRSs *)

open Format

type simple_term = 
  | V of int
  | F of string * simple_term list

(** List manipulations *)

let concat_map f l = List.concat (List.map f l)

let rec unique = function
  | [] -> []
  | x :: xs -> x :: unique (List.filter (fun y -> x <> y) xs)

let subset xs ys = 
  List.for_all (fun x -> List.mem x ys) xs

let set_equal xs ys = subset xs ys && subset ys xs


(** Strongly connected components *)

let tarjan graph = 
  let l = ref [] in
  let n = Array.length graph in
  let t = ref 0 in
  let visited = Array.make n (-1) in
  let origin  = Array.make n (-1) in 
  let sccs = ref [] in
  let rec pre_topological_order v =
    visited.(v) <- !t;
    origin.(v) <- !t;
    incr t;
    l := v :: !l;
    let f w =
      if visited.(w) < 0 then 
	(pre_topological_order w; origin.(v) <- min origin.(v) origin.(w))
      else if List.mem w !l then
	origin.(v) <- min origin.(v) origin.(w)
    in
    List.iter f (graph.(v));
    if origin.(v) = visited.(v) then
      let rec pop = function
	| [] -> failwith "Termination.tarjan"
	| w :: ws when w = v -> (l := ws; [w])
	| w :: ws -> w :: pop ws in
      sccs := pop !l :: !sccs
  in
  for v = 0 to n - 1 do
    if (visited.(v) < 0) then
      pre_topological_order v
  done;
  !sccs

(* Cyclic SCCs: An SCC S is cyclic if v ->+ v for all v in S. *)
let cyclic_scc graph =
  let cyclic = function
    | [v] -> List.mem v graph.(v)
    | _ -> true in
  List.filter cyclic (tarjan graph)


(** Functions for TRSs *)

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

let rec signature_term = function
  | V _ -> []
  | F (f, ts) -> 
    unique ((f, List.length ts) :: concat_map signature_term ts)

let signature_rule (l, r) =
  unique (signature_term l @ signature_term r)

let signature rules =
  unique (concat_map signature_rule rules)

let rec variables_aux = function
  | V x -> [x]
  | F (f, ts) -> concat_map variables_aux ts

let variables t = unique (variables_aux t)

let rec functions = function
  | V x -> []
  | F (f, ts) -> f :: concat_map functions ts

let rec linear_aux xs = function
  | [] -> true
  | V x :: ts -> not (List.mem x xs) && linear_aux (x :: xs) ts
  | F (f, ss) :: ts -> linear_aux xs (ss @ ts)

let linear t = linear_aux [] [t]

let rec subterms = function
  | V _ as t -> [t]
  | F (_, ts) as t -> t :: concat_map subterms (unique ts)

let proper_subterms t = List.filter (fun s -> s <> t) (subterms t)

(** Substitutions *)

let apply subst x = try List.assoc x subst with Not_found -> V x

let rec substitute subst = function
  | V x -> apply subst x
  | F (f, ts) -> F (f, List.map (substitute subst) ts)

exception Not_unifiable


let bind x t subst =
  let rec loop = function
    | [] -> []
    | (y, term) :: subst'  when x <> y -> (y, substitute [x, t] term) :: loop subst'
    | _ :: subst' -> loop subst' in
  if V x = t then subst else
    (x, t) :: loop subst

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


(** Dependency pairs. *)

let mark = function
  | V _ -> invalid_arg "Termination.mark" 
  | F (f, ts) -> F (f ^ "#", ts)

let root = function
  | V _ -> invalid_arg "Termination.defined_symbols"
  | F (f, _) -> f 

let defined_symbols rs =
  unique (List.map (fun (l, r) -> root l) rs)

(* DP(R) = { l# -> r# | l -> r in R, r |>= t, root(t) is defined symbol
                        not (t in V), and not (l |> t) } *)

let dp1 ds (l, r) = 
  let ss = proper_subterms l in
  let p = function
    | V _ -> false
    | F (f, _) as t -> List.mem f ds && not (List.mem t ss) in
  List.map
    (fun s -> (mark l, mark s))
    (List.filter p (subterms r))

let dp rules = 
  concat_map (dp1 (defined_symbols rules)) rules

(* DP(R) for reorganizing TRSs *)

let rdp rules = 
  let ds = defined_symbols rules in
  List.map
    (fun (s, t) -> (mark s, mark t))
    (List.filter (fun (_, r) -> List.mem (root r) ds) rules)

(** Cycle Anlysis  *)

(* Connectability of edges *)

let count = ref 0
let fresh () = incr count; !count

let rec ren = function
  | V _ -> V (fresh ())
  | F (f, ts) -> F (f, List.map ren ts)

let rec cap ds = function
  | V _ -> V (fresh ())
  | F (f, _) when List.mem f ds -> V (fresh ())
  | F (f, ts) -> F (f, List.map (cap ds) ts)

let connectable ds t u = unifiable (cap ds t) (ren u)

(* DG(P) *)

let dependency_graph ds idps = 
  let n = Array.length idps in
  let succ i (s, t) = 
    let l = ref [] in
    for j = 0 to n - 1 do
      let u, _ = idps.(j) in
      if connectable ds t u then l := j :: !l
    done;
    !l in
  Array.mapi succ idps

let dp_scc ds ps =
  let a = Array.of_list ps in
  let f scc = List.map (fun i -> a.(i)) scc in
  List.map f (cyclic_scc (dependency_graph ds a))

(** Subterm Criterion *)

type order = Gt | Geq

exception Failed

let project a = function
  | V _ -> failwith "Termination.project"
  | F (f, ts) -> List.nth ts (List.assoc f a)

let order pi (s, t) = 
  let s2 = project pi s
  and t2 = project pi t in
  if List.mem t2 (subterms s2) then
    if s2 <> t2 then Gt else Geq
  else 
    raise Failed

let rec try_find f = function 
  | [] -> raise Failed
  | x :: xs -> try f x with Failed -> try_find f xs

let rec find ?(pi = []) ps = function
  | [] -> 
      if List.mem Gt (List.map (order pi) ps) then 
	pi
      else 
	raise Failed
  | (f, ns) :: a ->
      try_find (fun i -> find ~pi:((f, i) :: pi) ps a) ns

let rec range ?(i = 0) n = 
  if i < n then i :: range ~i:(i + 1) n else []

let subterm_criterion ps =
  try
    let pi = find ps (List.map (fun (f, n) -> (f, range n)) (signature ps)) in
    (true, List.filter (fun (s, t) -> order pi (s, t) = Geq) ps)
  with
    Failed -> (false, ps)

(** The Recursive SCC Algorithm *)

let rec recursive_scc ds = function 
  | [] -> true
  | [] :: sccs -> recursive_scc ds sccs
  | ps :: sccs -> 
      let b, ps2 = subterm_criterion ps in
      b && recursive_scc ds (dp_scc ds ps2 @ sccs)

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

let reorganizing_rule (s, t) =
  linear s && linear t &&
  set_equal (variables s) (variables t) &&
  set_equal (functions s) (functions t)

let reorganizing rules = List.for_all reorganizing_rule rules

(* Main *)

let terminating (Trs trs) =
  let rules = simple_rules trs in
  let dps = if reorganizing rules then rdp rules else dp rules in
  let ds  = defined_symbols rules in
  recursive_scc ds (dp_scc ds dps)
