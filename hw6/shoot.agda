module shoot where

open import lib

open import shoot-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _ws-plus-6 : gratr2-nt
  _ws : gratr2-nt
  _vars : gratr2-nt
  _var-range-8 : gratr2-nt
  _var-plus-9 : gratr2-nt
  _var : gratr2-nt
  _used : gratr2-nt
  _term : gratr2-nt
  _start-opt-3 : gratr2-nt
  _start-opt-2 : gratr2-nt
  _start-opt-1 : gratr2-nt
  _start : gratr2-nt
  _posinfo : gratr2-nt
  _ows-star-7 : gratr2-nt
  _ows : gratr2-nt
  _num-range-10 : gratr2-nt
  _num-plus-11 : gratr2-nt
  _num : gratr2-nt
  _letterm : gratr2-nt
  _is-declared : gratr2-nt
  _ds : gratr2-nt
  _defs : gratr2-nt
  _declared : gratr2-nt
  _d : gratr2-nt
  _aws-bar-5 : gratr2-nt
  _aws-bar-4 : gratr2-nt
  _aws : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _ws-plus-6 _ws-plus-6 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _vars _vars = tt
gratr2-nt-eq  _var-range-8 _var-range-8 = tt
gratr2-nt-eq  _var-plus-9 _var-plus-9 = tt
gratr2-nt-eq  _var _var = tt
gratr2-nt-eq  _used _used = tt
gratr2-nt-eq  _term _term = tt
gratr2-nt-eq  _start-opt-3 _start-opt-3 = tt
gratr2-nt-eq  _start-opt-2 _start-opt-2 = tt
gratr2-nt-eq  _start-opt-1 _start-opt-1 = tt
gratr2-nt-eq  _start _start = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _ows-star-7 _ows-star-7 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _num-range-10 _num-range-10 = tt
gratr2-nt-eq  _num-plus-11 _num-plus-11 = tt
gratr2-nt-eq  _num _num = tt
gratr2-nt-eq  _letterm _letterm = tt
gratr2-nt-eq  _is-declared _is-declared = tt
gratr2-nt-eq  _ds _ds = tt
gratr2-nt-eq  _defs _defs = tt
gratr2-nt-eq  _declared _declared = tt
gratr2-nt-eq  _d _d = tt
gratr2-nt-eq  _aws-bar-5 _aws-bar-5 = tt
gratr2-nt-eq  _aws-bar-4 _aws-bar-4 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


