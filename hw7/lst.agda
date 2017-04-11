module lst where

open import lib

open import lst-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _ws-plus-5 : gratr2-nt
  _ws : gratr2-nt
  _var-range-1 : gratr2-nt
  _var-plus-2 : gratr2-nt
  _var : gratr2-nt
  _strt : gratr2-nt
  _posinfo : gratr2-nt
  _ows-star-4 : gratr2-nt
  _ows : gratr2-nt
  _expr : gratr2-nt
  _aws-bar-7 : gratr2-nt
  _aws-bar-6 : gratr2-nt
  _aws : gratr2-nt
  _arrow-bar-3 : gratr2-nt
  _arrow : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _ws-plus-5 _ws-plus-5 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _var-range-1 _var-range-1 = tt
gratr2-nt-eq  _var-plus-2 _var-plus-2 = tt
gratr2-nt-eq  _var _var = tt
gratr2-nt-eq  _strt _strt = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _ows-star-4 _ows-star-4 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _expr _expr = tt
gratr2-nt-eq  _aws-bar-7 _aws-bar-7 = tt
gratr2-nt-eq  _aws-bar-6 _aws-bar-6 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq  _arrow-bar-3 _arrow-bar-3 = tt
gratr2-nt-eq  _arrow _arrow = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


lst-start : gratr2-nt → 𝕃 gratr2-rule
lst-start _ws-plus-5 = (just "P36" , nothing , just _ws-plus-5 , inj₁ _aws :: inj₁ _ws-plus-5 :: []) :: (just "P35" , nothing , just _ws-plus-5 , inj₁ _aws :: []) :: []
lst-start _ws = (just "P37" , nothing , just _ws , inj₁ _ws-plus-5 :: []) :: []
lst-start _var-range-1 = (just "P9" , nothing , just _var-range-1 , inj₂ 'j' :: []) :: (just "P8" , nothing , just _var-range-1 , inj₂ 'i' :: []) :: (just "P7" , nothing , just _var-range-1 , inj₂ 'h' :: []) :: (just "P6" , nothing , just _var-range-1 , inj₂ 'g' :: []) :: (just "P5" , nothing , just _var-range-1 , inj₂ 'f' :: []) :: (just "P4" , nothing , just _var-range-1 , inj₂ 'e' :: []) :: (just "P3" , nothing , just _var-range-1 , inj₂ 'd' :: []) :: (just "P25" , nothing , just _var-range-1 , inj₂ 'z' :: []) :: (just "P24" , nothing , just _var-range-1 , inj₂ 'y' :: []) :: (just "P23" , nothing , just _var-range-1 , inj₂ 'x' :: []) :: (just "P22" , nothing , just _var-range-1 , inj₂ 'w' :: []) :: (just "P21" , nothing , just _var-range-1 , inj₂ 'v' :: []) :: (just "P20" , nothing , just _var-range-1 , inj₂ 'u' :: []) :: (just "P2" , nothing , just _var-range-1 , inj₂ 'c' :: []) :: (just "P19" , nothing , just _var-range-1 , inj₂ 't' :: []) :: (just "P18" , nothing , just _var-range-1 , inj₂ 's' :: []) :: (just "P17" , nothing , just _var-range-1 , inj₂ 'r' :: []) :: (just "P16" , nothing , just _var-range-1 , inj₂ 'q' :: []) :: (just "P15" , nothing , just _var-range-1 , inj₂ 'p' :: []) :: (just "P14" , nothing , just _var-range-1 , inj₂ 'o' :: []) :: (just "P13" , nothing , just _var-range-1 , inj₂ 'n' :: []) :: (just "P12" , nothing , just _var-range-1 , inj₂ 'm' :: []) :: (just "P11" , nothing , just _var-range-1 , inj₂ 'l' :: []) :: (just "P10" , nothing , just _var-range-1 , inj₂ 'k' :: []) :: (just "P1" , nothing , just _var-range-1 , inj₂ 'b' :: []) :: (just "P0" , nothing , just _var-range-1 , inj₂ 'a' :: []) :: []
lst-start _var-plus-2 = (just "P27" , nothing , just _var-plus-2 , inj₁ _var-range-1 :: inj₁ _var-plus-2 :: []) :: (just "P26" , nothing , just _var-plus-2 , inj₁ _var-range-1 :: []) :: []
lst-start _var = (just "P28" , nothing , just _var , inj₁ _var-plus-2 :: []) :: []
lst-start _strt = (just "Strt" , just "Strt_end" , just _strt , inj₁ _ows :: inj₁ _expr :: inj₁ _ows :: []) :: []
lst-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
lst-start _ows-star-4 = (just "P33" , nothing , just _ows-star-4 , inj₁ _aws :: inj₁ _ows-star-4 :: []) :: (just "P32" , nothing , just _ows-star-4 , []) :: []
lst-start _ows = (just "P34" , nothing , just _ows , inj₁ _ows-star-4 :: []) :: []
lst-start _expr = (just "Var" , nothing , just _expr , inj₁ _var :: []) :: (just "Parens" , nothing , just _expr , inj₂ '(' :: inj₁ _ows :: inj₁ _expr :: inj₁ _ows :: inj₂ ')' :: []) :: (just "Nil" , nothing , just _expr , inj₂ '[' :: inj₂ ']' :: []) :: []
lst-start _aws-bar-7 = (just "P41" , nothing , just _aws-bar-7 , inj₁ _aws-bar-6 :: []) :: (just "P40" , nothing , just _aws-bar-7 , inj₂ '\n' :: []) :: []
lst-start _aws-bar-6 = (just "P39" , nothing , just _aws-bar-6 , inj₂ ' ' :: []) :: (just "P38" , nothing , just _aws-bar-6 , inj₂ '\t' :: []) :: []
lst-start _aws = (just "P42" , nothing , just _aws , inj₁ _aws-bar-7 :: []) :: []
lst-start _arrow-bar-3 = (just "P30" , nothing , just _arrow-bar-3 , inj₂ '-' :: inj₂ '>' :: []) :: (just "P29" , nothing , just _arrow-bar-3 , inj₂ '→' :: []) :: []
lst-start _arrow = (just "P31" , nothing , just _arrow , inj₁ _arrow-bar-3 :: []) :: []


