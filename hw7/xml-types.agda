----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module xml-types where

open import lib
open import parse-tree

posinfo = string
id = string
id-plus-5 = string
namechar = string
namechar-range-11 = string
strlit = string
strlit-bar-6 = string
strlit-bar-7 = string
strlit-bar-8 = string
strlit-bar-9 = string
strlit-star-10 = string

mutual

  data attrs : Set where 
    AttrsCons : id → strlit → attrs → attrs
    AttrsNil : attrs

  data endtag : Set where 
    EndTag : id → endtag

  data start : Set where 
    Strt : xml → start

  data startendtag : Set where 
    Startendtag : id → attrs → startendtag

  data starttag : Set where 
    StartTag : id → attrs → starttag

  data xml : Set where 
    Nested : starttag → xml → endtag → xml
    Seq : xml → xml → xml
    StartEnd : startendtag → xml

-- embedded types:

data ParseTreeT : Set where
  parsed-attrs : attrs → ParseTreeT
  parsed-endtag : endtag → ParseTreeT
  parsed-start : start → ParseTreeT
  parsed-startendtag : startendtag → ParseTreeT
  parsed-starttag : starttag → ParseTreeT
  parsed-xml : xml → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-id : id → ParseTreeT
  parsed-id-plus-5 : id-plus-5 → ParseTreeT
  parsed-namechar : namechar → ParseTreeT
  parsed-namechar-range-11 : namechar-range-11 → ParseTreeT
  parsed-strlit : strlit → ParseTreeT
  parsed-strlit-bar-6 : strlit-bar-6 → ParseTreeT
  parsed-strlit-bar-7 : strlit-bar-7 → ParseTreeT
  parsed-strlit-bar-8 : strlit-bar-8 → ParseTreeT
  parsed-strlit-bar-9 : strlit-bar-9 → ParseTreeT
  parsed-strlit-star-10 : strlit-star-10 → ParseTreeT
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
id-plus-5ToString : id-plus-5 → string
id-plus-5ToString x = "(id-plus-5 " ^ x ^ ")"
namecharToString : namechar → string
namecharToString x = "(namechar " ^ x ^ ")"
namechar-range-11ToString : namechar-range-11 → string
namechar-range-11ToString x = "(namechar-range-11 " ^ x ^ ")"
strlitToString : strlit → string
strlitToString x = "(strlit " ^ x ^ ")"
strlit-bar-6ToString : strlit-bar-6 → string
strlit-bar-6ToString x = "(strlit-bar-6 " ^ x ^ ")"
strlit-bar-7ToString : strlit-bar-7 → string
strlit-bar-7ToString x = "(strlit-bar-7 " ^ x ^ ")"
strlit-bar-8ToString : strlit-bar-8 → string
strlit-bar-8ToString x = "(strlit-bar-8 " ^ x ^ ")"
strlit-bar-9ToString : strlit-bar-9 → string
strlit-bar-9ToString x = "(strlit-bar-9 " ^ x ^ ")"
strlit-star-10ToString : strlit-star-10 → string
strlit-star-10ToString x = "(strlit-star-10 " ^ x ^ ")"

mutual
  attrsToString : attrs → string
  attrsToString (AttrsCons x0 x1 x2) = "(AttrsCons" ^ " " ^ (idToString x0) ^ " " ^ (strlitToString x1) ^ " " ^ (attrsToString x2) ^ ")"
  attrsToString (AttrsNil) = "AttrsNil" ^ ""

  endtagToString : endtag → string
  endtagToString (EndTag x0) = "(EndTag" ^ " " ^ (idToString x0) ^ ")"

  startToString : start → string
  startToString (Strt x0) = "(Strt" ^ " " ^ (xmlToString x0) ^ ")"

  startendtagToString : startendtag → string
  startendtagToString (Startendtag x0 x1) = "(Startendtag" ^ " " ^ (idToString x0) ^ " " ^ (attrsToString x1) ^ ")"

  starttagToString : starttag → string
  starttagToString (StartTag x0 x1) = "(StartTag" ^ " " ^ (idToString x0) ^ " " ^ (attrsToString x1) ^ ")"

  xmlToString : xml → string
  xmlToString (Nested x0 x1 x2) = "(Nested" ^ " " ^ (starttagToString x0) ^ " " ^ (xmlToString x1) ^ " " ^ (endtagToString x2) ^ ")"
  xmlToString (Seq x0 x1) = "(Seq" ^ " " ^ (xmlToString x0) ^ " " ^ (xmlToString x1) ^ ")"
  xmlToString (StartEnd x0) = "(StartEnd" ^ " " ^ (startendtagToString x0) ^ ")"

ParseTreeToString : ParseTreeT → string
ParseTreeToString (parsed-attrs t) = attrsToString t
ParseTreeToString (parsed-endtag t) = endtagToString t
ParseTreeToString (parsed-start t) = startToString t
ParseTreeToString (parsed-startendtag t) = startendtagToString t
ParseTreeToString (parsed-starttag t) = starttagToString t
ParseTreeToString (parsed-xml t) = xmlToString t
ParseTreeToString (parsed-posinfo t) = posinfoToString t
ParseTreeToString (parsed-id t) = idToString t
ParseTreeToString (parsed-id-plus-5 t) = id-plus-5ToString t
ParseTreeToString (parsed-namechar t) = namecharToString t
ParseTreeToString (parsed-namechar-range-11 t) = namechar-range-11ToString t
ParseTreeToString (parsed-strlit t) = strlitToString t
ParseTreeToString (parsed-strlit-bar-6 t) = strlit-bar-6ToString t
ParseTreeToString (parsed-strlit-bar-7 t) = strlit-bar-7ToString t
ParseTreeToString (parsed-strlit-bar-8 t) = strlit-bar-8ToString t
ParseTreeToString (parsed-strlit-bar-9 t) = strlit-bar-9ToString t
ParseTreeToString (parsed-strlit-star-10 t) = strlit-star-10ToString t
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
  norm-xml : (x : xml) → xml
  norm-xml (Seq (Seq x1 x2) x3) = (norm-xml (Seq  x1 (norm-xml (Seq  x2 x3) )) )
  norm-xml x = x

  {-# TERMINATING #-}
  norm-starttag : (x : starttag) → starttag
  norm-starttag x = x

  {-# TERMINATING #-}
  norm-startendtag : (x : startendtag) → startendtag
  norm-startendtag x = x

  {-# TERMINATING #-}
  norm-start : (x : start) → start
  norm-start x = x

  {-# TERMINATING #-}
  norm-posinfo : (x : posinfo) → posinfo
  norm-posinfo x = x

  {-# TERMINATING #-}
  norm-endtag : (x : endtag) → endtag
  norm-endtag x = x

  {-# TERMINATING #-}
  norm-attrs : (x : attrs) → attrs
  norm-attrs x = x

isParseTree : ParseTreeT → 𝕃 char → string → Set
isParseTree p l s = ⊤ {- this will be ignored since we are using simply typed runs -}

ptr : ParseTreeRec
ptr = record { ParseTreeT = ParseTreeT ; isParseTree = isParseTree ; ParseTreeToString = ParseTreeToString }

