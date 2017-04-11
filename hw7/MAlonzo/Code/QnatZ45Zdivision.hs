{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QnatZ45Zdivision where

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
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.QproductZ45Zthms

name2 = "nat-division.div-result"
d2 = erased
name18 = "nat-division.divh"
d18 v0 v1 v2 v3 v4 = du18 v0 v1 v2
du18 v0 v1 v2
  = case coe v0 of
      0 -> coe
             MAlonzo.Code.Qproduct.C24 (0 :: Integer)
             (coe
                MAlonzo.Code.Qproduct.C24 (0 :: Integer)
                (coe MAlonzo.Code.Qproduct.C24 erased erased))
      _ -> let v3 = coe subInt v0 (1 :: Integer) in
           let v4
                 = coe
                     MAlonzo.Code.QproductZ45Zthms.du10
                     (coe MAlonzo.Code.Qnat.d44 v1 v2) in
           case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6
               -> case coe v5 of
                    True
                      -> coe
                           MAlonzo.Code.Qproduct.C24 (0 :: Integer)
                           (coe
                              MAlonzo.Code.Qproduct.C24 v1
                              (coe MAlonzo.Code.Qproduct.C24 erased v6))
                    False
                      -> let v7 = coe du18 v3 (coe MAlonzo.Code.Qnat.d30 v1 v2) v2 in
                         case coe v7 of
                           MAlonzo.Code.Qproduct.C24 v8 v9
                             -> case coe v9 of
                                  MAlonzo.Code.Qproduct.C24 v10 v11
                                    -> case coe v11 of
                                         MAlonzo.Code.Qproduct.C24 v12 v13
                                           -> coe
                                                MAlonzo.Code.Qproduct.C24
                                                (coe addInt (1 :: Integer) v8)
                                                (coe
                                                   MAlonzo.Code.Qproduct.C24 v10
                                                   (coe MAlonzo.Code.Qproduct.C24 erased v13))
                                         _ -> coe MAlonzo.RTE.mazUnreachableError
                                  _ -> coe MAlonzo.RTE.mazUnreachableError
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
name104 = "nat-division._.lem"
d104 = erased
name128 = "nat-division._\247_!_"
d128 v0 v1 v2 = du128 v0 v1
du128 v0 v1 = coe du18 v0 v0 v1
name138 = "nat-division._\247_!!_"
d138 v0 v1 v2 = du138 v0 v1
du138 v0 v1
  = let v2 = coe du128 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6
               -> coe MAlonzo.Code.Qproduct.C24 v3 v5
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name164 = "nat-division._\247_div_"
d164 v0 v1 v2 = du164 v0 v1
du164 v0 v1
  = let v2 = coe du128 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6 -> coe v3
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name190 = "nat-division._\247_mod_"
d190 v0 v1 v2 = du190 v0 v1
du190 v0 v1
  = let v2 = coe du128 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v4 of
             MAlonzo.Code.Qproduct.C24 v5 v6 -> coe v5
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name218 = "nat-division._\247_"
d218 v0 v1
  = let v2
          = coe
              MAlonzo.Code.QproductZ45Zthms.du10
              (coe MAlonzo.Code.Qnat.d54 v1 (0 :: Integer)) in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v3 of
             True -> coe MAlonzo.Code.Qproduct.C24 (0 :: Integer) (0 :: Integer)
             False -> coe du138 v0 v1
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError