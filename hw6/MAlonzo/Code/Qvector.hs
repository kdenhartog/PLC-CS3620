{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qvector where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.QlistZ45ZtoZ45Zstring
import qualified MAlonzo.Code.Qproduct

name6 = "vector.\120141"
d6 a0 a1 a2 = ()
data T6 a0 a1 a2 = C12 | C16 a0 a1 a2
name18 = "vector.vector"
d18 = erased
name24 = "vector.[_]\120141"
d24 v0 v1 v2 = du24 v2
du24 v0 = coe C16 (0 :: Integer) v0 C12
name36 = "vector._++\120141_"
d36 v0 v1 v2 v3 v4 v5 = du36 v3 v4 v5
du36 v0 v1 v2
  = case coe v1 of
      C12 -> coe v2
      C16 v3 v4 v5 -> coe C16 (coe addInt v0 v3) v4 (coe du36 v0 v5 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name52 = "vector.head\120141"
d52 v0 v1 v2 v3 = du52 v3
du52 v0
  = case coe v0 of
      C16 v1 v2 v3 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name62 = "vector.tail\120141"
d62 v0 v1 v2 v3 = du62 v3
du62 v0
  = case coe v0 of
      C12 -> coe v0
      C16 v1 v2 v3 -> coe v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name76 = "vector.map\120141"
d76 v0 v1 v2 v3 v4 v5 v6 = du76 v5 v6
du76 v0 v1
  = case coe v1 of
      C12 -> coe v1
      C16 v2 v3 v4 -> coe C16 v2 (coe v0 v3) (coe du76 v0 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name94 = "vector.concat\120141"
d94 v0 v1 v2 v3 v4 = du94 v2 v4
du94 v0 v1
  = case coe v1 of
      C12 -> coe v1
      C16 v2 v3 v4 -> coe du36 (coe mulInt v2 v0) v3 (coe du94 v0 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name108 = "vector.nth\120141"
d108 v0 v1 v2 v3 v4 v5 = du108 v3 v5
du108 v0 v1
  = case coe v0 of
      0 -> case coe v1 of
             C16 v2 v3 v4 -> coe v3
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             C16 v3 v4 v5 -> coe du108 v2 v5
             _ -> coe MAlonzo.RTE.mazUnreachableError
name128 = "vector.repeat\120141"
d128 v0 v1 v2 v3 = du128 v2 v3
du128 v0 v1
  = case coe v1 of
      0 -> coe C12
      _ -> let v2 = coe subInt v1 (1 :: Integer) in
           coe C16 v2 v0 (coe du128 v0 v2)
name146 = "vector.foldl\120141"
d146 v0 v1 v2 v3 v4 v5 v6 v7 = du146 v4 v5 v7
du146 v0 v1 v2
  = case coe v2 of
      C12 -> coe v2
      C16 v3 v4 v5
        -> coe C16 v3 (coe v1 v0 v4) (coe du146 (coe v1 v0 v4) v1 v5)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name176 = "vector.zipWith\120141"
d176 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 = du176 v6 v8 v9
du176 v0 v1 v2
  = case coe v1 of
      C12 -> coe seq v2 v1
      C16 v3 v4 v5
        -> case coe v2 of
             C16 v6 v7 v8 -> coe C16 v3 (coe v0 v4 v7) (coe du176 v0 v5 v8)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name198 = "vector.allh\120141"
d198 v0 v1 v2 v3 v4 v5 = du198 v3 v4 v5
du198 v0 v1 v2
  = case coe v1 of
      C12 -> coe True
      C16 v3 v4 v5
        -> coe
             MAlonzo.Code.Qbool.d12 (coe v0 v2 v4)
             (coe du198 v0 v5 (coe addInt (1 :: Integer) v2))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name220 = "vector.all\120141"
d220 v0 v1 v2 v3 v4 = du220 v3 v4
du220 v0 v1 = coe du198 v0 v1 (0 :: Integer)
name232 = "vector.\120141-to-\120131"
d232 v0 v1 v2 v3 = du232 v3
du232 v0
  = case coe v0 of
      C12 -> coe MAlonzo.Code.Qlist.C12
      C16 v1 v2 v3 -> coe MAlonzo.Code.Qlist.C18 v2 (coe du232 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name244 = "vector.\120131-to-\120141"
d244 v0 v1 v2 = du244 v2
du244 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12
        -> coe MAlonzo.Code.Qproduct.C24 (0 :: Integer) C12
      MAlonzo.Code.Qlist.C18 v1 v2
        -> let v3 = coe du244 v2 in
           case coe v3 of
             MAlonzo.Code.Qproduct.C24 v4 v5
               -> coe
                    MAlonzo.Code.Qproduct.C24 (coe addInt (1 :: Integer) v4)
                    (coe C16 v4 v1 v5)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name272 = "vector.\120141-to-string"
d272 v0 v1 v2 v3 v4 v5 = du272 v3 v4 v5
du272 v0 v1 v2
  = coe MAlonzo.Code.QlistZ45ZtoZ45Zstring.du10 v0 v1 (coe du232 v2)