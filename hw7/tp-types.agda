----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module tp-types where

open import lib
open import parse-tree

posinfo = string
var = string
var-plus-2 = string
var-range-1 = string

mutual

  data decl : Set where 
    Decl : var → tp → decl
    Decl/1 : decl

  data decls : Set where 
    CmdsStart : decl → decls
    declNext : decl → decls → decls

  data strt : Set where 
    Strt : decls → strt

  data tp : Set where 
    Arrow : tp → tp → tp
    Parens : tp → tp
    Var : var → tp

-- embedded types:

data ParseTreeT : Set where
  parsed-decl : decl → ParseTreeT
  parsed-decls : decls → ParseTreeT
  parsed-strt : strt → ParseTreeT
  parsed-tp : tp → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-var : var → ParseTreeT
  parsed-var-plus-2 : var-plus-2 → ParseTreeT
  parsed-var-range-1 : var-range-1 → ParseTreeT
  parsed-arrow : ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-5 : ParseTreeT
  parsed-aws-bar-6 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-3 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-4 : ParseTreeT

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
  declToString : decl → string
  declToString (Decl x0 x1) = "(Decl" ^ " " ^ (varToString x0) ^ " " ^ (tpToString x1) ^ ")"
  declToString (Decl/1) = "Decl/1" ^ ""

  declsToString : decls → string
  declsToString (CmdsStart x0) = "(CmdsStart" ^ " " ^ (declToString x0) ^ ")"
  declsToString (declNext x0 x1) = "(declNext" ^ " " ^ (declToString x0) ^ " " ^ (declsToString x1) ^ ")"

  strtToString : strt → string
  strtToString (Strt x0) = "(Strt" ^ " " ^ (declsToString x0) ^ ")"

  tpToString : tp → string
  tpToString (Arrow x0 x1) = "(Arrow" ^ " " ^ (tpToString x0) ^ " " ^ (tpToString x1) ^ ")"
  tpToString (Parens x0) = "(Parens" ^ " " ^ (tpToString x0) ^ ")"
  tpToString (Var x0) = "(Var" ^ " " ^ (varToString x0) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-decl t) = declToString t
ParseTreeToString (parsed-decls t) = declsToString t
ParseTreeToString (parsed-strt t) = strtToString t
ParseTreeToString (parsed-tp t) = tpToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-var t) = varToString t
ParseTreeToString (parsed-var-plus-2 t) = var-plus-2ToString t
ParseTreeToString (parsed-var-range-1 t) = var-range-1ToString t
ParseTreeToString parsed-arrow = "[arrow]"
ParseTreeToString parsed-aws = "[aws]"
ParseTreeToString parsed-aws-bar-5 = "[aws-bar-5]"
ParseTreeToString parsed-aws-bar-6 = "[aws-bar-6]"
ParseTreeToString parsed-ows = "[ows]"
ParseTreeToString parsed-ows-star-3 = "[ows-star-3]"
ParseTreeToString parsed-ws = "[ws]"
ParseTreeToString parsed-ws-plus-4 = "[ws-plus-4]"

------------------------------------------
-- Reorganizing rules
------------------------------------------

mutual

  {-# TERMINATING #-}
  norm-tp : (x : tp) → tp
  norm-tp (Arrow (Arrow x1 x2) x3) = (norm-tp (Arrow  x1 (norm-tp (Arrow  x2 x3) )) )
  norm-tp x = x

  {-# TERMINATING #-}
  norm-strt : (x : strt) → strt
  norm-strt x = x

  {-# TERMINATING #-}
  norm-posinfo : (x : posinfo) → posinfo
  norm-posinfo x = x

  {-# TERMINATING #-}
  norm-decls : (x : decls) → decls
  norm-decls x = x

  {-# TERMINATING #-}
  norm-decl : (x : decl) → decl
  norm-decl x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

