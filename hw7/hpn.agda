module hpn where

open import lib

open import hpn-types public
----------------------------------------------------------------------------------
-- Run-rewriting rules
----------------------------------------------------------------------------------

data gratr2-nt : Set where
  _ws-plus-7 : gratr2-nt
  _ws : gratr2-nt
  _strt : gratr2-nt
  _posnum-plus-3 : gratr2-nt
  _posnum-bar-2 : gratr2-nt
  _posnum : gratr2-nt
  _posinfo : gratr2-nt
  _posdig-range-1 : gratr2-nt
  _posdig : gratr2-nt
  _ows-star-8 : gratr2-nt
  _ows : gratr2-nt
  _num-bar-4 : gratr2-nt
  _num : gratr2-nt
  _hpn : gratr2-nt
  _cmds : gratr2-nt
  _cmd : gratr2-nt
  _aws-bar-6 : gratr2-nt
  _aws-bar-5 : gratr2-nt
  _aws : gratr2-nt
  _atom : gratr2-nt


gratr2-nt-eq : gratr2-nt → gratr2-nt → 𝔹
gratr2-nt-eq  _ws-plus-7 _ws-plus-7 = tt
gratr2-nt-eq  _ws _ws = tt
gratr2-nt-eq  _strt _strt = tt
gratr2-nt-eq  _posnum-plus-3 _posnum-plus-3 = tt
gratr2-nt-eq  _posnum-bar-2 _posnum-bar-2 = tt
gratr2-nt-eq  _posnum _posnum = tt
gratr2-nt-eq  _posinfo _posinfo = tt
gratr2-nt-eq  _posdig-range-1 _posdig-range-1 = tt
gratr2-nt-eq  _posdig _posdig = tt
gratr2-nt-eq  _ows-star-8 _ows-star-8 = tt
gratr2-nt-eq  _ows _ows = tt
gratr2-nt-eq  _num-bar-4 _num-bar-4 = tt
gratr2-nt-eq  _num _num = tt
gratr2-nt-eq  _hpn _hpn = tt
gratr2-nt-eq  _cmds _cmds = tt
gratr2-nt-eq  _cmd _cmd = tt
gratr2-nt-eq  _aws-bar-6 _aws-bar-6 = tt
gratr2-nt-eq  _aws-bar-5 _aws-bar-5 = tt
gratr2-nt-eq  _aws _aws = tt
gratr2-nt-eq  _atom _atom = tt
gratr2-nt-eq _ _ = ff


open import rtn gratr2-nt


