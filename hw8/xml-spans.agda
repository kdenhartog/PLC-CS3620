module xml-spans where

open import xml-types
open import lib

--------------------------------------------------
-- tagged values, which go in spans
--------------------------------------------------
tagged-val : Set
tagged-val = string × string

tagged-val-to-string : tagged-val → string
tagged-val-to-string (tag , val) = "\"" ^ tag ^ "\":\"" ^ val ^ "\""

tagged-vals-to-string : 𝕃 tagged-val → string
tagged-vals-to-string [] = ""
tagged-vals-to-string (s :: ss) = tagged-val-to-string s ^ tagged-vals-to-string ss

--------------------------------------------------
-- span datatype
--
-- individual spans with an error message should
-- include a tagged-val with the tag "error"
-- (see is-error-span below)
--------------------------------------------------
data span : Set where
  mk-span : string → posinfo → posinfo → 𝕃 tagged-val {- extra information for the span -} → span

span-to-string : span → string
span-to-string (mk-span name start end extra) = 
  "[\"" ^ name ^ "\"," ^ start ^ "," ^ end ^ ",{" ^ tagged-vals-to-string extra ^ "}]"

spans-to-string : 𝕃 span → string
spans-to-string ss = "{\"spans\":[" ^ (string-concat-sep-map "," span-to-string ss) ^ "]}"

global-error-string : string → string
global-error-string msg = "{\"error\":\"" ^ msg ^ "\"" ^ "}"

StartEnd-span : posinfo → string → posinfo → span
StartEnd-span pi x pi' = mk-span "Startend" pi pi' []

error-data : string → tagged-val
error-data e = "error" , e

Nested-span : posinfo → posinfo → span
Nested-span pi pi' = mk-span "Element" pi pi' []

endtag-mismatch-span : posinfo → posinfo → string → string → span
endtag-mismatch-span pi pi' x x' = mk-span "Mismatch" pi pi' [ error-data ("incorrect endtag, should be " ^ x) ]
