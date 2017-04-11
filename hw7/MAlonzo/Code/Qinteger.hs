{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qinteger where

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
import qualified MAlonzo.Code.Qnat
import qualified MAlonzo.Code.QnatZ45Zthms
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qsum

name2 = "integer.\8484-pos-t"
d2 = erased
name4 = "integer.\8484"
d4 = ()
data T4 a0 a1 = C8 a0 a1
name10 = "integer.0\8484"
d10 = coe C8 (0 :: Integer) erased
name12 = "integer.1\8484"
d12 = coe C8 (1 :: Integer) True
name14 = "integer.-1\8484"
d14 = coe C8 (1 :: Integer) False
name16 = "integer.abs-val"
d16 v0
  = case coe v0 of
      C8 v1 v2 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name20 = "integer.is-even\8484"
d20 v0
  = case coe v0 of
      C8 v1 v2 -> coe MAlonzo.Code.Qnat.d126 v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name24 = "integer.is-odd\8484"
d24 v0
  = case coe v0 of
      C8 v1 v2 -> coe MAlonzo.Code.Qnat.d128 v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name28 = "integer.diff\8484"
d28 v0 v1
  = let v2 = coe MAlonzo.Code.QnatZ45Zthms.d810 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qsum.C22 v3
        -> let v4 = coe MAlonzo.Code.QnatZ45Zthms.du1984 v1 v0 in
           case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6
               -> coe C8 (coe addInt (1 :: Integer) v5) False
             _ -> coe MAlonzo.RTE.mazUnreachableError
      MAlonzo.Code.Qsum.C26 v3
        -> case coe v3 of
             MAlonzo.Code.Qsum.C22 v4 -> coe C8 (0 :: Integer) erased
             MAlonzo.Code.Qsum.C26 v4
               -> let v5 = coe MAlonzo.Code.QnatZ45Zthms.du1984 v0 v1 in
                  case coe v5 of
                    MAlonzo.Code.Qproduct.C24 v6 v7
                      -> coe C8 (coe addInt (1 :: Integer) v6) True
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name80 = "integer._+\8484_"
d80 v0 v1
  = case coe v0 of
      C8 v2 v3
        -> case coe v2 of
             0 -> coe v1
             _ -> let v4 = coe subInt v2 (1 :: Integer) in
                  case coe v1 of
                    C8 v5 v6
                      -> case coe v5 of
                           0 -> coe v0
                           _ -> let v7 = coe subInt v5 (1 :: Integer) in
                                let v8 = coe MAlonzo.Code.Qbool.d56 v3 v6 in
                                case coe v8 of
                                  True
                                    -> coe
                                         MAlonzo.Code.Qbool.du28 (coe MAlonzo.Code.Qbool.d58 v3 v6)
                                         (coe d28 v7 v4) (coe d28 v4 v7)
                                  False -> coe C8 (coe addInt v2 v5) v3
                                  _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name114 = "integer.test-+\8484\&1"
d114 = erased
name116 = "integer.test-+\8484\&2"
d116 = erased
name118 = "integer._\8804\8484_"
d118 v0 v1
  = case coe v0 of
      C8 v2 v3
        -> case coe v2 of
             0 -> case coe v1 of
                    C8 v4 v5
                      -> case coe v4 of
                           0 -> coe True
                           _ -> coe v5
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> let v4 = coe subInt v2 (1 :: Integer) in
                  case coe v1 of
                    C8 v5 v6
                      -> case coe v5 of
                           0 -> coe MAlonzo.Code.Qbool.d10 v3
                           _ -> let v7 = coe subInt v5 (1 :: Integer) in
                                let v8 = coe MAlonzo.Code.Qbool.d56 v3 v6 in
                                case coe v8 of
                                  True -> coe MAlonzo.Code.Qbool.d58 v3 v6
                                  False
                                    -> coe
                                         MAlonzo.Code.Qbool.du28 v3
                                         (coe MAlonzo.Code.Qnat.d60 v4 v7)
                                         (coe MAlonzo.Code.Qnat.d60 v7 v4)
                                  _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name156 = "integer.\8804\8484-antisymm"
d156 = erased