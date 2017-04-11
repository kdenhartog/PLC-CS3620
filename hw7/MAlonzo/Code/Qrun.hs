{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qrun where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.QnatZ45ZtoZ45Zstring
import qualified MAlonzo.Code.QparseZ45Ztree
import qualified MAlonzo.Code.Qstring

name14 = "run.deriv.RunElement"
d14 a0 a1 = ()
data T14 a0 a1 a2 a3 = C16 a0 | C20 a0 | C28 a0 a1 a2 a3
name32 = "run.deriv.Run"
d32 a0 a1 = ()
data T32 a0 a1 a2 a3 = C34 | C40 a0 a1 a2 a3
name44 = "run.deriv.length-run"
d44 v0 v1 v2 = du44 v2
du44 v0
  = case coe v0 of
      C34 -> 0 :: Integer
      C40 v1 v2 v3 v4 -> coe addInt (1 :: Integer) (coe du44 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name52 = "run.deriv.RunElement-to-string"
d52 v0 v1 v2 = du52 v0 v2
du52 v0 v1
  = case coe v1 of
      C16 v2
        -> coe MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "id:") v2
      C20 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "#")
             (coe MAlonzo.Code.Qstring.d20 v2)
      C28 v2 v3 v4 v5 -> coe MAlonzo.Code.QparseZ45Ztree.d14 v0 v4
      _ -> coe MAlonzo.RTE.mazUnreachableError
name64 = "run.deriv.Run-to-string"
d64 v0 v1 v2 = du64 v0 v2
du64 v0 v1
  = case coe v1 of
      C34 -> coe Data.Text.pack "\n"
      C40 v2 v3 v4 v5
        -> coe
             MAlonzo.Code.Qstring.d12 (coe du52 v0 v4)
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ") (coe du64 v0 v5))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name74 = "run.deriv.assocRun"
d74 v0 v1 v2 v3 = du74 v3
du74 v0 = coe v0
name88 = "run.deriv.rewriteRules"
d88 a0 = ()
newtype T88 a0 = C611 a0
name100 = "run.deriv.rewriteRules.len-dec-rewrite"
d100 v0
  = case coe v0 of
      C611 v1 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name104 = "run.noderiv.RunElement"
d104 a0 = ()
data T104 a0 = C106 a0 | C110 a0 | C112 a0 | C114 a0
name116 = "run.noderiv.Run"
d116 = erased
name118 = "run.noderiv._::'_"
d118 = MAlonzo.Code.Qlist.C18
name120 = "run.noderiv.[]'"
d120 v0 = du120
du120 = MAlonzo.Code.Qlist.C12
name122 = "run.noderiv.length-run"
d122 v0 = du122
du122 = MAlonzo.Code.Qlist.du232
name124 = "run.noderiv.RunElement-to-string"
d124 v0 v1
  = case coe v1 of
      C106 v2
        -> coe MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "id:") v2
      C110 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "#")
             (coe MAlonzo.Code.Qstring.d20 v2)
      C112 v2 -> coe MAlonzo.Code.QparseZ45Ztree.d14 v0 v2
      C114 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "pos:")
             (coe MAlonzo.Code.QnatZ45ZtoZ45Zstring.d80 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name134 = "run.noderiv.Run-to-string"
d134 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack "\n"
      MAlonzo.Code.Qlist.C18 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe d124 v0 v2)
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ") (coe d134 v0 v3))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name140 = "run.noderiv.rewriteRules"
d140 a0 = ()
newtype T140 a0 = C805 a0
name144 = "run.noderiv.rewriteRules.len-dec-rewrite"
d144 v0
  = case coe v0 of
      C805 v1 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name146 = "run.empty-string"
d146 v0 = du146
du146 = coe Data.Text.pack ""