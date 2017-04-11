module lettuce where

open import lib

open import lettuce-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _ws-plus-3 : gratr2-nt
  _ws : gratr2-nt
  _var-range-7 : gratr2-nt
  _var-plus-8 : gratr2-nt
  _var : gratr2-nt
  _term : gratr2-nt
  _start : gratr2-nt
  _posinfo : gratr2-nt
  _ows-star-4 : gratr2-nt
  _ows : gratr2-nt
  _num-range-5 : gratr2-nt
  _num-plus-6 : gratr2-nt
  _num : gratr2-nt
  _letterm : gratr2-nt
  _globals : gratr2-nt
  _global : gratr2-nt
  _aws-bar-2 : gratr2-nt
  _aws-bar-1 : gratr2-nt
  _aws : gratr2-nt
  _atom : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _ws-plus-3 _ws-plus-3 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _var-range-7 _var-range-7 = tt
gratr2-nt-eq  _var-plus-8 _var-plus-8 = tt
gratr2-nt-eq  _var _var = tt
gratr2-nt-eq  _term _term = tt
gratr2-nt-eq  _start _start = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _ows-star-4 _ows-star-4 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _num-range-5 _num-range-5 = tt
gratr2-nt-eq  _num-plus-6 _num-plus-6 = tt
gratr2-nt-eq  _num _num = tt
gratr2-nt-eq  _letterm _letterm = tt
gratr2-nt-eq  _globals _globals = tt
gratr2-nt-eq  _global _global = tt
gratr2-nt-eq  _aws-bar-2 _aws-bar-2 = tt
gratr2-nt-eq  _aws-bar-1 _aws-bar-1 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq  _atom _atom = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


