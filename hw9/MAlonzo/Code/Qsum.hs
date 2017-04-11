{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qsum where

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

name10 = "sum._\8846_"
d10 a0 a1 a2 a3 = ()
data T10 a0 = C22 a0 | C26 a0
name36 = "sum._\8744_"
d36 = erased
name48 = "sum._\8811=\8846_"
d48 v0 v1 v2 v3 v4 v5 v6 = du48 v5 v6
du48 v0 v1
  = case coe v0 of
      C22 v2 -> coe v0
      C26 v2 -> coe v1 v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name66 = "sum.return\8846"
d66 v0 v1 v2 v3 v4 = du66 v4
du66 v0 = coe C26 v0
name78 = "sum.error\8846_"
d78 v0 v1 v2 v3 v4 = du78 v4
du78 v0 = coe C22 v0
name94 = "sum.extract-inj\8321\8801"
d94 = erased
name108 = "sum.extract-inj\8322\8801"
d108 = erased
name118 = "sum.=\8846"
d118 v0 v1 v2 v3 v4 v5 v6 v7 = du118 v4 v5 v6 v7
du118 v0 v1 v2 v3
  = case coe v2 of
      C22 v4
        -> case coe v3 of
             C22 v5 -> coe v0 v4 v5
             _ -> coe False
      C26 v4
        -> case coe v3 of
             C26 v5 -> coe v1 v4 v5
             _ -> coe False
      _ -> coe MAlonzo.RTE.mazUnreachableError
name160 = "sum.=\8846-to-\8801"
d160 = erased
name246 = "sum.\8801\8846-to-="
d246 = erased