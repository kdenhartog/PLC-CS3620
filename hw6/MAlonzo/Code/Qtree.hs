{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qtree where

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
import qualified MAlonzo.Code.Qstring

name6 = "tree.\120139"
d6 a0 a1 = ()
data T6 a0 a1 = C12 a0 a1
name18 = "tree.leaf"
d18 v0 v1 v2 = du18 v2
du18 v0 = coe C12 v0 MAlonzo.Code.Qlist.C12
name30 = "tree.\120139-to-string"
d30 v0 v1 v2 v3 = du30 v0 v2 v3
du30 v0 v1 v2
  = case coe v2 of
      C12 v3 v4
        -> let v5
                 = coe
                     MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(")
                     (coe
                        MAlonzo.Code.Qstring.d12 (coe v1 v3)
                        (coe
                           MAlonzo.Code.Qstring.d12 (coe du40 v0 v1 v4)
                           (coe Data.Text.pack ")"))) in
           case coe v4 of
             MAlonzo.Code.Qlist.C12 -> coe v1 v3
             _ -> coe v5
      _ -> coe MAlonzo.RTE.mazUnreachableError
name40 = "tree.\120139s-to-string"
d40 v0 v1 v2 v3 = du40 v0 v2 v3
du40 v0 v1 v2
  = case coe v2 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
             (coe
                MAlonzo.Code.Qstring.d12 (coe du30 v0 v1 v3) (coe du40 v0 v1 v4))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name64 = "tree.perfect-binary-tree"
d64 v0 v1 v2 v3 = du64 v2 v3
du64 v0 v1
  = case coe v0 of
      0 -> coe C12 v1 MAlonzo.Code.Qlist.C12
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           coe
             C12 v1
             (coe
                MAlonzo.Code.Qlist.C18 (coe du64 v2 v1)
                (coe
                   MAlonzo.Code.Qlist.C18 (coe du64 v2 v1) MAlonzo.Code.Qlist.C12))
name78 = "tree.size\120139"
d78 v0 v1 v2 = du78 v0 v2
du78 v0 v1
  = case coe v1 of
      C12 v2 v3 -> coe addInt (1 :: Integer) (coe du84 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name84 = "tree.size\120139s"
d84 v0 v1 v2 = du84 v0 v2
du84 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> 0 :: Integer
      MAlonzo.Code.Qlist.C18 v2 v3
        -> coe addInt (coe du84 v0 v3) (coe du78 v0 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name102 = "tree.size-perfect"
d102 = erased