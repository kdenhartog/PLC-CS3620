{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qunit where

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

name2 = "unit.\8868"
d2 = ()
check4 :: ()
check4 = ()
cover2 :: () -> ()
cover2 x
  = case x of
      () -> ()
name4 = "unit.\8868.triv"
d4 :: ()
d4 = ()
name12 = "unit.single-range"
d12 = erased