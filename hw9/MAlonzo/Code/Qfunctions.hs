{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qfunctions where

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

name14 = "functions._\8728_"
d14 v0 v1 v2 v3 v4 v5 v6 v7 v8 = du14 v6 v7 v8
du14 v0 v1 v2 = coe v0 (coe v1 v2)
name44 = "functions.\8728-assoc"
d44 = erased
name56 = "functions.id"
d56 v0 v1 v2 = du56 v2
du56 v0 = coe v0
name70 = "functions.\8728-id"
d70 = erased
name84 = "functions.id-\8728"
d84 = erased
name92 = "functions.extensionality"
d92 = erased
name116 = "functions.Iso"
d116 a0 a1 a2 a3 = ()
data T116 a0 a1 a2 a3 = C142 a0 a1
name134 = "functions.Iso.l-inv"
d134 v0
  = case coe v0 of
      C142 v1 v2 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name136 = "functions.Iso.r-inv"
d136 v0
  = case coe v0 of
      C142 v1 v2 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name138 = "functions.Iso.l-cancel"
d138 = erased
name140 = "functions.Iso.r-cancel"
d140 = erased