shoot-start : gratr2-nt → 𝕃 gratr2-rule
shoot-start _ws-plus-6 = (just "P28" , nothing , just _ws-plus-6 , inj₁ _aws :: inj₁ _ws-plus-6 :: []) :: (just "P27" , nothing , just _ws-plus-6 , inj₁ _aws :: []) :: []
shoot-start _ws = (just "P29" , nothing , just _ws , inj₁ _ws-plus-6 :: []) :: []
shoot-start _vars = (just "P11" , nothing , just _vars , []) :: (just "P10" , nothing , just _vars , inj₁ _ws :: inj₁ _var :: inj₁ _vars :: []) :: []
shoot-start _var-range-8 = (just "P58" , nothing , just _var-range-8 , inj₂ 'z' :: []) :: (just "P57" , nothing , just _var-range-8 , inj₂ 'y' :: []) :: (just "P56" , nothing , just _var-range-8 , inj₂ 'x' :: []) :: (just "P55" , nothing , just _var-range-8 , inj₂ 'w' :: []) :: (just "P54" , nothing , just _var-range-8 , inj₂ 'v' :: []) :: (just "P53" , nothing , just _var-range-8 , inj₂ 'u' :: []) :: (just "P52" , nothing , just _var-range-8 , inj₂ 't' :: []) :: (just "P51" , nothing , just _var-range-8 , inj₂ 's' :: []) :: (just "P50" , nothing , just _var-range-8 , inj₂ 'r' :: []) :: (just "P49" , nothing , just _var-range-8 , inj₂ 'q' :: []) :: (just "P48" , nothing , just _var-range-8 , inj₂ 'p' :: []) :: (just "P47" , nothing , just _var-range-8 , inj₂ 'o' :: []) :: (just "P46" , nothing , just _var-range-8 , inj₂ 'n' :: []) :: (just "P45" , nothing , just _var-range-8 , inj₂ 'm' :: []) :: (just "P44" , nothing , just _var-range-8 , inj₂ 'l' :: []) :: (just "P43" , nothing , just _var-range-8 , inj₂ 'k' :: []) :: (just "P42" , nothing , just _var-range-8 , inj₂ 'j' :: []) :: (just "P41" , nothing , just _var-range-8 , inj₂ 'i' :: []) :: (just "P40" , nothing , just _var-range-8 , inj₂ 'h' :: []) :: (just "P39" , nothing , just _var-range-8 , inj₂ 'g' :: []) :: (just "P38" , nothing , just _var-range-8 , inj₂ 'f' :: []) :: (just "P37" , nothing , just _var-range-8 , inj₂ 'e' :: []) :: (just "P36" , nothing , just _var-range-8 , inj₂ 'd' :: []) :: (just "P35" , nothing , just _var-range-8 , inj₂ 'c' :: []) :: (just "P34" , nothing , just _var-range-8 , inj₂ 'b' :: []) :: (just "P33" , nothing , just _var-range-8 , inj₂ 'a' :: []) :: []
shoot-start _var-plus-9 = (just "P60" , nothing , just _var-plus-9 , inj₁ _var-range-8 :: inj₁ _var-plus-9 :: []) :: (just "P59" , nothing , just _var-plus-9 , inj₁ _var-range-8 :: []) :: []
shoot-start _var = (just "P61" , nothing , just _var , inj₁ _var-plus-9 :: []) :: []
shoot-start _used = (just "P8" , nothing , just _used , inj₂ 'u' :: inj₂ 's' :: inj₂ 'e' :: inj₂ 'd' :: inj₂ ':' :: inj₁ _vars :: []) :: []
shoot-start _term = (just "P21" , nothing , just _term , inj₂ '(' :: inj₁ _ows :: inj₁ _letterm :: inj₁ _ows :: inj₂ ')' :: []) :: (just "P20" , nothing , just _term , inj₁ _var :: []) :: []
shoot-start _start-opt-3 = (just "P5" , nothing , just _start-opt-3 , []) :: (just "P4" , nothing , just _start-opt-3 , inj₁ _defs :: inj₁ _ws :: []) :: []
shoot-start _start-opt-2 = (just "P3" , nothing , just _start-opt-2 , []) :: (just "P2" , nothing , just _start-opt-2 , inj₁ _used :: inj₁ _ws :: []) :: []
shoot-start _start-opt-1 = (just "P1" , nothing , just _start-opt-1 , []) :: (just "P0" , nothing , just _start-opt-1 , inj₁ _declared :: inj₁ _ws :: []) :: []
shoot-start _start = (just "P6" , nothing , just _start , inj₁ _ows :: inj₁ _start-opt-1 :: inj₁ _start-opt-2 :: inj₁ _start-opt-3 :: []) :: []
shoot-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
shoot-start _ows-star-7 = (just "P31" , nothing , just _ows-star-7 , inj₁ _aws :: inj₁ _ows-star-7 :: []) :: (just "P30" , nothing , just _ows-star-7 , []) :: []
shoot-start _ows = (just "P32" , nothing , just _ows , inj₁ _ows-star-7 :: []) :: []
shoot-start _num-range-10 = (just "P71" , nothing , just _num-range-10 , inj₂ '9' :: []) :: (just "P70" , nothing , just _num-range-10 , inj₂ '8' :: []) :: (just "P69" , nothing , just _num-range-10 , inj₂ '7' :: []) :: (just "P68" , nothing , just _num-range-10 , inj₂ '6' :: []) :: (just "P67" , nothing , just _num-range-10 , inj₂ '5' :: []) :: (just "P66" , nothing , just _num-range-10 , inj₂ '4' :: []) :: (just "P65" , nothing , just _num-range-10 , inj₂ '3' :: []) :: (just "P64" , nothing , just _num-range-10 , inj₂ '2' :: []) :: (just "P63" , nothing , just _num-range-10 , inj₂ '1' :: []) :: (just "P62" , nothing , just _num-range-10 , inj₂ '0' :: []) :: []
shoot-start _num-plus-11 = (just "P73" , nothing , just _num-plus-11 , inj₁ _num-range-10 :: inj₁ _num-plus-11 :: []) :: (just "P72" , nothing , just _num-plus-11 , inj₁ _num-range-10 :: []) :: []
shoot-start _num = (just "P74" , nothing , just _num , inj₁ _num-plus-11 :: []) :: []
shoot-start _letterm = (just "P19" , nothing , just _letterm , inj₁ _term :: []) :: (just "P18" , nothing , just _letterm , inj₂ 'l' :: inj₂ 'e' :: inj₂ 't' :: inj₁ _ws :: inj₁ _var :: inj₁ _ows :: inj₂ '=' :: inj₁ _ows :: inj₁ _term :: inj₁ _ws :: inj₂ 'i' :: inj₂ 'n' :: inj₁ _ws :: inj₁ _letterm :: []) :: []
shoot-start _is-declared = (just "P17" , nothing , just _is-declared , inj₂ 'f' :: inj₂ 'a' :: inj₂ 'l' :: inj₂ 's' :: inj₂ 'e' :: []) :: (just "P16" , nothing , just _is-declared , inj₂ 't' :: inj₂ 'r' :: inj₂ 'u' :: inj₂ 'e' :: []) :: []
shoot-start _ds = (just "P13" , nothing , just _ds , []) :: (just "P12" , nothing , just _ds , inj₁ _ws :: inj₁ _d :: inj₁ _ds :: []) :: []
shoot-start _defs = (just "P9" , nothing , just _defs , inj₂ 'd' :: inj₂ 'e' :: inj₂ 'f' :: inj₂ 's' :: inj₂ ':' :: inj₁ _ds :: []) :: []
shoot-start _declared = (just "P7" , nothing , just _declared , inj₂ 'd' :: inj₂ 'e' :: inj₂ 'c' :: inj₂ 'l' :: inj₂ 'a' :: inj₂ 'r' :: inj₂ 'e' :: inj₂ 'd' :: inj₂ ':' :: inj₁ _vars :: []) :: []
shoot-start _d = (just "P15" , nothing , just _d , inj₁ _var :: inj₂ '@' :: inj₁ _num :: inj₁ _ws :: inj₂ 'g' :: inj₂ 'l' :: inj₂ 'o' :: inj₂ 'b' :: inj₂ 'a' :: inj₂ 'l' :: inj₂ '(' :: inj₁ _is-declared :: inj₂ ')' :: []) :: (just "P14" , nothing , just _d , inj₁ _var :: inj₂ '@' :: inj₁ _num :: inj₁ _ws :: inj₂ 'l' :: inj₂ 'o' :: inj₂ 'c' :: inj₂ 'a' :: inj₂ 'l' :: inj₂ '(' :: inj₁ _num :: inj₂ ')' :: []) :: []
shoot-start _aws-bar-5 = (just "P25" , nothing , just _aws-bar-5 , inj₁ _aws-bar-4 :: []) :: (just "P24" , nothing , just _aws-bar-5 , inj₂ '\n' :: []) :: []
shoot-start _aws-bar-4 = (just "P23" , nothing , just _aws-bar-4 , inj₂ ' ' :: []) :: (just "P22" , nothing , just _aws-bar-4 , inj₂ '\t' :: []) :: []
shoot-start _aws = (just "P26" , nothing , just _aws , inj₁ _aws-bar-5 :: []) :: []


