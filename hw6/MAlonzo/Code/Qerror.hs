{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qerror where

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

name6 = "error.error-t"
d6 a0 a1 = ()
data T6 a0 = C12 a0 | C14 a0
name24 = "error._\8811=err_"
d24 v0 v1 v2 v3 v4 v5 = du24 v4 v5
du24 v0 v1
  = case coe v0 of
      C12 v2 -> coe v1 v2
      C14 v2 -> coe v0
      _ -> coe MAlonzo.RTE.mazUnreachableError
name40 = "error._\8811err_"
d40 v0 v1 v2 v3 v4 v5 = du40 v4 v5
du40 v0 v1 = coe du24 v0 (\ v2 -> v1)