open Util;;
open Term;;

type rule = 
    Rule of 
      (string (* a unique id *)
       * int (* the max var used *))
      * term (* lhs *)
      * term (* rhs *)
type trs = Trs of rule list

(* special multi-arity operator recognized by our internal rewriting *)
let string_append = "string-append";;

let compare_rules (r1:rule) (r2:rule) : int =
  let Rule((id1,_),_,_) = r1 in
  let Rule((id2,_),_,_) = r2 in
    compare id1 id2;;

let print_rule (os:string -> unit) (Rule((id,_),lhs,rhs)) : unit =
  os id;
  os ": ";
  print_term os lhs;
  os " -> ";
  print_term os rhs;
  os "\n";;

let rename_rule (minv:int) (r:rule) : rule =
  let rec rename_term (t:term) : term =
    match t with
	Normal(t') -> Normal(rename_term t')
      | Var(x) -> Var(x+minv)
      | App(f,args) -> App(f,List.map rename_term args) in
  let Rule((id,maxv),lhs,rhs) = r in 
    Rule((id,maxv+minv),rename_term lhs, rename_term rhs);;


let print_trs (os:string -> unit) (Trs(rs)) : unit =
  List.iter (print_rule os) rs;;

let union_trs (Trs(s1)) (Trs(s2)) : trs =
  Trs(s1@s2);;

let has_valid_translations dbg (Trs(s1)) id_prod_trie embedding syn_nts lex_nts : bool = 

  List.for_all
    
    (fun (Rule(id, l, r)) -> is_translation_of l r id_prod_trie embedding syn_nts lex_nts)
    
    s1
    
    


