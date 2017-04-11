module xml where

open import lib

open import xml-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _xml : gratr2-nt
  _ws-plus-3 : gratr2-nt
  _ws : gratr2-nt
  _strlit-star-11 : gratr2-nt
  _strlit-bar-9 : gratr2-nt
  _strlit-bar-8 : gratr2-nt
  _strlit-bar-7 : gratr2-nt
  _strlit-bar-6 : gratr2-nt
  _strlit-bar-10 : gratr2-nt
  _strlit : gratr2-nt
  _starttag : gratr2-nt
  _startendtag : gratr2-nt
  _start : gratr2-nt
  _posinfo : gratr2-nt
  _ows-star-4 : gratr2-nt
  _ows : gratr2-nt
  _namechar-range-12 : gratr2-nt
  _namechar : gratr2-nt
  _id-plus-5 : gratr2-nt
  _id : gratr2-nt
  _endtag : gratr2-nt
  _aws-bar-2 : gratr2-nt
  _aws-bar-1 : gratr2-nt
  _aws : gratr2-nt
  _attrs : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _xml _xml = tt
gratr2-nt-eq  _ws-plus-3 _ws-plus-3 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _strlit-star-11 _strlit-star-11 = tt
gratr2-nt-eq  _strlit-bar-9 _strlit-bar-9 = tt
gratr2-nt-eq  _strlit-bar-8 _strlit-bar-8 = tt
gratr2-nt-eq  _strlit-bar-7 _strlit-bar-7 = tt
gratr2-nt-eq  _strlit-bar-6 _strlit-bar-6 = tt
gratr2-nt-eq  _strlit-bar-10 _strlit-bar-10 = tt
gratr2-nt-eq  _strlit _strlit = tt
gratr2-nt-eq  _starttag _starttag = tt
gratr2-nt-eq  _startendtag _startendtag = tt
gratr2-nt-eq  _start _start = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _ows-star-4 _ows-star-4 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _namechar-range-12 _namechar-range-12 = tt
gratr2-nt-eq  _namechar _namechar = tt
gratr2-nt-eq  _id-plus-5 _id-plus-5 = tt
gratr2-nt-eq  _id _id = tt
gratr2-nt-eq  _endtag _endtag = tt
gratr2-nt-eq  _aws-bar-2 _aws-bar-2 = tt
gratr2-nt-eq  _aws-bar-1 _aws-bar-1 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq  _attrs _attrs = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


