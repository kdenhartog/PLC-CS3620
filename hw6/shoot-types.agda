----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module shoot-types where

open import lib
open import parse-tree

posinfo = string
d = string
declared = string
defs = string
ds = string
is-declared = string
letterm = string
num = string
num-plus-11 = string
num-range-10 = string
start = string
start-opt-1 = string
start-opt-2 = string
start-opt-3 = string
term = string
used = string
var = string
var-plus-9 = string
var-range-8 = string
vars = string

-- embedded types:

data ParseTreeT : Set where
  parsed-posinfo : posinfo → ParseTreeT
  parsed-d : d → ParseTreeT
  parsed-declared : declared → ParseTreeT
  parsed-defs : defs → ParseTreeT
  parsed-ds : ds → ParseTreeT
  parsed-is-declared : is-declared → ParseTreeT
  parsed-letterm : letterm → ParseTreeT
  parsed-num : num → ParseTreeT
  parsed-num-plus-11 : num-plus-11 → ParseTreeT
  parsed-num-range-10 : num-range-10 → ParseTreeT
  parsed-start : start → ParseTreeT
  parsed-start-opt-1 : start-opt-1 → ParseTreeT
  parsed-start-opt-2 : start-opt-2 → ParseTreeT
  parsed-start-opt-3 : start-opt-3 → ParseTreeT
  parsed-term : term → ParseTreeT
  parsed-used : used → ParseTreeT
  parsed-var : var → ParseTreeT
  parsed-var-plus-9 : var-plus-9 → ParseTreeT
  parsed-var-range-8 : var-range-8 → ParseTreeT
  parsed-vars : vars → ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-4 : ParseTreeT
  parsed-aws-bar-5 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-7 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-6 : ParseTreeT

------------------------------------------
-- Parse tree printing functions
------------------------------------------

posinfoToString : posinfo → string
posinfoToString x = "(posinfo " ^ x ^ ")"
dToString : d → string
dToString x = "(d " ^ x ^ ")"
declaredToString : declared → string
declaredToString x = "(declared " ^ x ^ ")"
defsToString : defs → string
defsToString x = "(defs " ^ x ^ ")"
dsToString : ds → string
dsToString x = "(ds " ^ x ^ ")"
is-declaredToString : is-declared → string
is-declaredToString x = "(is-declared " ^ x ^ ")"
lettermToString : letterm → string
lettermToString x = "(letterm " ^ x ^ ")"
numToString : num → string
numToString x = "(num " ^ x ^ ")"
num-plus-11ToString : num-plus-11 → string
num-plus-11ToString x = "(num-plus-11 " ^ x ^ ")"
num-range-10ToString : num-range-10 → string
num-range-10ToString x = "(num-range-10 " ^ x ^ ")"
startToString : start → string
startToString x = "(start " ^ x ^ ")"
start-opt-1ToString : start-opt-1 → string
start-opt-1ToString x = "(start-opt-1 " ^ x ^ ")"
start-opt-2ToString : start-opt-2 → string
start-opt-2ToString x = "(start-opt-2 " ^ x ^ ")"
start-opt-3ToString : start-opt-3 → string
start-opt-3ToString x = "(start-opt-3 " ^ x ^ ")"
termToString : term → string
termToString x = "(term " ^ x ^ ")"
usedToString : used → string
usedToString x = "(used " ^ x ^ ")"
varToString : var → string
varToString x = "(var " ^ x ^ ")"
var-plus-9ToString : var-plus-9 → string
var-plus-9ToString x = "(var-plus-9 " ^ x ^ ")"
var-range-8ToString : var-range-8 → string
var-range-8ToString x = "(var-range-8 " ^ x ^ ")"
varsToString : vars → string
varsToString x = "(vars " ^ x ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-d t) = dToString t
ParseTreeToString (parsed-declared t) = declaredToString t
ParseTreeToString (parsed-defs t) = defsToString t
ParseTreeToString (parsed-ds t) = dsToString t
ParseTreeToString (parsed-is-declared t) = is-declaredToString t
ParseTreeToString (parsed-letterm t) = lettermToString t
ParseTreeToString (parsed-num t) = numToString t
ParseTreeToString (parsed-num-plus-11 t) = num-plus-11ToString t
ParseTreeToString (parsed-num-range-10 t) = num-range-10ToString t
ParseTreeToString (parsed-start t) = startToString t
ParseTreeToString (parsed-start-opt-1 t) = start-opt-1ToString t
ParseTreeToString (parsed-start-opt-2 t) = start-opt-2ToString t
ParseTreeToString (parsed-start-opt-3 t) = start-opt-3ToString t
ParseTreeToString (parsed-term t) = termToString t
ParseTreeToString (parsed-used t) = usedToString t
ParseTreeToString (parsed-var t) = varToString t
ParseTreeToString (parsed-var-plus-9 t) = var-plus-9ToString t
ParseTreeToString (parsed-var-range-8 t) = var-range-8ToString t
ParseTreeToString (parsed-vars t) = varsToString t
ParseTreeToString parsed-aws = "[aws]"
ParseTreeToString parsed-aws-bar-4 = "[aws-bar-4]"
ParseTreeToString parsed-aws-bar-5 = "[aws-bar-5]"
ParseTreeToString parsed-ows = "[ows]"
ParseTreeToString parsed-ows-star-7 = "[ows-star-7]"
ParseTreeToString parsed-ws = "[ws]"
ParseTreeToString parsed-ws-plus-6 = "[ws-plus-6]"

------------------------------------------
-- Reorganizing rules
------------------------------------------

mutual

  {-# TERMINATING #-}
  norm-posinfo : (x : posinfo) → posinfo
  norm-posinfo x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

