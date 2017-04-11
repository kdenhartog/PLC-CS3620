{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QstringZ45Zthms where

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

name4 = "string-thms.=string-refl"
d4
  = error
      "MAlonzo Runtime Error: postulate evaluated: string-thms.=string-refl"
name10 = "string-thms.=string-to-\8801"
d10
  = error
      "MAlonzo Runtime Error: postulate evaluated: string-thms.=string-to-\8801"
name16 = "string-thms.\8801string-to-="
d16 = erased