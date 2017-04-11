{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QmaybeZ45Zthms where

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
import qualified MAlonzo.Code.Qmaybe
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qsum

name10 = "maybe-thms.maybe-dec"
d10 v0 v1 v2 = du10 v2
du10 v0
  = case coe v0 of
      MAlonzo.Code.Qmaybe.C12 v1
        -> coe
             MAlonzo.Code.Qsum.C26 (coe MAlonzo.Code.Qproduct.C24 v1 erased)
      MAlonzo.Code.Qmaybe.C14 -> coe MAlonzo.Code.Qsum.C22 erased
      _ -> coe MAlonzo.RTE.mazUnreachableError