shoot-return : maybe gratr2-nt → 𝕃 gratr2-rule
shoot-return _ = []

shoot-rtn : gratr2-rtn
shoot-rtn = record { start = _start ; _eq_ = gratr2-nt-eq ; gratr2-start = shoot-start ; gratr2-return = shoot-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- P0-} ((Id "P0") :: (ParseTree (parsed-declared x0)) :: _::_(ParseTree parsed-ws) rest) = just (ParseTree (parsed-start-opt-1 (string-append 0 x0)) ::' rest , 3)
len-dec-rewrite {- P10-} ((Id "P10") :: (ParseTree parsed-ws) :: (ParseTree (parsed-var x0)) :: _::_(ParseTree (parsed-vars x1)) rest) = just (ParseTree (parsed-vars (string-append 1 x0 x1)) ::' rest , 4)
len-dec-rewrite {- P12-} ((Id "P12") :: (ParseTree parsed-ws) :: (ParseTree (parsed-d x0)) :: _::_(ParseTree (parsed-ds x1)) rest) = just (ParseTree (parsed-ds (string-append 1 x0 x1)) ::' rest , 4)
len-dec-rewrite {- P14-} ((Id "P14") :: (ParseTree (parsed-var x0)) :: (InputChar '@') :: (ParseTree (parsed-num x1)) :: (ParseTree parsed-ws) :: (InputChar 'l') :: (InputChar 'o') :: (InputChar 'c') :: (InputChar 'a') :: (InputChar 'l') :: (InputChar '(') :: (ParseTree (parsed-num x2)) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-d (string-append 10 x0 (char-to-string '@') x1 (char-to-string 'l') (char-to-string 'o') (char-to-string 'c') (char-to-string 'a') (char-to-string 'l') (char-to-string '(') x2 (char-to-string ')'))) ::' rest , 13)
len-dec-rewrite {- P15-} ((Id "P15") :: (ParseTree (parsed-var x0)) :: (InputChar '@') :: (ParseTree (parsed-num x1)) :: (ParseTree parsed-ws) :: (InputChar 'g') :: (InputChar 'l') :: (InputChar 'o') :: (InputChar 'b') :: (InputChar 'a') :: (InputChar 'l') :: (InputChar '(') :: (ParseTree (parsed-is-declared x2)) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-d (string-append 11 x0 (char-to-string '@') x1 (char-to-string 'g') (char-to-string 'l') (char-to-string 'o') (char-to-string 'b') (char-to-string 'a') (char-to-string 'l') (char-to-string '(') x2 (char-to-string ')'))) ::' rest , 14)
len-dec-rewrite {- P16-} ((Id "P16") :: (InputChar 't') :: (InputChar 'r') :: (InputChar 'u') :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-is-declared (string-append 3 (char-to-string 't') (char-to-string 'r') (char-to-string 'u') (char-to-string 'e'))) ::' rest , 5)
len-dec-rewrite {- P17-} ((Id "P17") :: (InputChar 'f') :: (InputChar 'a') :: (InputChar 'l') :: (InputChar 's') :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-is-declared (string-append 4 (char-to-string 'f') (char-to-string 'a') (char-to-string 'l') (char-to-string 's') (char-to-string 'e'))) ::' rest , 6)
len-dec-rewrite {- P18-} ((Id "P18") :: (InputChar 'l') :: (InputChar 'e') :: (InputChar 't') :: (ParseTree parsed-ws) :: (ParseTree (parsed-var x0)) :: (ParseTree parsed-ows) :: (InputChar '=') :: (ParseTree parsed-ows) :: (ParseTree (parsed-term x1)) :: (ParseTree parsed-ws) :: (InputChar 'i') :: (InputChar 'n') :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-letterm x2)) rest) = just (ParseTree (parsed-letterm (string-append 8 (char-to-string 'l') (char-to-string 'e') (char-to-string 't') x0 (char-to-string '=') x1 (char-to-string 'i') (char-to-string 'n') x2)) ::' rest , 15)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(ParseTree (parsed-term x0)) rest) = just (ParseTree (parsed-letterm (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: (ParseTree (parsed-used x0)) :: _::_(ParseTree parsed-ws) rest) = just (ParseTree (parsed-start-opt-2 (string-append 0 x0)) ::' rest , 3)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(ParseTree (parsed-var x0)) rest) = just (ParseTree (parsed-term (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P21-} ((Id "P21") :: (InputChar '(') :: (ParseTree parsed-ows) :: (ParseTree (parsed-letterm x0)) :: (ParseTree parsed-ows) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-term (string-append 2 (char-to-string '(') x0 (char-to-string ')'))) ::' rest , 6)
len-dec-rewrite {- P22-} ((Id "P22") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-4 ::' rest , 2)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-4 ::' rest , 2)
len-dec-rewrite {- P24-} ((Id "P24") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-5 ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: _::_(ParseTree parsed-aws-bar-4) rest) = just (ParseTree parsed-aws-bar-5 ::' rest , 2)
len-dec-rewrite {- P26-} ((Id "P26") :: _::_(ParseTree parsed-aws-bar-5) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P27-} ((Id "P27") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-6 ::' rest , 2)
len-dec-rewrite {- P28-} ((Id "P28") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-6) rest) = just (ParseTree parsed-ws-plus-6 ::' rest , 3)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(ParseTree parsed-ws-plus-6) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P31-} ((Id "P31") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-7) rest) = just (ParseTree parsed-ows-star-7 ::' rest , 3)
len-dec-rewrite {- P32-} ((Id "P32") :: _::_(ParseTree parsed-ows-star-7) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P33-} ((Id "P33") :: _::_(InputChar 'a') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'a'))) ::' rest , 2)
len-dec-rewrite {- P34-} ((Id "P34") :: _::_(InputChar 'b') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'b'))) ::' rest , 2)
len-dec-rewrite {- P35-} ((Id "P35") :: _::_(InputChar 'c') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'c'))) ::' rest , 2)
len-dec-rewrite {- P36-} ((Id "P36") :: _::_(InputChar 'd') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'd'))) ::' rest , 2)
len-dec-rewrite {- P37-} ((Id "P37") :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'e'))) ::' rest , 2)
len-dec-rewrite {- P38-} ((Id "P38") :: _::_(InputChar 'f') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'f'))) ::' rest , 2)
len-dec-rewrite {- P39-} ((Id "P39") :: _::_(InputChar 'g') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'g'))) ::' rest , 2)
len-dec-rewrite {- P4-} ((Id "P4") :: (ParseTree (parsed-defs x0)) :: _::_(ParseTree parsed-ws) rest) = just (ParseTree (parsed-start-opt-3 (string-append 0 x0)) ::' rest , 3)
len-dec-rewrite {- P40-} ((Id "P40") :: _::_(InputChar 'h') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'h'))) ::' rest , 2)
len-dec-rewrite {- P41-} ((Id "P41") :: _::_(InputChar 'i') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'i'))) ::' rest , 2)
len-dec-rewrite {- P42-} ((Id "P42") :: _::_(InputChar 'j') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'j'))) ::' rest , 2)
len-dec-rewrite {- P43-} ((Id "P43") :: _::_(InputChar 'k') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'k'))) ::' rest , 2)
len-dec-rewrite {- P44-} ((Id "P44") :: _::_(InputChar 'l') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'l'))) ::' rest , 2)
len-dec-rewrite {- P45-} ((Id "P45") :: _::_(InputChar 'm') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'm'))) ::' rest , 2)
len-dec-rewrite {- P46-} ((Id "P46") :: _::_(InputChar 'n') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'n'))) ::' rest , 2)
len-dec-rewrite {- P47-} ((Id "P47") :: _::_(InputChar 'o') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'o'))) ::' rest , 2)
len-dec-rewrite {- P48-} ((Id "P48") :: _::_(InputChar 'p') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'p'))) ::' rest , 2)
len-dec-rewrite {- P49-} ((Id "P49") :: _::_(InputChar 'q') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'q'))) ::' rest , 2)
len-dec-rewrite {- P50-} ((Id "P50") :: _::_(InputChar 'r') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'r'))) ::' rest , 2)
len-dec-rewrite {- P51-} ((Id "P51") :: _::_(InputChar 's') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 's'))) ::' rest , 2)
len-dec-rewrite {- P52-} ((Id "P52") :: _::_(InputChar 't') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 't'))) ::' rest , 2)
len-dec-rewrite {- P53-} ((Id "P53") :: _::_(InputChar 'u') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'u'))) ::' rest , 2)
len-dec-rewrite {- P54-} ((Id "P54") :: _::_(InputChar 'v') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'v'))) ::' rest , 2)
len-dec-rewrite {- P55-} ((Id "P55") :: _::_(InputChar 'w') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'w'))) ::' rest , 2)
len-dec-rewrite {- P56-} ((Id "P56") :: _::_(InputChar 'x') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'x'))) ::' rest , 2)
len-dec-rewrite {- P57-} ((Id "P57") :: _::_(InputChar 'y') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'y'))) ::' rest , 2)
len-dec-rewrite {- P58-} ((Id "P58") :: _::_(InputChar 'z') rest) = just (ParseTree (parsed-var-range-8 (string-append 0 (char-to-string 'z'))) ::' rest , 2)
len-dec-rewrite {- P59-} ((Id "P59") :: _::_(ParseTree (parsed-var-range-8 x0)) rest) = just (ParseTree (parsed-var-plus-9 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: (ParseTree parsed-ows) :: (ParseTree (parsed-start-opt-1 x0)) :: (ParseTree (parsed-start-opt-2 x1)) :: _::_(ParseTree (parsed-start-opt-3 x2)) rest) = just (ParseTree (parsed-start (string-append 2 x0 x1 x2)) ::' rest , 5)
len-dec-rewrite {- P60-} ((Id "P60") :: (ParseTree (parsed-var-range-8 x0)) :: _::_(ParseTree (parsed-var-plus-9 x1)) rest) = just (ParseTree (parsed-var-plus-9 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P61-} ((Id "P61") :: _::_(ParseTree (parsed-var-plus-9 x0)) rest) = just (ParseTree (parsed-var (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P62-} ((Id "P62") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P63-} ((Id "P63") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P64-} ((Id "P64") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P65-} ((Id "P65") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P66-} ((Id "P66") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P67-} ((Id "P67") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P68-} ((Id "P68") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P69-} ((Id "P69") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P7-} ((Id "P7") :: (InputChar 'd') :: (InputChar 'e') :: (InputChar 'c') :: (InputChar 'l') :: (InputChar 'a') :: (InputChar 'r') :: (InputChar 'e') :: (InputChar 'd') :: (InputChar ':') :: _::_(ParseTree (parsed-vars x0)) rest) = just (ParseTree (parsed-declared (string-append 9 (char-to-string 'd') (char-to-string 'e') (char-to-string 'c') (char-to-string 'l') (char-to-string 'a') (char-to-string 'r') (char-to-string 'e') (char-to-string 'd') (char-to-string ':') x0)) ::' rest , 11)
len-dec-rewrite {- P70-} ((Id "P70") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P71-} ((Id "P71") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-num-range-10 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P72-} ((Id "P72") :: _::_(ParseTree (parsed-num-range-10 x0)) rest) = just (ParseTree (parsed-num-plus-11 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P73-} ((Id "P73") :: (ParseTree (parsed-num-range-10 x0)) :: _::_(ParseTree (parsed-num-plus-11 x1)) rest) = just (ParseTree (parsed-num-plus-11 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P74-} ((Id "P74") :: _::_(ParseTree (parsed-num-plus-11 x0)) rest) = just (ParseTree (parsed-num (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P8-} ((Id "P8") :: (InputChar 'u') :: (InputChar 's') :: (InputChar 'e') :: (InputChar 'd') :: (InputChar ':') :: _::_(ParseTree (parsed-vars x0)) rest) = just (ParseTree (parsed-used (string-append 5 (char-to-string 'u') (char-to-string 's') (char-to-string 'e') (char-to-string 'd') (char-to-string ':') x0)) ::' rest , 7)
len-dec-rewrite {- P9-} ((Id "P9") :: (InputChar 'd') :: (InputChar 'e') :: (InputChar 'f') :: (InputChar 's') :: (InputChar ':') :: _::_(ParseTree (parsed-ds x0)) rest) = just (ParseTree (parsed-defs (string-append 5 (char-to-string 'd') (char-to-string 'e') (char-to-string 'f') (char-to-string 's') (char-to-string ':') x0)) ::' rest , 7)
len-dec-rewrite {- P1-} (_::_(Id "P1") rest) = just (ParseTree (parsed-start-opt-1 empty-string) ::' rest , 1)
len-dec-rewrite {- P11-} (_::_(Id "P11") rest) = just (ParseTree (parsed-vars empty-string) ::' rest , 1)
len-dec-rewrite {- P13-} (_::_(Id "P13") rest) = just (ParseTree (parsed-ds empty-string) ::' rest , 1)
len-dec-rewrite {- P3-} (_::_(Id "P3") rest) = just (ParseTree (parsed-start-opt-2 empty-string) ::' rest , 1)
len-dec-rewrite {- P30-} (_::_(Id "P30") rest) = just (ParseTree parsed-ows-star-7 ::' rest , 1)
len-dec-rewrite {- P5-} (_::_(Id "P5") rest) = just (ParseTree (parsed-start-opt-3 empty-string) ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
