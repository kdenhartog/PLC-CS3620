open Util;;
open Grammar;;
open Trs;;
open Trie;;
open Term;;
open Ast;;


let empty_string_target = "empty-string" 

type lhs_elt = SymElt of avar | Id of string;;

type rewrite_rule = string * (lhs_elt list) * string * (term option);; 

type rrs = rewrite_rule list;;

(* convert the parsing_trs to a parse-tree building TRS, using the dot
   symbol to separate partially parsed substrings *)
let to_trs (rs : rrs) : trs = 

  (* convert the given lhs to a term, and return the max var used *)
  let lhs_to_term lhs : term * int =
    let lastvar = ref 0 in 
    let rec lhs_to_term lhs : term =
      match lhs with
	[] -> 
	var (1 + !lastvar)
      | SymElt(NotInAst,s)::l | SymElt(SymOnly,s)::l ->
				 (dot (const s) (lhs_to_term l))
      | Id(s)::l ->
	 (dot (const s) (lhs_to_term l))
      | SymElt(SubAst(i),s)::l ->
	 lastvar := i;
	 (dot (app1 s (var i)) (lhs_to_term l))
    in
    let t = lhs_to_term lhs in
    (t,!lastvar)
  in

  Trs(List.map
	(fun (id,lhs,rhs,ot) ->
	 let (tlhs,v) = lhs_to_term lhs in
	 let endv = v+1 in
	 let place_nt nt nextt =
	   match ot with
	     None -> (dot (const nt) nextt)
	   | Some(t) -> (dot (app1 nt t) nextt)
	 in
	 let trhs = place_nt rhs (var endv) in
	 Rule((id,endv),tlhs,trhs))
	rs)
;;
