{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qproduct where

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

name10 = "product.\931"
d10 a0 a1 a2 a3 = ()
data T10 a0 a1 = C24 a0 a1
name34 = "product.\931i"
d34 a0 a1 a2 a3 = ()
data T34 a0 a1 = C48 a0 a1
name58 = "product._\215_"
d58 = erased
name74 = "product._i\215_"
d74 = erased
name88 = "product.\931-syntax"
d88 = erased
name98 = "product.fst"
d98 v0 v1 v2 v3 v4 = du98 v4
du98 v0
  = case coe v0 of
      C24 v1 v2 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name112 = "product.snd"
d112 v0 v1 v2 v3 v4 = du112 v4
du112 v0
  = case coe v0 of
      C24 v1 v2 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name134 = "product.\10216_,_\10217"
d134 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 = du134 v8 v9 v10
du134 v0 v1 v2
  = case coe v2 of
      C24 v3 v4 -> coe C24 (coe v0 v3) (coe v1 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name152 = "product.twist-\215"
d152 v0 v1 v2 v3 v4 = du152 v4
du152 v0
  = case coe v0 of
      C24 v1 v2 -> coe C24 v2 v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name170 = "product.rl-assoc-\215"
d170 v0 v1 v2 v3 v4 v5 v6 = du170 v6
du170 v0
  = case coe v0 of
      C24 v1 v2
        -> case coe v2 of
             C24 v3 v4 -> coe C24 (coe C24 v1 v3) v4
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name190 = "product.lr-assoc-\215"
d190 v0 v1 v2 v3 v4 v5 v6 = du190 v6
du190 v0
  = case coe v0 of
      C24 v1 v2
        -> case coe v1 of
             C24 v3 v4 -> coe C24 v3 (coe C24 v4 v2)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name206 = "product._\8743_"
d206 = erased
name216 = "product.\8707"
d216 = erased
name226 = "product.\8707i"
d226 = erased