hpn-start : gratr2-nt → 𝕃 gratr2-rule
hpn-start _ws-plus-7 = (just "P25" , nothing , just _ws-plus-7 , inj₁ _aws :: inj₁ _ws-plus-7 :: []) :: (just "P24" , nothing , just _ws-plus-7 , inj₁ _aws :: []) :: []
hpn-start _ws = (just "P26" , nothing , just _ws , inj₁ _ws-plus-7 :: []) :: []
hpn-start _strt = (just "Strt" , nothing , just _strt , inj₁ _ows :: inj₁ _cmds :: inj₁ _ows :: []) :: []
hpn-start _posnum-plus-3 = (just "P14" , nothing , just _posnum-plus-3 , inj₁ _posnum-bar-2 :: inj₁ _posnum-plus-3 :: []) :: (just "P13" , nothing , just _posnum-plus-3 , inj₁ _posnum-bar-2 :: []) :: []
hpn-start _posnum-bar-2 = (just "P12" , nothing , just _posnum-bar-2 , inj₁ _posdig :: []) :: (just "P11" , nothing , just _posnum-bar-2 , inj₂ '0' :: []) :: []
hpn-start _posnum = (just "P15" , nothing , just _posnum , inj₁ _posdig :: inj₁ _posnum-plus-3 :: []) :: (just "P10" , nothing , just _posnum , inj₁ _posdig :: []) :: []
hpn-start _posinfo = (just "Posinfo" , nothing , just _posinfo , []) :: []
hpn-start _posdig-range-1 = (just "P8" , nothing , just _posdig-range-1 , inj₂ '9' :: []) :: (just "P7" , nothing , just _posdig-range-1 , inj₂ '8' :: []) :: (just "P6" , nothing , just _posdig-range-1 , inj₂ '7' :: []) :: (just "P5" , nothing , just _posdig-range-1 , inj₂ '6' :: []) :: (just "P4" , nothing , just _posdig-range-1 , inj₂ '5' :: []) :: (just "P3" , nothing , just _posdig-range-1 , inj₂ '4' :: []) :: (just "P2" , nothing , just _posdig-range-1 , inj₂ '3' :: []) :: (just "P1" , nothing , just _posdig-range-1 , inj₂ '2' :: []) :: (just "P0" , nothing , just _posdig-range-1 , inj₂ '1' :: []) :: []
hpn-start _posdig = (just "P9" , nothing , just _posdig , inj₁ _posdig-range-1 :: []) :: []
hpn-start _ows-star-8 = (just "P28" , nothing , just _ows-star-8 , inj₁ _aws :: inj₁ _ows-star-8 :: []) :: (just "P27" , nothing , just _ows-star-8 , []) :: []
hpn-start _ows = (just "P29" , nothing , just _ows , inj₁ _ows-star-8 :: []) :: []
hpn-start _num-bar-4 = (just "P17" , nothing , just _num-bar-4 , inj₁ _posnum :: []) :: (just "P16" , nothing , just _num-bar-4 , inj₂ '0' :: []) :: []
hpn-start _num = (just "P18" , nothing , just _num , inj₁ _num-bar-4 :: []) :: []
hpn-start _hpn = (just "Zero" , nothing , just _hpn , inj₂ '0' :: []) :: (just "SeqStart" , nothing , just _hpn , inj₁ _atom :: []) :: (just "SeqNext" , nothing , just _hpn , inj₁ _atom :: inj₁ _ows :: inj₂ '+' :: inj₁ _ows :: inj₁ _hpn :: []) :: []
hpn-start _cmds = (just "CmdsStart" , nothing , just _cmds , inj₁ _cmd :: []) :: (just "CmdsNext" , nothing , just _cmds , inj₁ _cmd :: inj₁ _ws :: inj₁ _cmds :: []) :: []
hpn-start _cmd = (just "ToHpn" , nothing , just _cmd , inj₁ _posnum :: inj₁ _ws :: inj₂ 'b' :: inj₂ 'a' :: inj₂ 's' :: inj₂ 'e' :: inj₁ _ws :: inj₁ _posnum :: []) :: (just "ToDecimal" , nothing , just _cmd , inj₁ _hpn :: inj₁ _ws :: inj₂ 'b' :: inj₂ 'a' :: inj₂ 's' :: inj₂ 'e' :: inj₁ _ws :: inj₁ _posnum :: []) :: []
hpn-start _aws-bar-6 = (just "P22" , nothing , just _aws-bar-6 , inj₁ _aws-bar-5 :: []) :: (just "P21" , nothing , just _aws-bar-6 , inj₂ ' ' :: []) :: []
hpn-start _aws-bar-5 = (just "P20" , nothing , just _aws-bar-5 , inj₂ '\n' :: []) :: (just "P19" , nothing , just _aws-bar-5 , inj₂ '\t' :: []) :: []
hpn-start _aws = (just "P23" , nothing , just _aws , inj₁ _aws-bar-6 :: []) :: []
hpn-start _atom = (just "Pow" , nothing , just _atom , inj₂ '[' :: inj₁ _ows :: inj₁ _hpn :: inj₁ _ows :: inj₂ ']' :: []) :: []


hpn-return : maybe gratr2-nt → 𝕃 gratr2-rule
hpn-return _ = []

hpn-rtn : gratr2-rtn
hpn-rtn = record { start = _strt ; _eq_ = gratr2-nt-eq ; gratr2-start = hpn-start ; gratr2-return = hpn-return }

open import run ptr
open noderiv

------------------------------------------
-- Length-decreasing rules
------------------------------------------

