module plustimes where

open import lib

open import plustimes-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _ws-plus-3 : gratr2-nt
  _ws : gratr2-nt
  _strt : gratr2-nt
  _posinfo : gratr2-nt
  _posDig-range-7 : gratr2-nt
  _posDig : gratr2-nt
  _ows-star-4 : gratr2-nt
  _ows : gratr2-nt
  _numSecondPart-bar-9 : gratr2-nt
  _numSecondPart : gratr2-nt
  _numFirstPart-bar-8 : gratr2-nt
  _numFirstPart : gratr2-nt
  _num-opt-10 : gratr2-nt
  _num : gratr2-nt
  _id-range-11 : gratr2-nt
  _id-plus-12 : gratr2-nt
  _id : gratr2-nt
  _expr : gratr2-nt
  _aws-bar-2 : gratr2-nt
  _aws-bar-1 : gratr2-nt
  _aws : gratr2-nt
  _anyDigs-star-6 : gratr2-nt
  _anyDigs-range-5 : gratr2-nt
  _anyDigs : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _ws-plus-3 _ws-plus-3 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _strt _strt = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _posDig-range-7 _posDig-range-7 = tt
gratr2-nt-eq  _posDig _posDig = tt
gratr2-nt-eq  _ows-star-4 _ows-star-4 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _numSecondPart-bar-9 _numSecondPart-bar-9 = tt
gratr2-nt-eq  _numSecondPart _numSecondPart = tt
gratr2-nt-eq  _numFirstPart-bar-8 _numFirstPart-bar-8 = tt
gratr2-nt-eq  _numFirstPart _numFirstPart = tt
gratr2-nt-eq  _num-opt-10 _num-opt-10 = tt
gratr2-nt-eq  _num _num = tt
gratr2-nt-eq  _id-range-11 _id-range-11 = tt
gratr2-nt-eq  _id-plus-12 _id-plus-12 = tt
gratr2-nt-eq  _id _id = tt
gratr2-nt-eq  _expr _expr = tt
gratr2-nt-eq  _aws-bar-2 _aws-bar-2 = tt
gratr2-nt-eq  _aws-bar-1 _aws-bar-1 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq  _anyDigs-star-6 _anyDigs-star-6 = tt
gratr2-nt-eq  _anyDigs-range-5 _anyDigs-range-5 = tt
gratr2-nt-eq  _anyDigs _anyDigs = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


