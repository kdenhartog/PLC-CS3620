----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module lettuce-types where

open import lib
open import parse-tree

posinfo = string
num = string
num-plus-6 = string
num-range-5 = string
var = string
var-plus-8 = string
var-range-7 = string

mutual

  data global : Set where 
    Global : var → num → global

  data globals : Set where 
    GlobalsCons : global → globals → globals
    GlobalsNil : globals

  data letterm : Set where 
    Let : posinfo → var → letterm → letterm → letterm
    Parens : letterm → letterm
    Plus : letterm → letterm → letterm
    Var : posinfo → var → letterm

  data start : Set where 
    InputTerm : globals → letterm → start

-- embedded types:
atom : Set
atom = letterm
term : Set
term = letterm

data ParseTreeT : Set where
  parsed-global : global → ParseTreeT
  parsed-globals : globals → ParseTreeT
  parsed-letterm : letterm → ParseTreeT
  parsed-start : start → ParseTreeT
  parsed-atom : letterm → ParseTreeT
  parsed-term : letterm → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-num : num → ParseTreeT
  parsed-num-plus-6 : num-plus-6 → ParseTreeT
  parsed-num-range-5 : num-range-5 → ParseTreeT
  parsed-var : var → ParseTreeT
  parsed-var-plus-8 : var-plus-8 → ParseTreeT
  parsed-var-range-7 : var-range-7 → ParseTreeT
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
numToString : num → string
numToString x = "(num " ^ x ^ ")"
num-plus-6ToString : num-plus-6 → string
num-plus-6ToString x = "(num-plus-6 " ^ x ^ ")"
num-range-5ToString : num-range-5 → string
num-range-5ToString x = "(num-range-5 " ^ x ^ ")"
varToString : var → string
varToString x = "(var " ^ x ^ ")"
var-plus-8ToString : var-plus-8 → string
var-plus-8ToString x = "(var-plus-8 " ^ x ^ ")"
var-range-7ToString : var-range-7 → string
var-range-7ToString x = "(var-range-7 " ^ x ^ ")"

mutual
  globalToString : global → string
  globalToString (Global x0 x1) = "(Global" ^ " " ^ (varToString x0) ^ " " ^ (numToString x1) ^ ")"

  globalsToString : globals → string
  globalsToString (GlobalsCons x0 x1) = "(GlobalsCons" ^ " " ^ (globalToString x0) ^ " " ^ (globalsToString x1) ^ ")"
  globalsToString (GlobalsNil) = "GlobalsNil" ^ ""

  lettermToString : letterm → string
  lettermToString (Let x0 x1 x2 x3) = "(Let" ^ " " ^ (posinfoToString x0) ^ " " ^ (varToString x1) ^ " " ^ (lettermToString x2) ^ " " ^ (lettermToString x3) ^ ")"
  lettermToString (Parens x0) = "(Parens" ^ " " ^ (lettermToString x0) ^ ")"
  lettermToString (Plus x0 x1) = "(Plus" ^ " " ^ (lettermToString x0) ^ " " ^ (lettermToString x1) ^ ")"
  lettermToString (Var x0 x1) = "(Var" ^ " " ^ (posinfoToString x0) ^ " " ^ (varToString x1) ^ ")"

  startToString : start → string
  startToString (InputTerm x0 x1) = "(InputTerm" ^ " " ^ (globalsToString x0) ^ " " ^ (lettermToString x1) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-global t) = globalToString t
ParseTreeToString (parsed-globals t) = globalsToString t
ParseTreeToString (parsed-letterm t) = lettermToString t
ParseTreeToString (parsed-start t) = startToString t
ParseTreeToString (parsed-atom t) = lettermToString t
ParseTreeToString (parsed-term t) = lettermToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-num t) = numToString t
ParseTreeToString (parsed-num-plus-6 t) = num-plus-6ToString t
ParseTreeToString (parsed-num-range-5 t) = num-range-5ToString t
ParseTreeToString (parsed-var t) = varToString t
ParseTreeToString (parsed-var-plus-8 t) = var-plus-8ToString t
ParseTreeToString (parsed-var-range-7 t) = var-range-7ToString t
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
  norm-term : (x : term) → term
  norm-term x = x

  {-# TERMINATING #-}
  norm-start : (x : start) → start
  norm-start x = x

  {-# TERMINATING #-}
  norm-posinfo : (x : posinfo) → posinfo
  norm-posinfo x = x

  {-# TERMINATING #-}
  norm-letterm : (x : letterm) → letterm
  norm-letterm x = x

  {-# TERMINATING #-}
  norm-globals : (x : globals) → globals
  norm-globals x = x

  {-# TERMINATING #-}
  norm-global : (x : global) → global
  norm-global x = x

  {-# TERMINATING #-}
  norm-atom : (x : atom) → atom
  norm-atom x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

