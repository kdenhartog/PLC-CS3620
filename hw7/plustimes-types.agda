----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module plustimes-types where

open import lib
open import parse-tree

posinfo = string
anyDigs = string
anyDigs-range-5 = string
anyDigs-star-6 = string
id = string
id-plus-12 = string
id-range-11 = string
num = string
num-opt-10 = string
numFirstPart = string
numFirstPart-bar-8 = string
numSecondPart = string
numSecondPart-bar-9 = string
posDig = string
posDig-range-7 = string

mutual

  data expr : Set where 
    Id : id → expr
    Num : num → expr
    Parens : expr → expr
    Plus : expr → expr → expr
    Times : expr → expr → expr

  data strt : Set where 
    Strt : expr → strt

-- embedded types:

data ParseTreeT : Set where
  parsed-expr : expr → ParseTreeT
  parsed-strt : strt → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-anyDigs : anyDigs → ParseTreeT
  parsed-anyDigs-range-5 : anyDigs-range-5 → ParseTreeT
  parsed-anyDigs-star-6 : anyDigs-star-6 → ParseTreeT
  parsed-id : id → ParseTreeT
  parsed-id-plus-12 : id-plus-12 → ParseTreeT
  parsed-id-range-11 : id-range-11 → ParseTreeT
  parsed-num : num → ParseTreeT
  parsed-num-opt-10 : num-opt-10 → ParseTreeT
  parsed-numFirstPart : numFirstPart → ParseTreeT
  parsed-numFirstPart-bar-8 : numFirstPart-bar-8 → ParseTreeT
  parsed-numSecondPart : numSecondPart → ParseTreeT
  parsed-numSecondPart-bar-9 : numSecondPart-bar-9 → ParseTreeT
  parsed-posDig : posDig → ParseTreeT
  parsed-posDig-range-7 : posDig-range-7 → ParseTreeT
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
anyDigsToString : anyDigs → string
anyDigsToString x = "(anyDigs " ^ x ^ ")"
anyDigs-range-5ToString : anyDigs-range-5 → string
anyDigs-range-5ToString x = "(anyDigs-range-5 " ^ x ^ ")"
anyDigs-star-6ToString : anyDigs-star-6 → string
anyDigs-star-6ToString x = "(anyDigs-star-6 " ^ x ^ ")"
idToString : id → string
idToString x = "(id " ^ x ^ ")"
id-plus-12ToString : id-plus-12 → string
id-plus-12ToString x = "(id-plus-12 " ^ x ^ ")"
id-range-11ToString : id-range-11 → string
id-range-11ToString x = "(id-range-11 " ^ x ^ ")"
numToString : num → string
numToString x = "(num " ^ x ^ ")"
num-opt-10ToString : num-opt-10 → string
num-opt-10ToString x = "(num-opt-10 " ^ x ^ ")"
numFirstPartToString : numFirstPart → string
numFirstPartToString x = "(numFirstPart " ^ x ^ ")"
numFirstPart-bar-8ToString : numFirstPart-bar-8 → string
numFirstPart-bar-8ToString x = "(numFirstPart-bar-8 " ^ x ^ ")"
numSecondPartToString : numSecondPart → string
numSecondPartToString x = "(numSecondPart " ^ x ^ ")"
numSecondPart-bar-9ToString : numSecondPart-bar-9 → string
numSecondPart-bar-9ToString x = "(numSecondPart-bar-9 " ^ x ^ ")"
posDigToString : posDig → string
posDigToString x = "(posDig " ^ x ^ ")"
posDig-range-7ToString : posDig-range-7 → string
posDig-range-7ToString x = "(posDig-range-7 " ^ x ^ ")"

mutual
  exprToString : expr → string
  exprToString (Id x0) = "(Id" ^ " " ^ (idToString x0) ^ ")"
  exprToString (Num x0) = "(Num" ^ " " ^ (numToString x0) ^ ")"
  exprToString (Parens x0) = "(Parens" ^ " " ^ (exprToString x0) ^ ")"
  exprToString (Plus x0 x1) = "(Plus" ^ " " ^ (exprToString x0) ^ " " ^ (exprToString x1) ^ ")"
  exprToString (Times x0 x1) = "(Times" ^ " " ^ (exprToString x0) ^ " " ^ (exprToString x1) ^ ")"

  strtToString : strt → string
  strtToString (Strt x0) = "(Strt" ^ " " ^ (exprToString x0) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-expr t) = exprToString t
ParseTreeToString (parsed-strt t) = strtToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-anyDigs t) = anyDigsToString t
ParseTreeToString (parsed-anyDigs-range-5 t) = anyDigs-range-5ToString t
ParseTreeToString (parsed-anyDigs-star-6 t) = anyDigs-star-6ToString t
ParseTreeToString (parsed-id t) = idToString t
ParseTreeToString (parsed-id-plus-12 t) = id-plus-12ToString t
ParseTreeToString (parsed-id-range-11 t) = id-range-11ToString t
ParseTreeToString (parsed-num t) = numToString t
ParseTreeToString (parsed-num-opt-10 t) = num-opt-10ToString t
ParseTreeToString (parsed-numFirstPart t) = numFirstPartToString t
ParseTreeToString (parsed-numFirstPart-bar-8 t) = numFirstPart-bar-8ToString t
ParseTreeToString (parsed-numSecondPart t) = numSecondPartToString t
ParseTreeToString (parsed-numSecondPart-bar-9 t) = numSecondPart-bar-9ToString t
ParseTreeToString (parsed-posDig t) = posDigToString t
ParseTreeToString (parsed-posDig-range-7 t) = posDig-range-7ToString t
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
  norm-expr : (x : expr) → expr
  norm-expr (Times x1 (Plus x2 x3)) = (norm-expr (Plus  (norm-expr (Times  x1 x2) ) x3) )
  norm-expr (Times (Plus x1 x2) x3) = (norm-expr (Plus  x1 (norm-expr (Times  x2 x3) )) )
  norm-expr (Times (Times x1 x2) x3) = (norm-expr (Times  x1 (norm-expr (Times  x2 x3) )) )
  norm-expr (Plus (Plus x1 x2) x3) = (norm-expr (Plus  x1 (norm-expr (Plus  x2 x3) )) )
  norm-expr x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