plustimes-start : gratr2-nt → 𝕃 gratr2-rule
plustimes-start _ws-plus-3 = (just "P6" , nothing , just _ws-plus-3 , inj₁ _aws :: inj₁ _ws-plus-3 :: []) :: (just "P5" , nothing , just _ws-plus-3 , inj₁ _aws :: []) :: []
plustimes-start _ws = (just "P7" , nothing , just _ws , inj₁ _ws-plus-3 :: []) :: []
plustimes-start _strt = (just "Strt" , just "Strt_end" , just _strt , inj₁ _ows :: inj₁ _expr :: inj₁ _ows :: []) :: []
plustimes-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
plustimes-start _posDig-range-7 = (just "P32" , nothing , just _posDig-range-7 , inj₂ '9' :: []) :: (just "P31" , nothing , just _posDig-range-7 , inj₂ '8' :: []) :: (just "P30" , nothing , just _posDig-range-7 , inj₂ '7' :: []) :: (just "P29" , nothing , just _posDig-range-7 , inj₂ '6' :: []) :: (just "P28" , nothing , just _posDig-range-7 , inj₂ '5' :: []) :: (just "P27" , nothing , just _posDig-range-7 , inj₂ '4' :: []) :: (just "P26" , nothing , just _posDig-range-7 , inj₂ '3' :: []) :: (just "P25" , nothing , just _posDig-range-7 , inj₂ '2' :: []) :: (just "P24" , nothing , just _posDig-range-7 , inj₂ '1' :: []) :: []
plustimes-start _posDig = (just "P33" , nothing , just _posDig , inj₁ _posDig-range-7 :: []) :: []
plustimes-start _ows-star-4 = (just "P9" , nothing , just _ows-star-4 , inj₁ _aws :: inj₁ _ows-star-4 :: []) :: (just "P8" , nothing , just _ows-star-4 , []) :: []
plustimes-start _ows = (just "P10" , nothing , just _ows , inj₁ _ows-star-4 :: []) :: []
plustimes-start _numSecondPart-bar-9 = (just "P38" , nothing , just _numSecondPart-bar-9 , inj₂ '0' :: []) :: (just "P37" , nothing , just _numSecondPart-bar-9 , inj₁ _anyDigs :: inj₁ _posDig :: []) :: []
plustimes-start _numSecondPart = (just "P39" , nothing , just _numSecondPart , inj₂ '.' :: inj₁ _numSecondPart-bar-9 :: []) :: []
plustimes-start _numFirstPart-bar-8 = (just "P35" , nothing , just _numFirstPart-bar-8 , inj₂ '0' :: []) :: (just "P34" , nothing , just _numFirstPart-bar-8 , inj₁ _posDig :: inj₁ _anyDigs :: []) :: []
plustimes-start _numFirstPart = (just "P36" , nothing , just _numFirstPart , inj₁ _numFirstPart-bar-8 :: []) :: []
plustimes-start _num-opt-10 = (just "P41" , nothing , just _num-opt-10 , []) :: (just "P40" , nothing , just _num-opt-10 , inj₁ _numSecondPart :: []) :: []
plustimes-start _num = (just "P42" , nothing , just _num , inj₁ _numFirstPart :: inj₁ _num-opt-10 :: []) :: []
plustimes-start _id-range-11 = (just "P68" , nothing , just _id-range-11 , inj₂ 'z' :: []) :: (just "P67" , nothing , just _id-range-11 , inj₂ 'y' :: []) :: (just "P66" , nothing , just _id-range-11 , inj₂ 'x' :: []) :: (just "P65" , nothing , just _id-range-11 , inj₂ 'w' :: []) :: (just "P64" , nothing , just _id-range-11 , inj₂ 'v' :: []) :: (just "P63" , nothing , just _id-range-11 , inj₂ 'u' :: []) :: (just "P62" , nothing , just _id-range-11 , inj₂ 't' :: []) :: (just "P61" , nothing , just _id-range-11 , inj₂ 's' :: []) :: (just "P60" , nothing , just _id-range-11 , inj₂ 'r' :: []) :: (just "P59" , nothing , just _id-range-11 , inj₂ 'q' :: []) :: (just "P58" , nothing , just _id-range-11 , inj₂ 'p' :: []) :: (just "P57" , nothing , just _id-range-11 , inj₂ 'o' :: []) :: (just "P56" , nothing , just _id-range-11 , inj₂ 'n' :: []) :: (just "P55" , nothing , just _id-range-11 , inj₂ 'm' :: []) :: (just "P54" , nothing , just _id-range-11 , inj₂ 'l' :: []) :: (just "P53" , nothing , just _id-range-11 , inj₂ 'k' :: []) :: (just "P52" , nothing , just _id-range-11 , inj₂ 'j' :: []) :: (just "P51" , nothing , just _id-range-11 , inj₂ 'i' :: []) :: (just "P50" , nothing , just _id-range-11 , inj₂ 'h' :: []) :: (just "P49" , nothing , just _id-range-11 , inj₂ 'g' :: []) :: (just "P48" , nothing , just _id-range-11 , inj₂ 'f' :: []) :: (just "P47" , nothing , just _id-range-11 , inj₂ 'e' :: []) :: (just "P46" , nothing , just _id-range-11 , inj₂ 'd' :: []) :: (just "P45" , nothing , just _id-range-11 , inj₂ 'c' :: []) :: (just "P44" , nothing , just _id-range-11 , inj₂ 'b' :: []) :: (just "P43" , nothing , just _id-range-11 , inj₂ 'a' :: []) :: []
plustimes-start _id-plus-12 = (just "P70" , nothing , just _id-plus-12 , inj₁ _id-range-11 :: inj₁ _id-plus-12 :: []) :: (just "P69" , nothing , just _id-plus-12 , inj₁ _id-range-11 :: []) :: []
plustimes-start _id = (just "P71" , nothing , just _id , inj₁ _id-plus-12 :: []) :: []
plustimes-start _expr = (just "Parens" , nothing , just _expr , inj₂ '(' :: inj₁ _ows :: inj₁ _expr :: inj₁ _ows :: inj₂ ')' :: []) :: (just "Num" , nothing , just _expr , inj₁ _num :: []) :: (just "Id" , nothing , just _expr , inj₁ _id :: []) :: []
plustimes-start _aws-bar-2 = (just "P3" , nothing , just _aws-bar-2 , inj₁ _aws-bar-1 :: []) :: (just "P2" , nothing , just _aws-bar-2 , inj₂ '\n' :: []) :: []
plustimes-start _aws-bar-1 = (just "P1" , nothing , just _aws-bar-1 , inj₂ ' ' :: []) :: (just "P0" , nothing , just _aws-bar-1 , inj₂ '\t' :: []) :: []
plustimes-start _aws = (just "P4" , nothing , just _aws , inj₁ _aws-bar-2 :: []) :: []
plustimes-start _anyDigs-star-6 = (just "P22" , nothing , just _anyDigs-star-6 , inj₁ _anyDigs-range-5 :: inj₁ _anyDigs-star-6 :: []) :: (just "P21" , nothing , just _anyDigs-star-6 , []) :: []
plustimes-start _anyDigs-range-5 = (just "P20" , nothing , just _anyDigs-range-5 , inj₂ '9' :: []) :: (just "P19" , nothing , just _anyDigs-range-5 , inj₂ '8' :: []) :: (just "P18" , nothing , just _anyDigs-range-5 , inj₂ '7' :: []) :: (just "P17" , nothing , just _anyDigs-range-5 , inj₂ '6' :: []) :: (just "P16" , nothing , just _anyDigs-range-5 , inj₂ '5' :: []) :: (just "P15" , nothing , just _anyDigs-range-5 , inj₂ '4' :: []) :: (just "P14" , nothing , just _anyDigs-range-5 , inj₂ '3' :: []) :: (just "P13" , nothing , just _anyDigs-range-5 , inj₂ '2' :: []) :: (just "P12" , nothing , just _anyDigs-range-5 , inj₂ '1' :: []) :: (just "P11" , nothing , just _anyDigs-range-5 , inj₂ '0' :: []) :: []
plustimes-start _anyDigs = (just "P23" , nothing , just _anyDigs , inj₁ _anyDigs-star-6 :: []) :: []


