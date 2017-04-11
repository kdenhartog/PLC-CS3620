{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QnatZ45Zthms where

import MAlonzo.RTE (coe, erased, addInt, subInt, mulInt, quotInt,
                    remInt, geqInt, ltInt, eqInt, eqFloat)
import qualified Control.DeepSeq
import qualified Data.Text.IO
import qualified MAlonzo.RTE
import qualified System.Directory
import qualified System.Environment
import qualified System.FilePath
import qualified System.IO
import qualified Data.Text
import qualified MAlonzo.Code.Qbool
import qualified MAlonzo.Code.QboolZ45Zthms
import qualified MAlonzo.Code.QboolZ45Zthms2
import qualified MAlonzo.Code.Qnat
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.QproductZ45Zthms
import qualified MAlonzo.Code.Qsum

name4 = "nat-thms.0+"
d4 = erased
name10 = "nat-thms.+0"
d10 = erased
name20 = "nat-thms.+1"
d20 = erased
name32 = "nat-thms.+suc"
d32 = erased
name50 = "nat-thms.+assoc"
d50 = erased
name70 = "nat-thms.+comm"
d70 = erased
name96 = "nat-thms.+perm"
d96 = erased
name122 = "nat-thms.+perm2"
d122 = erased
name146 = "nat-thms.+\8801\&0"
d146 v0 v1 v2 = du146
du146 = coe MAlonzo.Code.Qproduct.C24 erased erased
name160 = "nat-thms.*0"
d160 = erased
name170 = "nat-thms.*1"
d170 = erased
name182 = "nat-thms.*suc"
d182 = erased
name212 = "nat-thms.*distribr"
d212 = erased
name234 = "nat-thms.*distribl"
d234 = erased
name274 = "nat-thms.*comm"
d274 = erased
name300 = "nat-thms.*assoc"
d300 = erased
name322 = "nat-thms.sucpred"
d322 = erased
name332 = "nat-thms.pred+"
d332 = erased
name344 = "nat-thms.<-0"
d344 = erased
name350 = "nat-thms.0-\8804"
d350 = erased
name358 = "nat-thms.<-drop"
d358 v0 v1 v2 = du358 v0 v1
du358 v0 v1
  = case coe v0 of
      0 -> case coe v1 of
             0 -> coe MAlonzo.Code.Qsum.C22 erased
             _ -> coe MAlonzo.Code.Qsum.C26 erased
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             0 -> coe MAlonzo.Code.QboolZ45Zthms.d106 erased () erased
             _ -> let v3 = coe subInt v1 (1 :: Integer) in coe du358 v2 v3
name406 = "nat-thms.=\8469-refl"
d406 = erased
name414 = "nat-thms.=\8469-to-\8801"
d414 = erased
name436 = "nat-thms.=\8469-from-\8801"
d436 = erased
name444 = "nat-thms.=\8469-sym"
d444 = erased
name460 = "nat-thms.=\8469-suc"
d460 = erased
name466 = "nat-thms.<-suc"
d466 = erased
name476 = "nat-thms.<-suc2"
d476 = erased
name482 = "nat-thms.\8804-suc"
d482 = erased
name492 = "nat-thms.\8804-suc2"
d492 = erased
name510 = "nat-thms.<-push"
d510 v0 v1 v2 = du510 v0 v1
du510 v0 v1
  = let v2 = coe subInt v1 (1 :: Integer) in
    case coe v0 of
      0 -> coe MAlonzo.Code.Qproduct.C24 v2 erased
      _ -> let v3 = coe subInt v0 (1 :: Integer) in
           let v4 = coe du510 v3 v2 in
           case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6
               -> coe
                    MAlonzo.Code.Qproduct.C24 (coe addInt (1 :: Integer) v5) erased
             _ -> coe MAlonzo.RTE.mazUnreachableError
name546 = "nat-thms.suc-inj"
d546 = erased
name564 = "nat-thms.<-implies-suc"
d564 v0 v1 v2 = du564 v1
du564 v0
  = case coe v0 of
      0 -> coe MAlonzo.Code.QboolZ45Zthms.d106 erased () erased
      _ -> let v1 = coe subInt v0 (1 :: Integer) in
           coe MAlonzo.Code.Qproduct.C24 v1 erased
name580 = "nat-thms.<=\8469ff"
d580 = erased
name588 = "nat-thms.nonzero<"
d588 = erased
name598 = "nat-thms.iszerosum"
d598 = erased
name610 = "nat-thms.iszerosum2"
d610 = erased
name622 = "nat-thms.iszeromult"
d622 = erased
name646 = "nat-thms.<\8804"
d646 = erased
name662 = "nat-thms.\8804+1"
d662 = erased
name688 = "nat-thms.\8804+2"
d688 = erased
name706 = "nat-thms.\247<"
d706 = erased
name770 = "nat-thms.<-irrefl"
d770 = erased
name778 = "nat-thms.<-asym"
d778 = erased
name796 = "nat-thms.\8469-trichotomy\120121"
d796 = erased
name810 = "nat-thms.\8469-trichotomy"
d810 v0 v1
  = let v2
          = coe
              MAlonzo.Code.QboolZ45Zthms.du112 (coe MAlonzo.Code.Qnat.d44 v0 v1)
              (coe
                 MAlonzo.Code.Qbool.d18 (coe MAlonzo.Code.Qnat.d54 v0 v1)
                 (coe MAlonzo.Code.Qnat.d44 v1 v0)) in
    case coe v2 of
      MAlonzo.Code.Qsum.C22 v3 -> coe v2
      MAlonzo.Code.Qsum.C26 v3
        -> let v4
                 = coe
                     MAlonzo.Code.QboolZ45Zthms.du112 (coe MAlonzo.Code.Qnat.d54 v0 v1)
                     (coe MAlonzo.Code.Qnat.d44 v1 v0) in
           case coe v4 of
             MAlonzo.Code.Qsum.C22 v5 -> coe MAlonzo.Code.Qsum.C26 v4
             MAlonzo.Code.Qsum.C26 v5 -> coe MAlonzo.Code.Qsum.C26 v4
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name858 = "nat-thms.<-insert"
d858 v0 v1 v2 v3
  = let v4 = coe d810 v0 v1 in
    case coe v4 of
      MAlonzo.Code.Qsum.C22 v5 -> coe v4
      MAlonzo.Code.Qsum.C26 v5
        -> case coe v5 of
             MAlonzo.Code.Qsum.C22 v6
               -> coe MAlonzo.Code.Qsum.C26 (coe MAlonzo.Code.Qsum.C22 v3)
             MAlonzo.Code.Qsum.C26 v6
               -> let v7 = coe d810 v0 v2 in
                  case coe v7 of
                    MAlonzo.Code.Qsum.C22 v8
                      -> coe MAlonzo.Code.Qsum.C26 (coe MAlonzo.Code.Qsum.C22 erased)
                    MAlonzo.Code.Qsum.C26 v8
                      -> case coe v8 of
                           MAlonzo.Code.Qsum.C22 v9
                             -> coe MAlonzo.Code.Qsum.C26 (coe MAlonzo.Code.Qsum.C22 erased)
                           MAlonzo.Code.Qsum.C26 v9 -> coe v7
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name976 = "nat-thms.<-insert2"
d976 v0 v1 v2 v3 = du976 v0 v1 v2
du976 v0 v1 v2
  = let v3 = coe d858 v0 v1 v2 erased in
    case coe v3 of
      MAlonzo.Code.Qsum.C22 v4 -> coe v3
      MAlonzo.Code.Qsum.C26 v4
        -> case coe v4 of
             MAlonzo.Code.Qsum.C22 v5
               -> let v6
                        = coe
                            MAlonzo.Code.QboolZ45Zthms2.du136 (coe MAlonzo.Code.Qnat.d60 v1 v0)
                            (coe MAlonzo.Code.Qnat.d60 v0 v2) in
                  case coe v6 of
                    MAlonzo.Code.Qproduct.C24 v7 v8
                      -> coe MAlonzo.Code.Qsum.C26 (coe MAlonzo.Code.Qsum.C22 v6)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             MAlonzo.Code.Qsum.C26 v5 -> coe v3
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name1044 = "nat-thms.<-trans"
d1044 = erased
name1090 = "nat-thms.<\8804-trans"
d1090 = erased
name1140 = "nat-thms.\8804<-trans"
d1140 = erased
name1186 = "nat-thms.\8804-refl"
d1186 = erased
name1196 = "nat-thms.\8804-trans"
d1196 = erased
name1308 = "nat-thms.suc\8804"
d1308 = erased
name1320 = "nat-thms.suc\8804<"
d1320 = erased
name1330 = "nat-thms.suc<<"
d1330 = erased
name1340 = "nat-thms.<-suc-trans"
d1340 = erased
name1356 = "nat-thms.\8804-suc-trans"
d1356 = erased
name1372 = "nat-thms.<+"
d1372 = erased
name1388 = "nat-thms.<+2"
d1388 = erased
name1400 = "nat-thms.<-iter-suc-trans-t-h"
d1400 = erased
name1416 = "nat-thms.<-iter-suc-trans-t"
d1416 = erased
name1428 = "nat-thms.<-iter-suc-trans-h"
d1428 = erased
name1448 = "nat-thms.<-iter-suc-trans"
d1448 = erased
name1456 = "nat-thms.\8804\&0"
d1456 = erased
name1462 = "nat-thms.\8804\&2*"
d1462 = erased
name1478 = "nat-thms.0<+"
d1478 = erased
name1492 = "nat-thms.<=\8469ff2"
d1492 = erased
name1502 = "nat-thms.*\8804"
d1502 = erased
name1514 = "nat-thms.\8804ff"
d1514 = erased
name1534 = "nat-thms.<ff"
d1534 = erased
name1594 = "nat-thms.<-not-=\8469"
d1594 = erased
name1612 = "nat-thms.<-not->"
d1612 = erased
name1630 = "nat-thms.<tt"
d1630 = erased
name1650 = "nat-thms.\8804-antisym"
d1650 = erased
name1708 = "nat-thms.<+mono1"
d1708 = erased
name1722 = "nat-thms.<+mono2"
d1722 = erased
name1746 = "nat-thms.0\8760"
d1746 = erased
name1754 = "nat-thms.\8760\8804"
d1754 = erased
name1800 = "nat-thms.\8760<"
d1800 = erased
name1832 = "nat-thms.\8760<1"
d1832 = erased
name1846 = "nat-thms.+\8760\&1"
d1846 = erased
name1868 = "nat-thms.\8760+"
d1868 = erased
name1888 = "nat-thms.\8760+2"
d1888 = erased
name1918 = "nat-thms.\8760eq-swap"
d1918 = erased
name1934 = "nat-thms._.lem"
d1934 = erased
name1948 = "nat-thms.<\8760"
d1948 = erased
name1984 = "nat-thms.<\8760suc"
d1984 v0 v1 v2 = du1984 v0 v1
du1984 v0 v1
  = let v2
          = coe
              MAlonzo.Code.QproductZ45Zthms.du10
              (coe MAlonzo.Code.Qnat.d30 v0 v1) in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v3 of
             0 -> coe erased
             _ -> let v5 = coe subInt v3 (1 :: Integer) in
                  coe MAlonzo.Code.Qproduct.C24 v5 v4
      _ -> coe MAlonzo.RTE.mazUnreachableError
name2052 = "nat-thms.\8760suc"
d2052 = erased
name2072 = "nat-thms.\8760suc2"
d2072 = erased
name2092 = "nat-thms.\8760cancel"
d2092 = erased
name2110 = "nat-thms.distribr*\8760"
d2110 = erased
name2148 = "nat-thms.\8760\8804\&2"
d2148 = erased
name2222 = "nat-thms.min-forced1"
d2222 = erased
name2266 = "nat-thms.min-suc"
d2266 = erased
name2280 = "nat-thms.max-suc"
d2280 = erased
name2296 = "nat-thms.min-mono1"
d2296 = erased
name2508 = "nat-thms.min-comm"
d2508 = erased
name2562 = "nat-thms.min-mono2"
d2562 = erased
name2582 = "nat-thms.min-same"
d2582 = erased
name2594 = "nat-thms.min-<1"
d2594 = erased
name2612 = "nat-thms.min-<2"
d2612 = erased
name2630 = "nat-thms.max-<1"
d2630 = erased
name2656 = "nat-thms.max-<2"
d2656 = erased
name2682 = "nat-thms.+\8802"
d2682 = erased
name2720 = "nat-thms.parity-even"
d2720 = erased
name2730 = "nat-thms.parity-even2"
d2730 = erased
name2740 = "nat-thms.parity-odd"
d2740 = erased
name2752 = "nat-thms.parity-add"
d2752 = erased
name2776 = "nat-thms.parity-mult"
d2776 = erased
name2794 = "nat-thms.1-pow"
d2794 = erased
name2806 = "nat-thms.nonzero-pow"
d2806 = erased
name2828 = "nat-thms.pow+"
d2828 = erased
name2858 = "nat-thms.pow*"
d2858 = erased
name2892 = "nat-thms.factorial-nonzero"
d2892 = erased
name2910 = "nat-thms.+inj1"
d2910 = erased
name2932 = "nat-thms.+inj2"
d2932 = erased
name2952 = "nat-thms.even~odd"
d2952 = erased
name2956 = "nat-thms.odd~even"
d2956 = erased