lettuce-start : gratr2-nt → 𝕃 gratr2-rule
lettuce-start _ws-plus-3 = (just "P6" , nothing , just _ws-plus-3 , inj₁ _aws :: inj₁ _ws-plus-3 :: []) :: (just "P5" , nothing , just _ws-plus-3 , inj₁ _aws :: []) :: []
lettuce-start _ws = (just "P7" , nothing , just _ws , inj₁ _ws-plus-3 :: []) :: []
lettuce-start _var-range-7 = (just "P49" , nothing , just _var-range-7 , inj₂ 'z' :: []) :: (just "P48" , nothing , just _var-range-7 , inj₂ 'y' :: []) :: (just "P47" , nothing , just _var-range-7 , inj₂ 'x' :: []) :: (just "P46" , nothing , just _var-range-7 , inj₂ 'w' :: []) :: (just "P45" , nothing , just _var-range-7 , inj₂ 'v' :: []) :: (just "P44" , nothing , just _var-range-7 , inj₂ 'u' :: []) :: (just "P43" , nothing , just _var-range-7 , inj₂ 't' :: []) :: (just "P42" , nothing , just _var-range-7 , inj₂ 's' :: []) :: (just "P41" , nothing , just _var-range-7 , inj₂ 'r' :: []) :: (just "P40" , nothing , just _var-range-7 , inj₂ 'q' :: []) :: (just "P39" , nothing , just _var-range-7 , inj₂ 'p' :: []) :: (just "P38" , nothing , just _var-range-7 , inj₂ 'o' :: []) :: (just "P37" , nothing , just _var-range-7 , inj₂ 'n' :: []) :: (just "P36" , nothing , just _var-range-7 , inj₂ 'm' :: []) :: (just "P35" , nothing , just _var-range-7 , inj₂ 'l' :: []) :: (just "P34" , nothing , just _var-range-7 , inj₂ 'k' :: []) :: (just "P33" , nothing , just _var-range-7 , inj₂ 'j' :: []) :: (just "P32" , nothing , just _var-range-7 , inj₂ 'i' :: []) :: (just "P31" , nothing , just _var-range-7 , inj₂ 'h' :: []) :: (just "P30" , nothing , just _var-range-7 , inj₂ 'g' :: []) :: (just "P29" , nothing , just _var-range-7 , inj₂ 'f' :: []) :: (just "P28" , nothing , just _var-range-7 , inj₂ 'e' :: []) :: (just "P27" , nothing , just _var-range-7 , inj₂ 'd' :: []) :: (just "P26" , nothing , just _var-range-7 , inj₂ 'c' :: []) :: (just "P25" , nothing , just _var-range-7 , inj₂ 'b' :: []) :: (just "P24" , nothing , just _var-range-7 , inj₂ 'a' :: []) :: []
lettuce-start _var-plus-8 = (just "P51" , nothing , just _var-plus-8 , inj₁ _var-range-7 :: inj₁ _var-plus-8 :: []) :: (just "P50" , nothing , just _var-plus-8 , inj₁ _var-range-7 :: []) :: []
lettuce-start _var = (just "P52" , nothing , just _var , inj₁ _var-plus-8 :: []) :: []
lettuce-start _term = (just "embed" , nothing , just _term , inj₁ _atom :: []) :: (just "Plus" , nothing , just _term , inj₁ _atom :: inj₁ _ows :: inj₂ '+' :: inj₁ _ows :: inj₁ _term :: []) :: []
lettuce-start _start = (just "InputTerm" , nothing , just _start , inj₁ _ows :: inj₁ _globals :: inj₁ _letterm :: inj₁ _ows :: []) :: []
lettuce-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
lettuce-start _ows-star-4 = (just "P9" , nothing , just _ows-star-4 , inj₁ _aws :: inj₁ _ows-star-4 :: []) :: (just "P8" , nothing , just _ows-star-4 , []) :: []
lettuce-start _ows = (just "P10" , nothing , just _ows , inj₁ _ows-star-4 :: []) :: []
lettuce-start _num-range-5 = (just "P20" , nothing , just _num-range-5 , inj₂ '9' :: []) :: (just "P19" , nothing , just _num-range-5 , inj₂ '8' :: []) :: (just "P18" , nothing , just _num-range-5 , inj₂ '7' :: []) :: (just "P17" , nothing , just _num-range-5 , inj₂ '6' :: []) :: (just "P16" , nothing , just _num-range-5 , inj₂ '5' :: []) :: (just "P15" , nothing , just _num-range-5 , inj₂ '4' :: []) :: (just "P14" , nothing , just _num-range-5 , inj₂ '3' :: []) :: (just "P13" , nothing , just _num-range-5 , inj₂ '2' :: []) :: (just "P12" , nothing , just _num-range-5 , inj₂ '1' :: []) :: (just "P11" , nothing , just _num-range-5 , inj₂ '0' :: []) :: []
lettuce-start _num-plus-6 = (just "P22" , nothing , just _num-plus-6 , inj₁ _num-range-5 :: inj₁ _num-plus-6 :: []) :: (just "P21" , nothing , just _num-plus-6 , inj₁ _num-range-5 :: []) :: []
lettuce-start _num = (just "P23" , nothing , just _num , inj₁ _num-plus-6 :: []) :: []
lettuce-start _letterm = (just "embed" , nothing , just _letterm , inj₁ _term :: []) :: (just "Let" , nothing , just _letterm , inj₂ 'l' :: inj₂ 'e' :: inj₂ 't' :: inj₁ _ws :: inj₁ _posinfo :: inj₁ _var :: inj₁ _ows :: inj₂ '=' :: inj₁ _ows :: inj₁ _term :: inj₁ _ws :: inj₂ 'i' :: inj₂ 'n' :: inj₁ _ws :: inj₁ _letterm :: []) :: []
lettuce-start _globals = (just "GlobalsNil" , nothing , just _globals , []) :: (just "GlobalsCons" , nothing , just _globals , inj₁ _global :: inj₁ _ws :: inj₁ _globals :: []) :: []
lettuce-start _global = (just "Global" , nothing , just _global , inj₁ _var :: inj₁ _ows :: inj₂ '=' :: inj₁ _ows :: inj₁ _num :: []) :: []
lettuce-start _aws-bar-2 = (just "P3" , nothing , just _aws-bar-2 , inj₁ _aws-bar-1 :: []) :: (just "P2" , nothing , just _aws-bar-2 , inj₂ '\n' :: []) :: []
lettuce-start _aws-bar-1 = (just "P1" , nothing , just _aws-bar-1 , inj₂ ' ' :: []) :: (just "P0" , nothing , just _aws-bar-1 , inj₂ '\t' :: []) :: []
lettuce-start _aws = (just "P4" , nothing , just _aws , inj₁ _aws-bar-2 :: []) :: []
lettuce-start _atom = (just "Var" , nothing , just _atom , inj₁ _posinfo :: inj₁ _var :: []) :: (just "Parens" , nothing , just _atom , inj₂ '(' :: inj₁ _ows :: inj₁ _letterm :: inj₁ _ows :: inj₂ ')' :: []) :: []


