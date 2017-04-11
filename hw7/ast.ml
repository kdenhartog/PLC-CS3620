open Trie;;

type ast_type = NotInAst | SymOnly | SubAst of int;;
type avar = ast_type * string;;
type avari = ast_type * int;; (* for symnums *)
type tp_ctxt = (string list * string) trie;;

