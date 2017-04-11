{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qmaybe where

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

name6 = "maybe.maybe"
d6 a0 a1 = ()
data T6 a0 = C12 a0 | C14
name22 = "maybe._\8811=maybe_"
d22 v0 v1 v2 v3 v4 = du22 v3 v4
du22 v0 v1
  = case coe v0 of
      C12 v2 -> coe v1 v2
      C14 -> coe v0
      _ -> coe MAlonzo.RTE.mazUnreachableError
name34 = "maybe.return-maybe"
d34 v0 v1 v2 = du34 v2
du34 v0 = coe C12 v0
name46 = "maybe.down-\8801"
d46 = erased
name52 = "maybe.isJust"
d52 v0 v1 v2 = du52 v2
du52 v0
  = case coe v0 of
      C12 v1 -> coe True
      C14 -> coe False
      _ -> coe MAlonzo.RTE.mazUnreachableError
name60 = "maybe.maybe-extract"
d60 v0 v1 v2 v3 = du60 v2
du60 v0
  = case coe v0 of
      C12 v1 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name72 = "maybe.maybe-map"
d72 v0 v1 v2 v3 v4 = du72 v3 v4
du72 v0 v1
  = case coe v1 of
      C12 v2 -> coe C12 (coe v0 v2)
      C14 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError