open Util;;

(* nonempty trees *)
type 'a tree = Node of 'a * 'a tree list ;;

let rec tree_print (os : string -> unit)(os_data : 'a -> unit)(node_str : string)(cons_str : string)(nil_str:string)(parens : bool)
    (t : 'a tree) : unit =
  match t with
      Node(x,ts) ->
	os "(";
	os node_str;
	os_data x;
	if parens && nonempty ts then
	  os " (";
	List.iter
	  (fun t ->
	     tree_print os os_data node_str cons_str nil_str parens t;
	      os cons_str)
	  ts;
	os nil_str;
	if parens && nonempty ts then
	  os ")";
	os ")"
;;
	       
let rec collect_leaves (t : 'a tree) : 'a list =
  match t with
      Node(x,[]) -> [x]
    | Node(x,xs) -> uniq compare (List.concat (List.map collect_leaves xs))
;;

let rec collect_paths (t : 'a tree) : 'a list list =
  match t with
      Node(x,[]) -> [[x]]
    | Node(x,xs) -> 
	List.map (fun p -> x::p)
	  (List.concat (List.map collect_paths xs))
;;
