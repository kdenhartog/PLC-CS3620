{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QnatZ45ZtoZ45Zstring where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qmaybe
import qualified MAlonzo.Code.QnatZ45Zdivision
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qstring
import qualified MAlonzo.Code.Qtermination

name8 = "nat-to-string.slow-\8469-to-digits.\8469-to-digitsh"
d8 v0 v1 v2 v3 = du8 v0 v2 v3
du8 v0 v1 v2
  = case coe v1 of
      0 -> coe MAlonzo.Code.Qlist.C12
      _ -> case coe v2 of
             MAlonzo.Code.Qtermination.C24 v3 v4
               -> let v5 = coe MAlonzo.Code.QnatZ45Zdivision.du128 v1 v0 in
                  case coe v5 of
                    MAlonzo.Code.Qproduct.C24 v6 v7
                      -> case coe v7 of
                           MAlonzo.Code.Qproduct.C24 v8 v9
                             -> case coe v9 of
                                  MAlonzo.Code.Qproduct.C24 v10 v11
                                    -> coe
                                         MAlonzo.Code.Qlist.C18 v8
                                         (coe du8 v0 v6 (coe v4 v6 erased))
                                  _ -> coe MAlonzo.RTE.mazUnreachableError
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
name36 = "nat-to-string.slow-\8469-to-digits.\8469-to-digits"
d36 v0
  = coe
      MAlonzo.Code.Qlist.du256
      (coe du8 (10 :: Integer) v0 (coe MAlonzo.Code.Qtermination.d48 v0))
name44 = "nat-to-string.\8469-to-digitsh"
d44 v0 v1 v2 = du44 v0 v2
du44 v0 v1
  = case coe v1 of
      0 -> coe MAlonzo.Code.Qlist.C12
      _ -> let v2 = coe MAlonzo.Code.QnatZ45Zdivision.du128 v1 v0 in
           case coe v2 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> case coe v4 of
                    MAlonzo.Code.Qproduct.C24 v5 v6
                      -> coe MAlonzo.Code.Qlist.C18 v5 (coe du44 v0 v3)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
name68 = "nat-to-string.\8469-to-digits"
d68 v0 = coe MAlonzo.Code.Qlist.du256 (coe du44 (10 :: Integer) v0)
name72 = "nat-to-string.digit-to-string"
d72 v0
  = case coe v0 of
      0 -> coe Data.Text.pack "0"
      1 -> coe Data.Text.pack "1"
      2 -> coe Data.Text.pack "2"
      3 -> coe Data.Text.pack "3"
      4 -> coe Data.Text.pack "4"
      5 -> coe Data.Text.pack "5"
      6 -> coe Data.Text.pack "6"
      7 -> coe Data.Text.pack "7"
      8 -> coe Data.Text.pack "8"
      9 -> coe Data.Text.pack "9"
      _ -> coe Data.Text.pack "unexpected-digit"
name74 = "nat-to-string.digits-to-string"
d74 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v1 v2
        -> coe MAlonzo.Code.Qstring.d12 (coe d72 v1) (coe d74 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name80 = "nat-to-string.\8469-to-string"
d80 v0
  = case coe v0 of
      0 -> coe Data.Text.pack "0"
      _ -> coe d74 (coe d68 v0)
name84 = "nat-to-string.string-to-digit"
d84 v0
  = case coe v0 of
      '0' -> coe MAlonzo.Code.Qmaybe.C12 (0 :: Integer)
      '1' -> coe MAlonzo.Code.Qmaybe.C12 (1 :: Integer)
      '2' -> coe MAlonzo.Code.Qmaybe.C12 (2 :: Integer)
      '3' -> coe MAlonzo.Code.Qmaybe.C12 (3 :: Integer)
      '4' -> coe MAlonzo.Code.Qmaybe.C12 (4 :: Integer)
      '5' -> coe MAlonzo.Code.Qmaybe.C12 (5 :: Integer)
      '6' -> coe MAlonzo.Code.Qmaybe.C12 (6 :: Integer)
      '7' -> coe MAlonzo.Code.Qmaybe.C12 (7 :: Integer)
      '8' -> coe MAlonzo.Code.Qmaybe.C12 (8 :: Integer)
      '9' -> coe MAlonzo.Code.Qmaybe.C12 (9 :: Integer)
      _ -> coe MAlonzo.Code.Qmaybe.C14
name86 = "nat-to-string.digits-to-\8469h"
d86 v0 v1 v2
  = case coe v2 of
      MAlonzo.Code.Qlist.C12 -> coe v1
      MAlonzo.Code.Qlist.C18 v3 v4
        -> coe
             d86 (coe mulInt (10 :: Integer) v0)
             (coe addInt (coe mulInt v3 v0) v1) v4
      _ -> coe MAlonzo.RTE.mazUnreachableError
name100 = "nat-to-string.digits-to-\8469"
d100 v0 = coe d86 (1 :: Integer) (0 :: Integer) v0
name104 = "nat-to-string.string-to-\8469"
d104 v0
  = let v1
          = coe
              MAlonzo.Code.Qlist.du156 d84
              (coe MAlonzo.Code.Qlist.du256 (coe MAlonzo.Code.Qstring.d14 v0)) in
    case coe v1 of
      MAlonzo.Code.Qmaybe.C12 v2
        -> coe MAlonzo.Code.Qmaybe.C12 (coe d100 v2)
      MAlonzo.Code.Qmaybe.C14 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name118 = "nat-to-string.string-to-\8469\&0"
d118 v0
  = let v1 = coe d104 v0 in
    case coe v1 of
      MAlonzo.Code.Qmaybe.C12 v2 -> coe v2
      MAlonzo.Code.Qmaybe.C14 -> 0 :: Integer
      _ -> coe MAlonzo.RTE.mazUnreachableError