{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QparseZ45Ztree where

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

name2 = "parse-tree.ParseTreeRec"
d2 = ()
newtype T2 a0 a1 a2 = C1 a0
name10 = "parse-tree.ParseTreeRec.ParseTreeT"
d10 = erased
name12 = "parse-tree.ParseTreeRec.isParseTree"
d12 = erased
name14 = "parse-tree.ParseTreeRec.ParseTreeToString"
d14 v0
  = case coe v0 of
      C1 v3 -> coe v3
      _ -> coe MAlonzo.RTE.mazUnreachableError