xml-start : gratr2-nt → 𝕃 gratr2-rule
xml-start _xml = (just "StartEnd" , nothing , just _xml , inj₁ _startendtag :: []) :: (just "Nested" , nothing , just _xml , inj₁ _starttag :: inj₁ _ows :: inj₁ _xml :: inj₁ _ows :: inj₁ _endtag :: []) :: []
xml-start _ws-plus-3 = (just "P6" , nothing , just _ws-plus-3 , inj₁ _aws :: inj₁ _ws-plus-3 :: []) :: (just "P5" , nothing , just _ws-plus-3 , inj₁ _aws :: []) :: []
xml-start _ws = (just "P7" , nothing , just _ws , inj₁ _ws-plus-3 :: []) :: []
xml-start _strlit-star-11 = (just "P25" , nothing , just _strlit-star-11 , inj₁ _strlit-bar-10 :: inj₁ _strlit-star-11 :: []) :: (just "P24" , nothing , just _strlit-star-11 , []) :: []
xml-start _strlit-bar-9 = (just "P21" , nothing , just _strlit-bar-9 , inj₁ _strlit-bar-8 :: []) :: (just "P20" , nothing , just _strlit-bar-9 , inj₂ ',' :: []) :: []
xml-start _strlit-bar-8 = (just "P19" , nothing , just _strlit-bar-8 , inj₁ _strlit-bar-7 :: []) :: (just "P18" , nothing , just _strlit-bar-8 , inj₂ '.' :: []) :: []
xml-start _strlit-bar-7 = (just "P17" , nothing , just _strlit-bar-7 , inj₁ _strlit-bar-6 :: []) :: (just "P16" , nothing , just _strlit-bar-7 , inj₂ ' ' :: []) :: []
xml-start _strlit-bar-6 = (just "P15" , nothing , just _strlit-bar-6 , inj₂ '\\' :: inj₂ '\"' :: []) :: (just "P14" , nothing , just _strlit-bar-6 , inj₂ '_' :: []) :: []
xml-start _strlit-bar-10 = (just "P23" , nothing , just _strlit-bar-10 , inj₁ _strlit-bar-9 :: []) :: (just "P22" , nothing , just _strlit-bar-10 , inj₁ _namechar :: []) :: []
xml-start _strlit = (just "P26" , nothing , just _strlit , inj₂ '\"' :: inj₁ _strlit-star-11 :: inj₂ '\"' :: []) :: []
xml-start _starttag = (just "StartTag" , nothing , just _starttag , inj₁ _posinfo :: inj₂ '<' :: inj₁ _id :: inj₁ _attrs :: inj₂ '>' :: inj₁ _posinfo :: []) :: []
xml-start _startendtag = (just "Startendtag" , nothing , just _startendtag , inj₁ _posinfo :: inj₂ '<' :: inj₁ _id :: inj₁ _attrs :: inj₂ '/' :: inj₂ '>' :: inj₁ _posinfo :: []) :: []
xml-start _start = (just "Strt" , just "Strt_end" , just _start , inj₁ _ows :: inj₁ _xml :: inj₁ _ows :: []) :: []
xml-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
xml-start _ows-star-4 = (just "P9" , nothing , just _ows-star-4 , inj₁ _aws :: inj₁ _ows-star-4 :: []) :: (just "P8" , nothing , just _ows-star-4 , []) :: []
xml-start _ows = (just "P10" , nothing , just _ows , inj₁ _ows-star-4 :: []) :: []
xml-start _namechar-range-12 = (just "P89" , nothing , just _namechar-range-12 , inj₂ 'z' :: []) :: (just "P88" , nothing , just _namechar-range-12 , inj₂ 'y' :: []) :: (just "P87" , nothing , just _namechar-range-12 , inj₂ 'x' :: []) :: (just "P86" , nothing , just _namechar-range-12 , inj₂ 'w' :: []) :: (just "P85" , nothing , just _namechar-range-12 , inj₂ 'v' :: []) :: (just "P84" , nothing , just _namechar-range-12 , inj₂ 'u' :: []) :: (just "P83" , nothing , just _namechar-range-12 , inj₂ 't' :: []) :: (just "P82" , nothing , just _namechar-range-12 , inj₂ 's' :: []) :: (just "P81" , nothing , just _namechar-range-12 , inj₂ 'r' :: []) :: (just "P80" , nothing , just _namechar-range-12 , inj₂ 'q' :: []) :: (just "P79" , nothing , just _namechar-range-12 , inj₂ 'p' :: []) :: (just "P78" , nothing , just _namechar-range-12 , inj₂ 'o' :: []) :: (just "P77" , nothing , just _namechar-range-12 , inj₂ 'n' :: []) :: (just "P76" , nothing , just _namechar-range-12 , inj₂ 'm' :: []) :: (just "P75" , nothing , just _namechar-range-12 , inj₂ 'l' :: []) :: (just "P74" , nothing , just _namechar-range-12 , inj₂ 'k' :: []) :: (just "P73" , nothing , just _namechar-range-12 , inj₂ 'j' :: []) :: (just "P72" , nothing , just _namechar-range-12 , inj₂ 'i' :: []) :: (just "P71" , nothing , just _namechar-range-12 , inj₂ 'h' :: []) :: (just "P70" , nothing , just _namechar-range-12 , inj₂ 'g' :: []) :: (just "P69" , nothing , just _namechar-range-12 , inj₂ 'f' :: []) :: (just "P68" , nothing , just _namechar-range-12 , inj₂ 'e' :: []) :: (just "P67" , nothing , just _namechar-range-12 , inj₂ 'd' :: []) :: (just "P66" , nothing , just _namechar-range-12 , inj₂ 'c' :: []) :: (just "P65" , nothing , just _namechar-range-12 , inj₂ 'b' :: []) :: (just "P64" , nothing , just _namechar-range-12 , inj₂ 'a' :: []) :: (just "P63" , nothing , just _namechar-range-12 , inj₂ 'Z' :: []) :: (just "P62" , nothing , just _namechar-range-12 , inj₂ 'Y' :: []) :: (just "P61" , nothing , just _namechar-range-12 , inj₂ 'X' :: []) :: (just "P60" , nothing , just _namechar-range-12 , inj₂ 'W' :: []) :: (just "P59" , nothing , just _namechar-range-12 , inj₂ 'V' :: []) :: (just "P58" , nothing , just _namechar-range-12 , inj₂ 'U' :: []) :: (just "P57" , nothing , just _namechar-range-12 , inj₂ 'T' :: []) :: (just "P56" , nothing , just _namechar-range-12 , inj₂ 'S' :: []) :: (just "P55" , nothing , just _namechar-range-12 , inj₂ 'R' :: []) :: (just "P54" , nothing , just _namechar-range-12 , inj₂ 'Q' :: []) :: (just "P53" , nothing , just _namechar-range-12 , inj₂ 'P' :: []) :: (just "P52" , nothing , just _namechar-range-12 , inj₂ 'O' :: []) :: (just "P51" , nothing , just _namechar-range-12 , inj₂ 'N' :: []) :: (just "P50" , nothing , just _namechar-range-12 , inj₂ 'M' :: []) :: (just "P49" , nothing , just _namechar-range-12 , inj₂ 'L' :: []) :: (just "P48" , nothing , just _namechar-range-12 , inj₂ 'K' :: []) :: (just "P47" , nothing , just _namechar-range-12 , inj₂ 'J' :: []) :: (just "P46" , nothing , just _namechar-range-12 , inj₂ 'I' :: []) :: (just "P45" , nothing , just _namechar-range-12 , inj₂ 'H' :: []) :: (just "P44" , nothing , just _namechar-range-12 , inj₂ 'G' :: []) :: (just "P43" , nothing , just _namechar-range-12 , inj₂ 'F' :: []) :: (just "P42" , nothing , just _namechar-range-12 , inj₂ 'E' :: []) :: (just "P41" , nothing , just _namechar-range-12 , inj₂ 'D' :: []) :: (just "P40" , nothing , just _namechar-range-12 , inj₂ 'C' :: []) :: (just "P39" , nothing , just _namechar-range-12 , inj₂ 'B' :: []) :: (just "P38" , nothing , just _namechar-range-12 , inj₂ 'A' :: []) :: (just "P37" , nothing , just _namechar-range-12 , inj₂ '9' :: []) :: (just "P36" , nothing , just _namechar-range-12 , inj₂ '8' :: []) :: (just "P35" , nothing , just _namechar-range-12 , inj₂ '7' :: []) :: (just "P34" , nothing , just _namechar-range-12 , inj₂ '6' :: []) :: (just "P33" , nothing , just _namechar-range-12 , inj₂ '5' :: []) :: (just "P32" , nothing , just _namechar-range-12 , inj₂ '4' :: []) :: (just "P31" , nothing , just _namechar-range-12 , inj₂ '3' :: []) :: (just "P30" , nothing , just _namechar-range-12 , inj₂ '2' :: []) :: (just "P29" , nothing , just _namechar-range-12 , inj₂ '1' :: []) :: (just "P28" , nothing , just _namechar-range-12 , inj₂ '0' :: []) :: (just "P27" , nothing , just _namechar-range-12 , inj₂ '-' :: []) :: []
xml-start _namechar = (just "P90" , nothing , just _namechar , inj₁ _namechar-range-12 :: []) :: []
xml-start _id-plus-5 = (just "P12" , nothing , just _id-plus-5 , inj₁ _namechar :: inj₁ _id-plus-5 :: []) :: (just "P11" , nothing , just _id-plus-5 , inj₁ _namechar :: []) :: []
xml-start _id = (just "P13" , nothing , just _id , inj₁ _id-plus-5 :: []) :: []
xml-start _endtag = (just "EndTag" , nothing , just _endtag , inj₁ _posinfo :: inj₂ '<' :: inj₂ '/' :: inj₁ _id :: inj₂ '>' :: inj₁ _posinfo :: []) :: []
xml-start _aws-bar-2 = (just "P3" , nothing , just _aws-bar-2 , inj₁ _aws-bar-1 :: []) :: (just "P2" , nothing , just _aws-bar-2 , inj₂ '\n' :: []) :: []
xml-start _aws-bar-1 = (just "P1" , nothing , just _aws-bar-1 , inj₂ ' ' :: []) :: (just "P0" , nothing , just _aws-bar-1 , inj₂ '\t' :: []) :: []
xml-start _aws = (just "P4" , nothing , just _aws , inj₁ _aws-bar-2 :: []) :: []
xml-start _attrs = (just "AttrsNil" , nothing , just _attrs , []) :: (just "AttrsCons" , nothing , just _attrs , inj₁ _ws :: inj₁ _posinfo :: inj₁ _id :: inj₁ _posinfo :: inj₁ _ows :: inj₂ '=' :: inj₁ _ows :: inj₁ _posinfo :: inj₁ _strlit :: inj₁ _posinfo :: inj₁ _attrs :: []) :: []


