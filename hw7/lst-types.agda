----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module lst-types where

open import lib
open import parse-tree

posinfo = string
var = string
var-plus-2 = string
var-range-1 = string

mutual

  data expr : Set where 
    App : expr → expr → expr
    Cons : expr → expr → expr
    Nil : expr
    Parens : expr → expr
    Var : var → expr

  data strt : Set where 
    Strt : expr → strt

-- embedded types:

data ParseTreeT : Set where
  parsed-expr : expr → ParseTreeT
  parsed-strt : strt → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-var : var → ParseTreeT
  parsed-var-plus-2 : var-plus-2 → ParseTreeT
  parsed-var-range-1 : var-range-1 → ParseTreeT
  parsed-arrow : ParseTreeT
  parsed-arrow-bar-3 : ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-6 : ParseTreeT
  parsed-aws-bar-7 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-4 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-5 : ParseTreeT

------------------------------------------
-- Parse tree printing functions
------------------------------------------

posinfoToString : posinfo → string
posinfoToString x = "(posinfo " ^ x ^ ")"
varToString : var → string
varToString x = "(var " ^ x ^ ")"
var-plus-2ToString : var-plus-2 → string
var-plus-2ToString x = "(var-plus-2 " ^ x ^ ")"
var-range-1ToString : var-range-1 → string
var-range-1ToString x = "(var-range-1 " ^ x ^ ")"

mutual
  exprToString : expr → string
  exprToString (App x0 x1) = "(App" ^ " " ^ (exprToString x0) ^ " " ^ (exprToString x1) ^ ")"
  exprToString (Cons x0 x1) = "(Cons" ^ " " ^ (exprToString x0) ^ " " ^ (exprToString x1) ^ ")"
  exprToString (Nil) = "Nil" ^ ""
  exprToString (Parens x0) = "(Parens" ^ " " ^ (exprToString x0) ^ ")"
  exprToString (Var x0) = "(Var" ^ " " ^ (varToString x0) ^ ")"

  strtToString : strt → string
  strtToString (Strt x0) = "(Strt" ^ " " ^ (exprToString x0) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-expr t) = exprToString t
ParseTreeToString (parsed-strt t) = strtToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-var t) = varToString t
ParseTreeToString (parsed-var-plus-2 t) = var-plus-2ToString t
ParseTreeToString (parsed-var-range-1 t) = var-range-1ToString t
ParseTreeToString parsed-arrow = "[arrow]"
ParseTreeToString parsed-arrow-bar-3 = "[arrow-bar-3]"
ParseTreeToString parsed-aws = "[aws]"
ParseTreeToString parsed-aws-bar-6 = "[aws-bar-6]"
ParseTreeToString parsed-aws-bar-7 = "[aws-bar-7]"
ParseTreeToString parsed-ows = "[ows]"
ParseTreeToString parsed-ows-star-4 = "[ows-star-4]"
ParseTreeToString parsed-ws = "[ws]"
ParseTreeToString parsed-ws-plus-5 = "[ws-plus-5]"

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
  norm-expr (Cons x1 (App x2 x3)) = (norm-expr (App  (norm-expr (Cons  x1 x2) ) x3) )
  norm-expr (Cons (App x1 x2) x3) = (norm-expr (App  x1 (norm-expr (Cons  x2 x3) )) )
  norm-expr (App (App x1 x2) x3) = (norm-expr (App  x1 (norm-expr (App  x2 x3) )) )
  norm-expr (Cons (Cons x1 x2) x3) = (norm-expr (Cons  x1 (norm-expr (Cons  x2 x3) )) )
  norm-expr x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

