{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qrtn where

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

name4 = "rtn.gratr2-rule"
d4 = erased
name6 = "rtn.gratr2-rtn"
d6 a0 = ()
data T6 a0 a1 a2 a3 = C5 a0 a1 a2 a3
name16 = "rtn.gratr2-rtn.start"
d16 v0
  = case coe v0 of
      C5 v1 v2 v3 v4 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name18 = "rtn.gratr2-rtn._eq_"
d18 v0
  = case coe v0 of
      C5 v1 v2 v3 v4 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name20 = "rtn.gratr2-rtn.gratr2-start"
d20 v0
  = case coe v0 of
      C5 v1 v2 v3 v4 -> coe v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name22 = "rtn.gratr2-rtn.gratr2-return"
d22 v0
  = case coe v0 of
      C5 v1 v2 v3 v4 -> coe v4
      _ -> coe MAlonzo.RTE.mazUnreachableError