xml-return : maybe gratr2-nt → 𝕃 gratr2-rule
xml-return (just _xml) = (nothing , nothing , just _xml , inj₁ _ows :: inj₁ _xml :: []) :: []
xml-return _ = []

xml-rtn : gratr2-rtn
xml-rtn = record { start = _start ; _eq_ = gratr2-nt-eq ; gratr2-start = xml-start ; gratr2-return = xml-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- AttrsCons-} ((Id "AttrsCons") :: (ParseTree parsed-ws) :: (ParseTree (parsed-posinfo x0)) :: (ParseTree (parsed-id x1)) :: (ParseTree (parsed-posinfo x2)) :: (ParseTree parsed-ows) :: (InputChar '=') :: (ParseTree parsed-ows) :: (ParseTree (parsed-posinfo x3)) :: (ParseTree (parsed-strlit x4)) :: (ParseTree (parsed-posinfo x5)) :: _::_(ParseTree (parsed-attrs x6)) rest) = just (ParseTree (parsed-attrs (norm-attrs (AttrsCons x0 x1 x2 x3 x4 x5 x6))) ::' rest , 12)
len-dec-rewrite {- EndTag-} ((Id "EndTag") :: (ParseTree (parsed-posinfo x0)) :: (InputChar '<') :: (InputChar '/') :: (ParseTree (parsed-id x1)) :: (InputChar '>') :: _::_(ParseTree (parsed-posinfo x2)) rest) = just (ParseTree (parsed-endtag (norm-endtag (EndTag x0 x1 x2))) ::' rest , 7)
len-dec-rewrite {- Nested-} ((Id "Nested") :: (ParseTree (parsed-starttag x0)) :: (ParseTree parsed-ows) :: (ParseTree (parsed-xml x1)) :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-endtag x2)) rest) = just (ParseTree (parsed-xml (norm-xml (Nested x0 x1 x2))) ::' rest , 6)
len-dec-rewrite {- P0-} ((Id "P0") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P1-} ((Id "P1") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P10-} ((Id "P10") :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P11-} ((Id "P11") :: _::_(ParseTree (parsed-namechar x0)) rest) = just (ParseTree (parsed-id-plus-5 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P12-} ((Id "P12") :: (ParseTree (parsed-namechar x0)) :: _::_(ParseTree (parsed-id-plus-5 x1)) rest) = just (ParseTree (parsed-id-plus-5 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P13-} ((Id "P13") :: _::_(ParseTree (parsed-id-plus-5 x0)) rest) = just (ParseTree (parsed-id (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P14-} ((Id "P14") :: _::_(InputChar '_') rest) = just (ParseTree (parsed-strlit-bar-6 (string-append 0 (char-to-string '_'))) ::' rest , 2)
len-dec-rewrite {- P15-} ((Id "P15") :: (InputChar '\\') :: _::_(InputChar '\"') rest) = just (ParseTree (parsed-strlit-bar-6 (string-append 1 (char-to-string '\\') (char-to-string '\"'))) ::' rest , 3)
len-dec-rewrite {- P16-} ((Id "P16") :: _::_(InputChar ' ') rest) = just (ParseTree (parsed-strlit-bar-7 (string-append 0 (char-to-string ' '))) ::' rest , 2)
len-dec-rewrite {- P17-} ((Id "P17") :: _::_(ParseTree (parsed-strlit-bar-6 x0)) rest) = just (ParseTree (parsed-strlit-bar-7 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P18-} ((Id "P18") :: _::_(InputChar '.') rest) = just (ParseTree (parsed-strlit-bar-8 (string-append 0 (char-to-string '.'))) ::' rest , 2)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(ParseTree (parsed-strlit-bar-7 x0)) rest) = just (ParseTree (parsed-strlit-bar-8 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(InputChar ',') rest) = just (ParseTree (parsed-strlit-bar-9 (string-append 0 (char-to-string ','))) ::' rest , 2)
len-dec-rewrite {- P21-} ((Id "P21") :: _::_(ParseTree (parsed-strlit-bar-8 x0)) rest) = just (ParseTree (parsed-strlit-bar-9 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P22-} ((Id "P22") :: _::_(ParseTree (parsed-namechar x0)) rest) = just (ParseTree (parsed-strlit-bar-10 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(ParseTree (parsed-strlit-bar-9 x0)) rest) = just (ParseTree (parsed-strlit-bar-10 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: (ParseTree (parsed-strlit-bar-10 x0)) :: _::_(ParseTree (parsed-strlit-star-11 x1)) rest) = just (ParseTree (parsed-strlit-star-11 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P26-} ((Id "P26") :: (InputChar '\"') :: (ParseTree (parsed-strlit-star-11 x0)) :: _::_(InputChar '\"') rest) = just (ParseTree (parsed-strlit (string-append 2 (char-to-string '\"') x0 (char-to-string '\"'))) ::' rest , 4)
len-dec-rewrite {- P27-} ((Id "P27") :: _::_(InputChar '-') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '-'))) ::' rest , 2)
len-dec-rewrite {- P28-} ((Id "P28") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P3-} ((Id "P3") :: _::_(ParseTree parsed-aws-bar-1) rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P30-} ((Id "P30") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P31-} ((Id "P31") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P32-} ((Id "P32") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P33-} ((Id "P33") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P34-} ((Id "P34") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P35-} ((Id "P35") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P36-} ((Id "P36") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P37-} ((Id "P37") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P38-} ((Id "P38") :: _::_(InputChar 'A') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'A'))) ::' rest , 2)
len-dec-rewrite {- P39-} ((Id "P39") :: _::_(InputChar 'B') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'B'))) ::' rest , 2)
len-dec-rewrite {- P4-} ((Id "P4") :: _::_(ParseTree parsed-aws-bar-2) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P40-} ((Id "P40") :: _::_(InputChar 'C') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'C'))) ::' rest , 2)
len-dec-rewrite {- P41-} ((Id "P41") :: _::_(InputChar 'D') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'D'))) ::' rest , 2)
len-dec-rewrite {- P42-} ((Id "P42") :: _::_(InputChar 'E') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'E'))) ::' rest , 2)
len-dec-rewrite {- P43-} ((Id "P43") :: _::_(InputChar 'F') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'F'))) ::' rest , 2)
len-dec-rewrite {- P44-} ((Id "P44") :: _::_(InputChar 'G') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'G'))) ::' rest , 2)
len-dec-rewrite {- P45-} ((Id "P45") :: _::_(InputChar 'H') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'H'))) ::' rest , 2)
len-dec-rewrite {- P46-} ((Id "P46") :: _::_(InputChar 'I') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'I'))) ::' rest , 2)
len-dec-rewrite {- P47-} ((Id "P47") :: _::_(InputChar 'J') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'J'))) ::' rest , 2)
len-dec-rewrite {- P48-} ((Id "P48") :: _::_(InputChar 'K') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'K'))) ::' rest , 2)
len-dec-rewrite {- P49-} ((Id "P49") :: _::_(InputChar 'L') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'L'))) ::' rest , 2)
len-dec-rewrite {- P5-} ((Id "P5") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 2)
len-dec-rewrite {- P50-} ((Id "P50") :: _::_(InputChar 'M') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'M'))) ::' rest , 2)
len-dec-rewrite {- P51-} ((Id "P51") :: _::_(InputChar 'N') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'N'))) ::' rest , 2)
len-dec-rewrite {- P52-} ((Id "P52") :: _::_(InputChar 'O') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'O'))) ::' rest , 2)
len-dec-rewrite {- P53-} ((Id "P53") :: _::_(InputChar 'P') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'P'))) ::' rest , 2)
len-dec-rewrite {- P54-} ((Id "P54") :: _::_(InputChar 'Q') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'Q'))) ::' rest , 2)
len-dec-rewrite {- P55-} ((Id "P55") :: _::_(InputChar 'R') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'R'))) ::' rest , 2)
len-dec-rewrite {- P56-} ((Id "P56") :: _::_(InputChar 'S') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'S'))) ::' rest , 2)
len-dec-rewrite {- P57-} ((Id "P57") :: _::_(InputChar 'T') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'T'))) ::' rest , 2)
len-dec-rewrite {- P58-} ((Id "P58") :: _::_(InputChar 'U') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'U'))) ::' rest , 2)
len-dec-rewrite {- P59-} ((Id "P59") :: _::_(InputChar 'V') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'V'))) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 3)
len-dec-rewrite {- P60-} ((Id "P60") :: _::_(InputChar 'W') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'W'))) ::' rest , 2)
len-dec-rewrite {- P61-} ((Id "P61") :: _::_(InputChar 'X') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'X'))) ::' rest , 2)
len-dec-rewrite {- P62-} ((Id "P62") :: _::_(InputChar 'Y') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'Y'))) ::' rest , 2)
len-dec-rewrite {- P63-} ((Id "P63") :: _::_(InputChar 'Z') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'Z'))) ::' rest , 2)
len-dec-rewrite {- P64-} ((Id "P64") :: _::_(InputChar 'a') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'a'))) ::' rest , 2)
len-dec-rewrite {- P65-} ((Id "P65") :: _::_(InputChar 'b') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'b'))) ::' rest , 2)
len-dec-rewrite {- P66-} ((Id "P66") :: _::_(InputChar 'c') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'c'))) ::' rest , 2)
len-dec-rewrite {- P67-} ((Id "P67") :: _::_(InputChar 'd') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'd'))) ::' rest , 2)
len-dec-rewrite {- P68-} ((Id "P68") :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'e'))) ::' rest , 2)
len-dec-rewrite {- P69-} ((Id "P69") :: _::_(InputChar 'f') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'f'))) ::' rest , 2)
len-dec-rewrite {- P7-} ((Id "P7") :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P70-} ((Id "P70") :: _::_(InputChar 'g') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'g'))) ::' rest , 2)
len-dec-rewrite {- P71-} ((Id "P71") :: _::_(InputChar 'h') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'h'))) ::' rest , 2)
len-dec-rewrite {- P72-} ((Id "P72") :: _::_(InputChar 'i') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'i'))) ::' rest , 2)
len-dec-rewrite {- P73-} ((Id "P73") :: _::_(InputChar 'j') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'j'))) ::' rest , 2)
len-dec-rewrite {- P74-} ((Id "P74") :: _::_(InputChar 'k') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'k'))) ::' rest , 2)
len-dec-rewrite {- P75-} ((Id "P75") :: _::_(InputChar 'l') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'l'))) ::' rest , 2)
len-dec-rewrite {- P76-} ((Id "P76") :: _::_(InputChar 'm') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'm'))) ::' rest , 2)
len-dec-rewrite {- P77-} ((Id "P77") :: _::_(InputChar 'n') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'n'))) ::' rest , 2)
len-dec-rewrite {- P78-} ((Id "P78") :: _::_(InputChar 'o') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'o'))) ::' rest , 2)
len-dec-rewrite {- P79-} ((Id "P79") :: _::_(InputChar 'p') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'p'))) ::' rest , 2)
len-dec-rewrite {- P80-} ((Id "P80") :: _::_(InputChar 'q') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'q'))) ::' rest , 2)
len-dec-rewrite {- P81-} ((Id "P81") :: _::_(InputChar 'r') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'r'))) ::' rest , 2)
len-dec-rewrite {- P82-} ((Id "P82") :: _::_(InputChar 's') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 's'))) ::' rest , 2)
len-dec-rewrite {- P83-} ((Id "P83") :: _::_(InputChar 't') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 't'))) ::' rest , 2)
len-dec-rewrite {- P84-} ((Id "P84") :: _::_(InputChar 'u') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'u'))) ::' rest , 2)
len-dec-rewrite {- P85-} ((Id "P85") :: _::_(InputChar 'v') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'v'))) ::' rest , 2)
len-dec-rewrite {- P86-} ((Id "P86") :: _::_(InputChar 'w') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'w'))) ::' rest , 2)
len-dec-rewrite {- P87-} ((Id "P87") :: _::_(InputChar 'x') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'x'))) ::' rest , 2)
len-dec-rewrite {- P88-} ((Id "P88") :: _::_(InputChar 'y') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'y'))) ::' rest , 2)
len-dec-rewrite {- P89-} ((Id "P89") :: _::_(InputChar 'z') rest) = just (ParseTree (parsed-namechar-range-12 (string-append 0 (char-to-string 'z'))) ::' rest , 2)
len-dec-rewrite {- P9-} ((Id "P9") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows-star-4 ::' rest , 3)
len-dec-rewrite {- P90-} ((Id "P90") :: _::_(ParseTree (parsed-namechar-range-12 x0)) rest) = just (ParseTree (parsed-namechar (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- Seq-} ((ParseTree (parsed-xml x0)) :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-xml x1)) rest) = just (ParseTree (parsed-xml (norm-xml (Seq x0 x1))) ::' rest , 3)
len-dec-rewrite {- StartEnd-} ((Id "StartEnd") :: _::_(ParseTree (parsed-startendtag x0)) rest) = just (ParseTree (parsed-xml (norm-xml (StartEnd x0))) ::' rest , 2)
len-dec-rewrite {- StartTag-} ((Id "StartTag") :: (ParseTree (parsed-posinfo x0)) :: (InputChar '<') :: (ParseTree (parsed-id x1)) :: (ParseTree (parsed-attrs x2)) :: (InputChar '>') :: _::_(ParseTree (parsed-posinfo x3)) rest) = just (ParseTree (parsed-starttag (norm-starttag (StartTag x0 x1 x2 x3))) ::' rest , 7)
len-dec-rewrite {- Startendtag-} ((Id "Startendtag") :: (ParseTree (parsed-posinfo x0)) :: (InputChar '<') :: (ParseTree (parsed-id x1)) :: (ParseTree (parsed-attrs x2)) :: (InputChar '/') :: (InputChar '>') :: _::_(ParseTree (parsed-posinfo x3)) rest) = just (ParseTree (parsed-startendtag (norm-startendtag (Startendtag x0 x1 x2 x3))) ::' rest , 8)
len-dec-rewrite {- Strt-} ((Id "Strt") :: (ParseTree parsed-ows) :: (ParseTree (parsed-xml x0)) :: (ParseTree parsed-ows) :: _::_(Id "Strt_end") rest) = just (ParseTree (parsed-start (norm-start (Strt x0))) ::' rest , 5)
len-dec-rewrite {- AttrsNil-} (_::_(Id "AttrsNil") rest) = just (ParseTree (parsed-attrs (norm-attrs AttrsNil)) ::' rest , 1)
len-dec-rewrite {- P24-} (_::_(Id "P24") rest) = just (ParseTree (parsed-strlit-star-11 empty-string) ::' rest , 1)
len-dec-rewrite {- P8-} (_::_(Id "P8") rest) = just (ParseTree parsed-ows-star-4 ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