lettuce-return : maybe gratr2-nt → 𝕃 gratr2-rule
lettuce-return _ = []

lettuce-rtn : gratr2-rtn
lettuce-rtn = record { start = _start ; _eq_ = gratr2-nt-eq ; gratr2-start = lettuce-start ; gratr2-return = lettuce-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- Global-} ((Id "Global") :: (ParseTree (parsed-var x0)) :: (ParseTree parsed-ows) :: (InputChar '=') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-num x1)) rest) = just (ParseTree (parsed-global (norm-global (Global x0 x1))) ::' rest , 6)
len-dec-rewrite {- GlobalsCons-} ((Id "GlobalsCons") :: (ParseTree (parsed-global x0)) :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-globals x1)) rest) = just (ParseTree (parsed-globals (norm-globals (GlobalsCons x0 x1))) ::' rest , 4)
len-dec-rewrite {- InputTerm-} ((Id "InputTerm") :: (ParseTree parsed-ows) :: (ParseTree (parsed-globals x0)) :: (ParseTree (parsed-letterm x1)) :: _::_(ParseTree parsed-ows) rest) = just (ParseTree (parsed-start (norm-start (InputTerm x0 x1))) ::' rest , 5)
len-dec-rewrite {- Let-} ((Id "Let") :: (InputChar 'l') :: (InputChar 'e') :: (InputChar 't') :: (ParseTree parsed-ws) :: (ParseTree (parsed-posinfo x0)) :: (ParseTree (parsed-var x1)) :: (ParseTree parsed-ows) :: (InputChar '=') :: (ParseTree parsed-ows) :: (ParseTree (parsed-term x2)) :: (ParseTree parsed-ws) :: (InputChar 'i') :: (InputChar 'n') :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-letterm x3)) rest) = just (ParseTree (parsed-letterm (norm-letterm (Let x0 x1 x2 x3))) ::' rest , 16)
len-dec-rewrite {- P0-} ((Id "P0") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P1-} ((Id "P1") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-1 ::' rest , 2)
len-dec-rewrite {- P10-} ((Id "P10") :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P11-} ((Id "P11") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P12-} ((Id "P12") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P13-} ((Id "P13") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P14-} ((Id "P14") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P15-} ((Id "P15") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P16-} ((Id "P16") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P17-} ((Id "P17") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P18-} ((Id "P18") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-num-range-5 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P21-} ((Id "P21") :: _::_(ParseTree (parsed-num-range-5 x0)) rest) = just (ParseTree (parsed-num-plus-6 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P22-} ((Id "P22") :: (ParseTree (parsed-num-range-5 x0)) :: _::_(ParseTree (parsed-num-plus-6 x1)) rest) = just (ParseTree (parsed-num-plus-6 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(ParseTree (parsed-num-plus-6 x0)) rest) = just (ParseTree (parsed-num (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P24-} ((Id "P24") :: _::_(InputChar 'a') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'a'))) ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: _::_(InputChar 'b') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'b'))) ::' rest , 2)
len-dec-rewrite {- P26-} ((Id "P26") :: _::_(InputChar 'c') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'c'))) ::' rest , 2)
len-dec-rewrite {- P27-} ((Id "P27") :: _::_(InputChar 'd') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'd'))) ::' rest , 2)
len-dec-rewrite {- P28-} ((Id "P28") :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'e'))) ::' rest , 2)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(InputChar 'f') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'f'))) ::' rest , 2)
len-dec-rewrite {- P3-} ((Id "P3") :: _::_(ParseTree parsed-aws-bar-1) rest) = just (ParseTree parsed-aws-bar-2 ::' rest , 2)
len-dec-rewrite {- P30-} ((Id "P30") :: _::_(InputChar 'g') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'g'))) ::' rest , 2)
len-dec-rewrite {- P31-} ((Id "P31") :: _::_(InputChar 'h') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'h'))) ::' rest , 2)
len-dec-rewrite {- P32-} ((Id "P32") :: _::_(InputChar 'i') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'i'))) ::' rest , 2)
len-dec-rewrite {- P33-} ((Id "P33") :: _::_(InputChar 'j') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'j'))) ::' rest , 2)
len-dec-rewrite {- P34-} ((Id "P34") :: _::_(InputChar 'k') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'k'))) ::' rest , 2)
len-dec-rewrite {- P35-} ((Id "P35") :: _::_(InputChar 'l') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'l'))) ::' rest , 2)
len-dec-rewrite {- P36-} ((Id "P36") :: _::_(InputChar 'm') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'm'))) ::' rest , 2)
len-dec-rewrite {- P37-} ((Id "P37") :: _::_(InputChar 'n') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'n'))) ::' rest , 2)
len-dec-rewrite {- P38-} ((Id "P38") :: _::_(InputChar 'o') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'o'))) ::' rest , 2)
len-dec-rewrite {- P39-} ((Id "P39") :: _::_(InputChar 'p') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'p'))) ::' rest , 2)
len-dec-rewrite {- P4-} ((Id "P4") :: _::_(ParseTree parsed-aws-bar-2) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P40-} ((Id "P40") :: _::_(InputChar 'q') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'q'))) ::' rest , 2)
len-dec-rewrite {- P41-} ((Id "P41") :: _::_(InputChar 'r') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'r'))) ::' rest , 2)
len-dec-rewrite {- P42-} ((Id "P42") :: _::_(InputChar 's') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 's'))) ::' rest , 2)
len-dec-rewrite {- P43-} ((Id "P43") :: _::_(InputChar 't') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 't'))) ::' rest , 2)
len-dec-rewrite {- P44-} ((Id "P44") :: _::_(InputChar 'u') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'u'))) ::' rest , 2)
len-dec-rewrite {- P45-} ((Id "P45") :: _::_(InputChar 'v') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'v'))) ::' rest , 2)
len-dec-rewrite {- P46-} ((Id "P46") :: _::_(InputChar 'w') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'w'))) ::' rest , 2)
len-dec-rewrite {- P47-} ((Id "P47") :: _::_(InputChar 'x') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'x'))) ::' rest , 2)
len-dec-rewrite {- P48-} ((Id "P48") :: _::_(InputChar 'y') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'y'))) ::' rest , 2)
len-dec-rewrite {- P49-} ((Id "P49") :: _::_(InputChar 'z') rest) = just (ParseTree (parsed-var-range-7 (string-append 0 (char-to-string 'z'))) ::' rest , 2)
len-dec-rewrite {- P5-} ((Id "P5") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 2)
len-dec-rewrite {- P50-} ((Id "P50") :: _::_(ParseTree (parsed-var-range-7 x0)) rest) = just (ParseTree (parsed-var-plus-8 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P51-} ((Id "P51") :: (ParseTree (parsed-var-range-7 x0)) :: _::_(ParseTree (parsed-var-plus-8 x1)) rest) = just (ParseTree (parsed-var-plus-8 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P52-} ((Id "P52") :: _::_(ParseTree (parsed-var-plus-8 x0)) rest) = just (ParseTree (parsed-var (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws-plus-3 ::' rest , 3)
len-dec-rewrite {- P7-} ((Id "P7") :: _::_(ParseTree parsed-ws-plus-3) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P9-} ((Id "P9") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows-star-4 ::' rest , 3)
len-dec-rewrite {- Parens-} ((Id "Parens") :: (InputChar '(') :: (ParseTree parsed-ows) :: (ParseTree (parsed-letterm x0)) :: (ParseTree parsed-ows) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-atom (norm-letterm (Parens x0))) ::' rest , 6)
len-dec-rewrite {- Plus-} ((Id "Plus") :: (ParseTree (parsed-atom x0)) :: (ParseTree parsed-ows) :: (InputChar '+') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-term x1)) rest) = just (ParseTree (parsed-term (norm-letterm (Plus x0 x1))) ::' rest , 6)
len-dec-rewrite {- Var-} ((Id "Var") :: (ParseTree (parsed-posinfo x0)) :: _::_(ParseTree (parsed-var x1)) rest) = just (ParseTree (parsed-atom (norm-letterm (Var x0 x1))) ::' rest , 3)
len-dec-rewrite {- embed-} ((Id "embed") :: _::_(ParseTree (parsed-term x0)) rest) = just (ParseTree (parsed-letterm x0) ::' rest , 2)
len-dec-rewrite {- embed-} ((Id "embed") :: _::_(ParseTree (parsed-atom x0)) rest) = just (ParseTree (parsed-term x0) ::' rest , 2)
len-dec-rewrite {- GlobalsNil-} (_::_(Id "GlobalsNil") rest) = just (ParseTree (parsed-globals (norm-globals GlobalsNil)) ::' rest , 1)
len-dec-rewrite {- P8-} (_::_(Id "P8") rest) = just (ParseTree parsed-ows-star-4 ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