lst-return : maybe gratr2-nt → 𝕃 gratr2-rule
lst-return (just _expr) = (nothing , nothing , just _expr , inj₁ _ows :: inj₂ ':' :: inj₂ ':' :: inj₁ _ows :: inj₁ _expr :: []) :: (nothing , nothing , just _expr , inj₁ _ows :: inj₂ '+' :: inj₂ '+' :: inj₁ _ows :: inj₁ _expr :: []) :: []
lst-return _ = []

lst-rtn : gratr2-rtn
lst-rtn = record { start = _strt ; _eq_ = gratr2-nt-eq ; gratr2-start = lst-start ; gratr2-return = lst-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- App-} ((ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: (InputChar '+') :: (InputChar '+') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-expr x1)) rest) = just (ParseTree (parsed-expr (norm-expr (App x0 x1))) ::' rest , 6)
len-dec-rewrite {- Cons-} ((ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: (InputChar ':') :: (InputChar ':') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-expr x1)) rest) = just (ParseTree (parsed-expr (norm-expr (Cons x0 x1))) ::' rest , 6)
len-dec-rewrite {- Nil-} ((Id "Nil") :: (InputChar '[') :: _::_(InputChar ']') rest) = just (ParseTree (parsed-expr (norm-expr Nil)) ::' rest , 3)
len-dec-rewrite {- P0-} ((Id "P0") :: _::_(InputChar 'a') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'a'))) ::' rest , 2)
len-dec-rewrite {- P1-} ((Id "P1") :: _::_(InputChar 'b') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'b'))) ::' rest , 2)
len-dec-rewrite {- P10-} ((Id "P10") :: _::_(InputChar 'k') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'k'))) ::' rest , 2)
len-dec-rewrite {- P11-} ((Id "P11") :: _::_(InputChar 'l') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'l'))) ::' rest , 2)
len-dec-rewrite {- P12-} ((Id "P12") :: _::_(InputChar 'm') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'm'))) ::' rest , 2)
len-dec-rewrite {- P13-} ((Id "P13") :: _::_(InputChar 'n') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'n'))) ::' rest , 2)
len-dec-rewrite {- P14-} ((Id "P14") :: _::_(InputChar 'o') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'o'))) ::' rest , 2)
len-dec-rewrite {- P15-} ((Id "P15") :: _::_(InputChar 'p') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'p'))) ::' rest , 2)
len-dec-rewrite {- P16-} ((Id "P16") :: _::_(InputChar 'q') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'q'))) ::' rest , 2)
len-dec-rewrite {- P17-} ((Id "P17") :: _::_(InputChar 'r') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'r'))) ::' rest , 2)
len-dec-rewrite {- P18-} ((Id "P18") :: _::_(InputChar 's') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 's'))) ::' rest , 2)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(InputChar 't') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 't'))) ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: _::_(InputChar 'c') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'c'))) ::' rest , 2)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(InputChar 'u') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'u'))) ::' rest , 2)
len-dec-rewrite {- P21-} ((Id "P21") :: _::_(InputChar 'v') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'v'))) ::' rest , 2)
len-dec-rewrite {- P22-} ((Id "P22") :: _::_(InputChar 'w') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'w'))) ::' rest , 2)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(InputChar 'x') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'x'))) ::' rest , 2)
len-dec-rewrite {- P24-} ((Id "P24") :: _::_(InputChar 'y') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'y'))) ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: _::_(InputChar 'z') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'z'))) ::' rest , 2)
len-dec-rewrite {- P26-} ((Id "P26") :: _::_(ParseTree (parsed-var-range-1 x0)) rest) = just (ParseTree (parsed-var-plus-2 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P27-} ((Id "P27") :: (ParseTree (parsed-var-range-1 x0)) :: _::_(ParseTree (parsed-var-plus-2 x1)) rest) = just (ParseTree (parsed-var-plus-2 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P28-} ((Id "P28") :: _::_(ParseTree (parsed-var-plus-2 x0)) rest) = just (ParseTree (parsed-var (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(InputChar '→') rest) = just (ParseTree parsed-arrow-bar-3 ::' rest , 2)
len-dec-rewrite {- P3-} ((Id "P3") :: _::_(InputChar 'd') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'd'))) ::' rest , 2)
len-dec-rewrite {- P30-} ((Id "P30") :: (InputChar '-') :: _::_(InputChar '>') rest) = just (ParseTree parsed-arrow-bar-3 ::' rest , 3)
len-dec-rewrite {- P31-} ((Id "P31") :: _::_(ParseTree parsed-arrow-bar-3) rest) = just (ParseTree parsed-arrow ::' rest , 2)
len-dec-rewrite {- P33-} ((Id "P33") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows-star-4 ::' rest , 3)
len-dec-rewrite {- P34-} ((Id "P34") :: _::_(ParseTree parsed-ows-star-4) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P35-} ((Id "P35") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-5 ::' rest , 2)
len-dec-rewrite {- P36-} ((Id "P36") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-5) rest) = just (ParseTree parsed-ws-plus-5 ::' rest , 3)
len-dec-rewrite {- P37-} ((Id "P37") :: _::_(ParseTree parsed-ws-plus-5) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P38-} ((Id "P38") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-6 ::' rest , 2)
len-dec-rewrite {- P39-} ((Id "P39") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-6 ::' rest , 2)
len-dec-rewrite {- P4-} ((Id "P4") :: _::_(InputChar 'e') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'e'))) ::' rest , 2)
len-dec-rewrite {- P40-} ((Id "P40") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-7 ::' rest , 2)
len-dec-rewrite {- P41-} ((Id "P41") :: _::_(ParseTree parsed-aws-bar-6) rest) = just (ParseTree parsed-aws-bar-7 ::' rest , 2)
len-dec-rewrite {- P42-} ((Id "P42") :: _::_(ParseTree parsed-aws-bar-7) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P5-} ((Id "P5") :: _::_(InputChar 'f') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'f'))) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: _::_(InputChar 'g') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'g'))) ::' rest , 2)
len-dec-rewrite {- P7-} ((Id "P7") :: _::_(InputChar 'h') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'h'))) ::' rest , 2)
len-dec-rewrite {- P8-} ((Id "P8") :: _::_(InputChar 'i') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'i'))) ::' rest , 2)
len-dec-rewrite {- P9-} ((Id "P9") :: _::_(InputChar 'j') rest) = just (ParseTree (parsed-var-range-1 (string-append 0 (char-to-string 'j'))) ::' rest , 2)
len-dec-rewrite {- Parens-} ((Id "Parens") :: (InputChar '(') :: (ParseTree parsed-ows) :: (ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: _::_(InputChar ')') rest) = just (ParseTree (parsed-expr (norm-expr (Parens x0))) ::' rest , 6)
len-dec-rewrite {- Strt-} ((Id "Strt") :: (ParseTree parsed-ows) :: (ParseTree (parsed-expr x0)) :: (ParseTree parsed-ows) :: _::_(Id "Strt_end") rest) = just (ParseTree (parsed-strt (norm-strt (Strt x0))) ::' rest , 5)
len-dec-rewrite {- Var-} ((Id "Var") :: _::_(ParseTree (parsed-var x0)) rest) = just (ParseTree (parsed-expr (norm-expr (Var x0))) ::' rest , 2)
len-dec-rewrite {- P32-} (_::_(Id "P32") rest) = just (ParseTree parsed-ows-star-4 ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
