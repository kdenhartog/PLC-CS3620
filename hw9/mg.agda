module mg where

open import lib
open import memgraph-types

graph-t : Set
graph-t = 𝕃trie id

data mg : Set where
  mkmg : 𝕃 id {- roots -} →
         stringset {- marked nodes -} →
         𝕃 id {- next nodes to explore -} →
         graph-t {- map nodes to the lists of their successor nodes in the graph -} →
         mg

mg-to-string-simple : mg → string
mg-to-string-simple (mkmg roots marked next graph) =
  "MARKED: " ^ string-concat-sep " " (stringset-strings marked) ^ next-if next ^ "\n"
  where next-if : 𝕃 id → string
        next-if [] = ""
        next-if (n :: _) = ", NEXT: " ^ n

mg-to-string : 𝔹 →  mg → string
mg-to-string hide-garbage = mg-to-string-simple 

