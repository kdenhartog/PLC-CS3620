{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qeq where

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

name8 = "eq._\8801_"
d8 a0 a1 a2 a3 = ()
data T8 = C16
name26 = "eq.sym"
d26 = erased
name38 = "eq.trans"
d38 = erased
name54 = "eq.cong"
d54 = erased
name74 = "eq.congf"
d74 = erased
name100 = "eq.congf2"
d100 = erased
name124 = "eq.cong2"
d124 = erased
name158 = "eq.cong3"
d158 = erased