plustimes-return : maybe gratr2-nt → 𝕃 gratr2-rule
plustimes-return (just _expr) = (nothing , nothing , just _expr , inj₁ _ows :: inj₂ '*' :: inj₁ _ows :: inj₁ _expr :: []) :: (nothing , nothing , just _expr , inj₁ _ows :: inj₂ '+' :: inj₁ _ows :: inj₁ _expr :: []) :: []
plustimes-return _ = []

plustimes-rtn : gratr2-rtn
plustimes-rtn = record { start = _strt ; _eq_ = gratr2-nt-eq ; gratr2-start = plustimes-start ; gratr2-return = plustimes-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- Id-} ((Id "Id") :: _::_(ParseTree (parsed-id x0)) rest) = just (ParseTree (parsed-expr (norm-expr (Id x0))) ::' rest , 2)
len-dec-rewrite {- Num-} ((Id "Num") :: _::_(ParseTree (parsed-num x0)) rest) = just (ParseTree (parsed-expr (norm-expr (Num x0))) ::' rest , 2)
len-dec-rewrite {- P0-} ((Id "P0") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P1-} ((Id "P1") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P10-} ((Id "P10") :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P11-} ((Id "P11") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P12-} ((Id "P12") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P13-} ((Id "P13") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P14-} ((Id "P14") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P15-} ((Id "P15") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P16-} ((Id "P16") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P17-} ((Id "P17") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P18-} ((Id "P18") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-anyDigs-range-5 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P22-} ((Id "P22") :: (ParseTree (parsed-anyDigs-range-5 x0)) :: _::_(ParseTree (parsed-anyDigs-star-6 x1)) rest) = just (ParseTree (parsed-anyDigs-star-6 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(ParseTree (parsed-anyDigs-star-6 x0)) rest) = just (ParseTree (parsed-anyDigs (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P24-} ((Id "P24") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P26-} ((Id "P26") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P27-} ((Id "P27") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P28-} ((Id "P28") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P3-} ((Id "P3") :: _::_(ParseTree parsed-aws-bar-1) rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P30-} ((Id "P30") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P31-} ((Id "P31") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P32-} ((Id "P32") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-posDig-range-7 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P33-} ((Id "P33") :: _::_(ParseTree (parsed-posDig-range-7 x0)) rest) = just (ParseTree (parsed-posDig (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P34-} ((Id "P34") :: (ParseTree (parsed-posDig x0)) :: _::_(ParseTree (parsed-anyDigs x1)) rest) = just (ParseTree (parsed-numFirstPart-bar-8 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P35-} ((Id "P35") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-numFirstPart-bar-8 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P36-} ((Id "P36") :: _::_(ParseTree (parsed-numFirstPart-bar-8 x0)) rest) = just (ParseTree (parsed-numFirstPart (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P37-} ((Id "P37") :: (ParseTree (parsed-anyDigs x0)) :: _::_(ParseTree (parsed-posDig x1)) rest) = just (ParseTree (parsed-numSecondPart-bar-9 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P38-} ((Id "P38") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-numSecondPart-bar-9 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P39-} ((Id "P39") :: (InputChar '.') :: _::_(ParseTree (parsed-numSecondPart-bar-9 x0)) rest) = just (ParseTree (parsed-numSecondPart (string-append 1 (char-to-string '.') x0)) ::' rest , 3)
len-dec-rewrite {- P4-} ((Id "P4") :: _::_(ParseTree parsed-aws-bar-2) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P40-} ((Id "P40") :: _::_(ParseTree (parsed-numSecondPart x0)) rest) = just (ParseTree (parsed-num-opt-10 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P42-} ((Id "P42") :: (ParseTree (parsed-numFirstPart x0)) :: _::_(ParseTree (parsed-num-opt-10 x1)) rest) = just (ParseTree (parsed-num (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P43-} ((Id "P43") :: _::_(InputChar 'a') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'a'))) ::' rest , 2)
len-dec-rewrite {- P44-} ((Id "P44") :: _::_(InputChar 'b') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'b'))) ::' rest , 2)
len-dec-rewrite {- P45-} ((Id "P45") :: _::_(InputChar 'c') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'c'))) ::' rest , 2)
len-dec-rewrite {- P46-} ((Id "P46") :: _::_(InputChar 'd') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'd'))) ::' rest , 2)
len-dec-rewrite {- P47-} ((Id "P47") :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'e'))) ::' rest , 2)
len-dec-rewrite {- P48-} ((Id "P48") :: _::_(InputChar 'f') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'f'))) ::' rest , 2)
len-dec-rewrite {- P49-} ((Id "P49") :: _::_(InputChar 'g') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'g'))) ::' rest , 2)
len-dec-rewrite {- P5-} ((Id "P5") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 2)
len-dec-rewrite {- P50-} ((Id "P50") :: _::_(InputChar 'h') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'h'))) ::' rest , 2)
len-dec-rewrite {- P51-} ((Id "P51") :: _::_(InputChar 'i') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'i'))) ::' rest , 2)
len-dec-rewrite {- P52-} ((Id "P52") :: _::_(InputChar 'j') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'j'))) ::' rest , 2)
len-dec-rewrite {- P53-} ((Id "P53") :: _::_(InputChar 'k') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'k'))) ::' rest , 2)
len-dec-rewrite {- P54-} ((Id "P54") :: _::_(InputChar 'l') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'l'))) ::' rest , 2)
len-dec-rewrite {- P55-} ((Id "P55") :: _::_(InputChar 'm') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'm'))) ::' rest , 2)
len-dec-rewrite {- P56-} ((Id "P56") :: _::_(InputChar 'n') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'n'))) ::' rest , 2)
len-dec-rewrite {- P57-} ((Id "P57") :: _::_(InputChar 'o') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'o'))) ::' rest , 2)
len-dec-rewrite {- P58-} ((Id "P58") :: _::_(InputChar 'p') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'p'))) ::' rest , 2)
len-dec-rewrite {- P59-} ((Id "P59") :: _::_(InputChar 'q') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'q'))) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 3)
len-dec-rewrite {- P60-} ((Id "P60") :: _::_(InputChar 'r') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'r'))) ::' rest , 2)
len-dec-rewrite {- P61-} ((Id "P61") :: _::_(InputChar 's') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 's'))) ::' rest , 2)
len-dec-rewrite {- P62-} ((Id "P62") :: _::_(InputChar 't') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 't'))) ::' rest , 2)
len-dec-rewrite {- P63-} ((Id "P63") :: _::_(InputChar 'u') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'u'))) ::' rest , 2)
len-dec-rewrite {- P64-} ((Id "P64") :: _::_(InputChar 'v') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'v'))) ::' rest , 2)
len-dec-rewrite {- P65-} ((Id "P65") :: _::_(InputChar 'w') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'w'))) ::' rest , 2)
len-dec-rewrite {- P66-} ((Id "P66") :: _::_(InputChar 'x') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'x'))) ::' rest , 2)
len-dec-rewrite {- P67-} ((Id "P67") :: _::_(InputChar 'y') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'y'))) ::' rest , 2)
len-dec-rewrite {- P68-} ((Id "P68") :: _::_(InputChar 'z') rest) = just (ParseTree (parsed-id-range-11 (string-append 0 (char-to-string 'z'))) ::' rest , 2)
len-dec-rewrite {- P69-} ((Id "P69") :: _::_(ParseTree (parsed-id-range-11 x0)) rest) = just (ParseTree (parsed-id-plus-12 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P7-} ((Id "P7") :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P70-} ((Id "P70") :: (ParseTree (parsed-id-range-11 x0)) :: _::_(ParseTree (parsed-id-plus-12 x1)) rest) = just (ParseTree (parsed-id-plus-12 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P71-} ((Id "P71") :: _::_(ParseTree (parsed-id-plus-12 x0)) rest) = just (ParseTree (parsed-id (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P9-} ((Id "P9") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows-star-4 ::' rest , 3)
len-dec-rewrite {- Parens-} ((Id "Parens") :: (InputChar '(') :: (ParseTree parsed-ows) :: (ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-expr (norm-expr (Parens x0))) ::' rest , 6)
len-dec-rewrite {- Plus-} ((ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: (InputChar '+') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-expr x1)) rest) = just (ParseTree (parsed-expr (norm-expr (Plus x0 x1))) ::' rest , 5)
len-dec-rewrite {- Strt-} ((Id "Strt") :: (ParseTree parsed-ows) :: (ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: _::_(Id "Strt_end") rest) = just (ParseTree (parsed-strt (norm-strt (Strt x0))) ::' rest , 5)
len-dec-rewrite {- Times-} ((ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: (InputChar '*') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-expr x1)) rest) = just (ParseTree (parsed-expr (norm-expr (Times x0 x1))) ::' rest , 5)
len-dec-rewrite {- P21-} (_::_(Id "P21") rest) = just (ParseTree (parsed-anyDigs-star-6 empty-string) ::' rest , 1)
len-dec-rewrite {- P41-} (_::_(Id "P41") rest) = just (ParseTree (parsed-num-opt-10 empty-string) ::' rest , 1)
len-dec-rewrite {- P8-} (_::_(Id "P8") rest) = just (ParseTree parsed-ows-star-4 ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