len-dec-rewrite : Run → maybe (Run × ℕ)
len-dec-rewrite {- CmdsNext-} ((Id "CmdsNext") :: (ParseTree (parsed-cmd x0)) :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-cmds x1)) rest) = just (ParseTree (parsed-cmds (norm-cmds (CmdsNext x0 x1))) ::' rest , 4)
len-dec-rewrite {- CmdsStart-} ((Id "CmdsStart") :: _::_(ParseTree (parsed-cmd x0)) rest) = just (ParseTree (parsed-cmds (norm-cmds (CmdsStart x0))) ::' rest , 2)
len-dec-rewrite {- P0-} ((Id "P0") :: _::_(InputChar '1') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '1'))) ::' rest , 2)
len-dec-rewrite {- P1-} ((Id "P1") :: _::_(InputChar '2') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '2'))) ::' rest , 2)
len-dec-rewrite {- P10-} ((Id "P10") :: _::_(ParseTree (parsed-posdig x0)) rest) = just (ParseTree (parsed-posnum (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P11-} ((Id "P11") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-posnum-bar-2 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P12-} ((Id "P12") :: _::_(ParseTree (parsed-posdig x0)) rest) = just (ParseTree (parsed-posnum-bar-2 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P13-} ((Id "P13") :: _::_(ParseTree (parsed-posnum-bar-2 x0)) rest) = just (ParseTree (parsed-posnum-plus-3 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P14-} ((Id "P14") :: (ParseTree (parsed-posnum-bar-2 x0)) :: _::_(ParseTree (parsed-posnum-plus-3 x1)) rest) = just (ParseTree (parsed-posnum-plus-3 (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P15-} ((Id "P15") :: (ParseTree (parsed-posdig x0)) :: _::_(ParseTree (parsed-posnum-plus-3 x1)) rest) = just (ParseTree (parsed-posnum (string-append 1 x0 x1)) ::' rest , 3)
len-dec-rewrite {- P16-} ((Id "P16") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-num-bar-4 (string-append 0 (char-to-string '0'))) ::' rest , 2)
len-dec-rewrite {- P17-} ((Id "P17") :: _::_(ParseTree (parsed-posnum x0)) rest) = just (ParseTree (parsed-num-bar-4 (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P18-} ((Id "P18") :: _::_(ParseTree (parsed-num-bar-4 x0)) rest) = just (ParseTree (parsed-num (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- P19-} ((Id "P19") :: _::_(InputChar '\t') rest) = just (ParseTree parsed-aws-bar-5 ::' rest , 2)
len-dec-rewrite {- P2-} ((Id "P2") :: _::_(InputChar '3') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '3'))) ::' rest , 2)
len-dec-rewrite {- P20-} ((Id "P20") :: _::_(InputChar '\n') rest) = just (ParseTree parsed-aws-bar-5 ::' rest , 2)
len-dec-rewrite {- P21-} ((Id "P21") :: _::_(InputChar ' ') rest) = just (ParseTree parsed-aws-bar-6 ::' rest , 2)
len-dec-rewrite {- P22-} ((Id "P22") :: _::_(ParseTree parsed-aws-bar-5) rest) = just (ParseTree parsed-aws-bar-6 ::' rest , 2)
len-dec-rewrite {- P23-} ((Id "P23") :: _::_(ParseTree parsed-aws-bar-6) rest) = just (ParseTree parsed-aws ::' rest , 2)
len-dec-rewrite {- P24-} ((Id "P24") :: _::_(ParseTree parsed-aws) rest) = just (ParseTree parsed-ws-plus-7 ::' rest , 2)
len-dec-rewrite {- P25-} ((Id "P25") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ws-plus-7) rest) = just (ParseTree parsed-ws-plus-7 ::' rest , 3)
len-dec-rewrite {- P26-} ((Id "P26") :: _::_(ParseTree parsed-ws-plus-7) rest) = just (ParseTree parsed-ws ::' rest , 2)
len-dec-rewrite {- P28-} ((Id "P28") :: (ParseTree parsed-aws) :: _::_(ParseTree parsed-ows-star-8) rest) = just (ParseTree parsed-ows-star-8 ::' rest , 3)
len-dec-rewrite {- P29-} ((Id "P29") :: _::_(ParseTree parsed-ows-star-8) rest) = just (ParseTree parsed-ows ::' rest , 2)
len-dec-rewrite {- P3-} ((Id "P3") :: _::_(InputChar '4') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '4'))) ::' rest , 2)
len-dec-rewrite {- P4-} ((Id "P4") :: _::_(InputChar '5') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '5'))) ::' rest , 2)
len-dec-rewrite {- P5-} ((Id "P5") :: _::_(InputChar '6') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '6'))) ::' rest , 2)
len-dec-rewrite {- P6-} ((Id "P6") :: _::_(InputChar '7') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '7'))) ::' rest , 2)
len-dec-rewrite {- P7-} ((Id "P7") :: _::_(InputChar '8') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '8'))) ::' rest , 2)
len-dec-rewrite {- P8-} ((Id "P8") :: _::_(InputChar '9') rest) = just (ParseTree (parsed-posdig-range-1 (string-append 0 (char-to-string '9'))) ::' rest , 2)
len-dec-rewrite {- P9-} ((Id "P9") :: _::_(ParseTree (parsed-posdig-range-1 x0)) rest) = just (ParseTree (parsed-posdig (string-append 0 x0)) ::' rest , 2)
len-dec-rewrite {- Pow-} ((Id "Pow") :: (InputChar '[') :: (ParseTree parsed-ows) :: (ParseTree (parsed-hpn x0)) :: (ParseTree parsed-ows) :: _::_(InputChar ']') rest) = just (ParseTree (parsed-atom (norm-atom (Pow x0))) ::' rest , 6)
len-dec-rewrite {- SeqNext-} ((Id "SeqNext") :: (ParseTree (parsed-atom x0)) :: (ParseTree parsed-ows) :: (InputChar '+') :: (ParseTree parsed-ows) :: _::_(ParseTree (parsed-hpn x1)) rest) = just (ParseTree (parsed-hpn (norm-hpn (SeqNext x0 x1))) ::' rest , 6)
len-dec-rewrite {- SeqStart-} ((Id "SeqStart") :: _::_(ParseTree (parsed-atom x0)) rest) = just (ParseTree (parsed-hpn (norm-hpn (SeqStart x0))) ::' rest , 2)
len-dec-rewrite {- Strt-} ((Id "Strt") :: (ParseTree parsed-ows) :: (ParseTree (parsed-cmds x0)) :: _::_(ParseTree parsed-ows) rest) = just (ParseTree (parsed-strt (norm-strt (Strt x0))) ::' rest , 4)
len-dec-rewrite {- ToDecimal-} ((Id "ToDecimal") :: (ParseTree (parsed-hpn x0)) :: (ParseTree parsed-ws) :: (InputChar 'b') :: (InputChar 'a') :: (InputChar 's') :: (InputChar 'e') :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-posnum x1)) rest) = just (ParseTree (parsed-cmd (norm-cmd (ToDecimal x0 x1))) ::' rest , 9)
len-dec-rewrite {- ToHpn-} ((Id "ToHpn") :: (ParseTree (parsed-posnum x0)) :: (ParseTree parsed-ws) :: (InputChar 'b') :: (InputChar 'a') :: (InputChar 's') :: (InputChar 'e') :: (ParseTree parsed-ws) :: _::_(ParseTree (parsed-posnum x1)) rest) = just (ParseTree (parsed-cmd (norm-cmd (ToHpn x0 x1))) ::' rest , 9)
len-dec-rewrite {- Zero-} ((Id "Zero") :: _::_(InputChar '0') rest) = just (ParseTree (parsed-hpn (norm-hpn Zero)) ::' rest , 2)
len-dec-rewrite {- P27-} (_::_(Id "P27") rest) = just (ParseTree parsed-ows-star-8 ::' rest , 1)
len-dec-rewrite {- Posinfo-} (_::_(Posinfo n) rest) = just (ParseTree (parsed-posinfo (ℕ-to-string n)) ::' rest , 1)
len-dec-rewrite x = nothing

rrs : rewriteRules
rrs = record { len-dec-rewrite = len-dec-rewrite }
