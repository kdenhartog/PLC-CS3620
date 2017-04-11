{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QnatZ45Zlog where

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
import qualified MAlonzo.Code.QnatZ45Zdivision
import qualified MAlonzo.Code.Qproduct

name6 = "nat-log.log-result"
d6 a0 a1 = ()
data T6 a0 a1 = C16 a0 a1 | C18
name24 = "nat-log.log"
d24 v0 v1 v2 v3 = du24 v0 v1
du24 v0 v1
  = let v2 = coe MAlonzo.Code.QnatZ45Zdivision.du128 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qproduct.C24 v3 v4
        -> case coe v3 of
             0 -> case coe v4 of
                    MAlonzo.Code.Qproduct.C24 v5 v6
                      -> case coe v6 of
                           MAlonzo.Code.Qproduct.C24 v7 v8 -> coe C18
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> let v5 = coe subInt v3 (1 :: Integer) in
                  case coe v4 of
                    MAlonzo.Code.Qproduct.C24 v6 v7
                      -> case coe v7 of
                           MAlonzo.Code.Qproduct.C24 v8 v9
                             -> let v10 = coe du24 v3 v1 in
                                case coe v10 of
                                  C16 v11 v12
                                    -> coe
                                         C16 (coe addInt (1 :: Integer) v11)
                                         (coe addInt (coe mulInt v1 v12) v6)
                                  C18 -> coe C16 (1 :: Integer) (coe addInt (coe mulInt v1 v5) v6)
                                  _ -> coe MAlonzo.RTE.mazUnreachableError
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name98 = "nat-log._.lem"
d98 = erased
name138 = "nat-log._.lem"
d138 = erased