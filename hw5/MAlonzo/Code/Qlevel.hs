{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qlevel where

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
import qualified MAlonzo.Code.Agda.Primitive

name2 = "level.level"
d2 = erased
name4 = "level.lone"
d4
  = coe
      MAlonzo.Code.Agda.Primitive.d10 MAlonzo.Code.Agda.Primitive.d6
name12 = "level.Lift"
d12 a0 a1 a2 = ()
newtype T12 a0 = C24 a0
name22 = "level.Lift.lower"
d22 v0
  = case coe v0 of
      C24 v1 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError