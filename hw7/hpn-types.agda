----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module hpn-types where

open import lib
open import parse-tree

posinfo = string
num = string
num-bar-4 = string
posdig = string
posdig-range-1 = string
posnum = string
posnum-bar-2 = string
posnum-plus-3 = string

mutual

  data atom : Set where 
    Pow : hpn → atom

  data cmd : Set where 
    ToDecimal : hpn → posnum → cmd
    ToHpn : posnum → posnum → cmd

  data cmds : Set where 
    CmdsNext : cmd → cmds → cmds
    CmdsStart : cmd → cmds

  data hpn : Set where 
    SeqNext : atom → hpn → hpn
    SeqStart : atom → hpn
    Zero : hpn

  data strt : Set where 
    Strt : cmds → strt

-- embedded types:

data ParseTreeT : Set where
  parsed-atom : atom → ParseTreeT
  parsed-cmd : cmd → ParseTreeT
  parsed-cmds : cmds → ParseTreeT
  parsed-hpn : hpn → ParseTreeT
  parsed-strt : strt → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-num : num → ParseTreeT
  parsed-num-bar-4 : num-bar-4 → ParseTreeT
  parsed-posdig : posdig → ParseTreeT
  parsed-posdig-range-1 : posdig-range-1 → ParseTreeT
  parsed-posnum : posnum → ParseTreeT
  parsed-posnum-bar-2 : posnum-bar-2 → ParseTreeT
  parsed-posnum-plus-3 : posnum-plus-3 → ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-5 : ParseTreeT
  parsed-aws-bar-6 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-8 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-7 : ParseTreeT

------------------------------------------
-- Parse tree printing functions
------------------------------------------

posinfoToString : posinfo → string
posinfoToString x = "(posinfo " ^ x ^ ")"
numToString : num → string
numToString x = "(num " ^ x ^ ")"
num-bar-4ToString : num-bar-4 → string
num-bar-4ToString x = "(num-bar-4 " ^ x ^ ")"
posdigToString : posdig → string
posdigToString x = "(posdig " ^ x ^ ")"
posdig-range-1ToString : posdig-range-1 → string
posdig-range-1ToString x = "(posdig-range-1 " ^ x ^ ")"
posnumToString : posnum → string
posnumToString x = "(posnum " ^ x ^ ")"
posnum-bar-2ToString : posnum-bar-2 → string
posnum-bar-2ToString x = "(posnum-bar-2 " ^ x ^ ")"
posnum-plus-3ToString : posnum-plus-3 → string
posnum-plus-3ToString x = "(posnum-plus-3 " ^ x ^ ")"

mutual
  atomToString : atom → string
  atomToString (Pow x0) = "(Pow" ^ " " ^ (hpnToString x0) ^ ")"

  cmdToString : cmd → string
  cmdToString (ToDecimal x0 x1) = "(ToDecimal" ^ " " ^ (hpnToString x0) ^ " " ^ (posnumToString x1) ^ ")"
  cmdToString (ToHpn x0 x1) = "(ToHpn" ^ " " ^ (posnumToString x0) ^ " " ^ (posnumToString x1) ^ ")"

  cmdsToString : cmds → string
  cmdsToString (CmdsNext x0 x1) = "(CmdsNext" ^ " " ^ (cmdToString x0) ^ " " ^ (cmdsToString x1) ^ ")"
  cmdsToString (CmdsStart x0) = "(CmdsStart" ^ " " ^ (cmdToString x0) ^ ")"

  hpnToString : hpn → string
  hpnToString (SeqNext x0 x1) = "(SeqNext" ^ " " ^ (atomToString x0) ^ " " ^ (hpnToString x1) ^ ")"
  hpnToString (SeqStart x0) = "(SeqStart" ^ " " ^ (atomToString x0) ^ ")"
  hpnToString (Zero) = "Zero" ^ ""

  strtToString : strt → string
  strtToString (Strt x0) = "(Strt" ^ " " ^ (cmdsToString x0) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-atom t) = atomToString t
ParseTreeToString (parsed-cmd t) = cmdToString t
ParseTreeToString (parsed-cmds t) = cmdsToString t
ParseTreeToString (parsed-hpn t) = hpnToString t
ParseTreeToString (parsed-strt t) = strtToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-num t) = numToString t
ParseTreeToString (parsed-num-bar-4 t) = num-bar-4ToString t
ParseTreeToString (parsed-posdig t) = posdigToString t
ParseTreeToString (parsed-posdig-range-1 t) = posdig-range-1ToString t
ParseTreeToString (parsed-posnum t) = posnumToString t
ParseTreeToString (parsed-posnum-bar-2 t) = posnum-bar-2ToString t
ParseTreeToString (parsed-posnum-plus-3 t) = posnum-plus-3ToString t
ParseTreeToString parsed-aws = "[aws]"
ParseTreeToString parsed-aws-bar-5 = "[aws-bar-5]"
ParseTreeToString parsed-aws-bar-6 = "[aws-bar-6]"
ParseTreeToString parsed-ows = "[ows]"
ParseTreeToString parsed-ows-star-8 = "[ows-star-8]"
ParseTreeToString parsed-ws = "[ws]"
ParseTreeToString parsed-ws-plus-7 = "[ws-plus-7]"

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
  norm-hpn : (x : hpn) → hpn
  norm-hpn x = x

  {-# TERMINATING #-}
  norm-cmds : (x : cmds) → cmds
  norm-cmds x = x

  {-# TERMINATING #-}
  norm-cmd : (x : cmd) → cmd
  norm-cmd x = x

  {-# TERMINATING #-}
  norm-atom : (x : atom) → atom
  norm-atom x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

