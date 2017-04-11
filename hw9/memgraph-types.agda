----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module memgraph-types where

open import lib
open import parse-tree

posinfo = string
id = string
id-plus-6 = string
id-range-5 = string

mutual

  data idlist : Set where 
    LastIdList : ids → idlist
    NextIdList : ids → idlist → idlist

  data ids : Set where 
    edge : id → idlist → ids
    node : id → ids

  data strt : Set where 
    Strt : idlist → idlist → strt

-- embedded types:

data ParseTreeT : Set where
  parsed-idlist : idlist → ParseTreeT
  parsed-ids : ids → ParseTreeT
  parsed-strt : strt → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-id : id → ParseTreeT
  parsed-id-plus-6 : id-plus-6 → ParseTreeT
  parsed-id-range-5 : id-range-5 → ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-1 : ParseTreeT
  parsed-aws-bar-2 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-4 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-3 : ParseTreeT

------------------------------------------
-- Parse tree printing functions
------------------------------------------

posinfoToString : posinfo → string
posinfoToString x = "(posinfo " ^ x ^ ")"
idToString : id → string
idToString x = "(id " ^ x ^ ")"
id-plus-6ToString : id-plus-6 → string
id-plus-6ToString x = "(id-plus-6 " ^ x ^ ")"
id-range-5ToString : id-range-5 → string
id-range-5ToString x = "(id-range-5 " ^ x ^ ")"

mutual
  idlistToString : idlist → string
  idlistToString (LastIdList x0) = "(LastIdList" ^ " " ^ (idsToString x0) ^ ")"
  idlistToString (NextIdList x0 x1) = "(NextIdList" ^ " " ^ (idsToString x0) ^ " " ^ (idlistToString x1) ^ ")"

  idsToString : ids → string
  idsToString (edge x0 x1) = "(edge" ^ " " ^ (idToString x0) ^ " " ^ (idlistToString x1) ^ ")"
  idsToString (node x0) = "(node" ^ " " ^ (idToString x0) ^ ")"

  strtToString : strt → string
  strtToString (Strt x0 x1) = "(Strt" ^ " " ^ (idlistToString x0) ^ " " ^ (idlistToString x1) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-idlist t) = idlistToString t
ParseTreeToString (parsed-ids t) = idsToString t
ParseTreeToString (parsed-strt t) = strtToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-id t) = idToString t
ParseTreeToString (parsed-id-plus-6 t) = id-plus-6ToString t
ParseTreeToString (parsed-id-range-5 t) = id-range-5ToString t
ParseTreeToString parsed-aws = "[aws]"
ParseTreeToString parsed-aws-bar-1 = "[aws-bar-1]"
ParseTreeToString parsed-aws-bar-2 = "[aws-bar-2]"
ParseTreeToString parsed-ows = "[ows]"
ParseTreeToString parsed-ows-star-4 = "[ows-star-4]"
ParseTreeToString parsed-ws = "[ws]"
ParseTreeToString parsed-ws-plus-3 = "[ws-plus-3]"

------------------------------------------
-- Reorganizing rules
------------------------------------------

mutual

  {-# TERMINATING #-}
  norm-strt : (x : strt) → strt
  norm-strt x = x

  {-# TERMINATING #-}
  norm-posinfo : (x : posinfo) → posinfo
  norm-posinfo x = x

  {-# TERMINATING #-}
  norm-ids : (x : ids) → ids
  norm-ids x = x

  {-# TERMINATING #-}
  norm-idlist : (x : idlist) → idlist
  norm-idlist x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

