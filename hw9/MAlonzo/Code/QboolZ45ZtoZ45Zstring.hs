{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QboolZ45ZtoZ45Zstring where

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

name2 = "bool-to-string.\120121-to-string"
d2 v0
  = case coe v0 of
      True -> coe Data.Text.pack "tt"
      False -> coe Data.Text.pack "ff"
      _ -> coe MAlonzo.RTE.mazUnreachableError