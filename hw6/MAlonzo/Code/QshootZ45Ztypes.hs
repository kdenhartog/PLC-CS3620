{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QshootZ45Ztypes where

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
import qualified MAlonzo.Code.QparseZ45Ztree
import qualified MAlonzo.Code.Qstring

name2 = "shoot-types.posinfo"
d2 = erased
name4 = "shoot-types.d"
d4 = erased
name6 = "shoot-types.declared"
d6 = erased
name8 = "shoot-types.defs"
d8 = erased
name10 = "shoot-types.ds"
d10 = erased
name12 = "shoot-types.is-declared"
d12 = erased
name14 = "shoot-types.letterm"
d14 = erased
name16 = "shoot-types.num"
d16 = erased
name18 = "shoot-types.num-plus-11"
d18 = erased
name20 = "shoot-types.num-range-10"
d20 = erased
name22 = "shoot-types.start"
d22 = erased
name24 = "shoot-types.start-opt-1"
d24 = erased
name26 = "shoot-types.start-opt-2"
d26 = erased
name28 = "shoot-types.start-opt-3"
d28 = erased
name30 = "shoot-types.term"
d30 = erased
name32 = "shoot-types.used"
d32 = erased
name34 = "shoot-types.var"
d34 = erased
name36 = "shoot-types.var-plus-9"
d36 = erased
name38 = "shoot-types.var-range-8"
d38 = erased
name40 = "shoot-types.vars"
d40 = erased
name42 = "shoot-types.ParseTreeT"
d42 = ()
data T42 a0
  = C44 a0 | C46 a0 | C48 a0 | C50 a0 | C52 a0 | C54 a0 | C56 a0 |
    C58 a0 | C60 a0 | C62 a0 | C64 a0 | C66 a0 | C68 a0 | C70 a0 |
    C72 a0 | C74 a0 | C76 a0 | C78 a0 | C80 a0 | C82 a0 | C84 | C86 |
    C88 | C90 | C92 | C94 | C96
name98 = "shoot-types.posinfoToString"
d98 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name102 = "shoot-types.dToString"
d102 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(d ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name106 = "shoot-types.declaredToString"
d106 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(declared ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name110 = "shoot-types.defsToString"
d110 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(defs ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name114 = "shoot-types.dsToString"
d114 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(ds ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name118 = "shoot-types.is-declaredToString"
d118 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(is-declared ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name122 = "shoot-types.lettermToString"
d122 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(letterm ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name126 = "shoot-types.numToString"
d126 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name130 = "shoot-types.num-plus-11ToString"
d130 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-plus-11 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name134 = "shoot-types.num-range-10ToString"
d134 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-range-10 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name138 = "shoot-types.startToString"
d138 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(start ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name142 = "shoot-types.start-opt-1ToString"
d142 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(start-opt-1 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name146 = "shoot-types.start-opt-2ToString"
d146 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(start-opt-2 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name150 = "shoot-types.start-opt-3ToString"
d150 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(start-opt-3 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name154 = "shoot-types.termToString"
d154 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(term ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name158 = "shoot-types.usedToString"
d158 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(used ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name162 = "shoot-types.varToString"
d162 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name166 = "shoot-types.var-plus-9ToString"
d166 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-plus-9 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name170 = "shoot-types.var-range-8ToString"
d170 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-range-8 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name174 = "shoot-types.varsToString"
d174 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(vars ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name178 = "shoot-types.ParseTreeToString"
d178 v0
  = case coe v0 of
      C44 v1 -> coe d98 v1
      C46 v1 -> coe d102 v1
      C48 v1 -> coe d106 v1
      C50 v1 -> coe d110 v1
      C52 v1 -> coe d114 v1
      C54 v1 -> coe d118 v1
      C56 v1 -> coe d122 v1
      C58 v1 -> coe d126 v1
      C60 v1 -> coe d130 v1
      C62 v1 -> coe d134 v1
      C64 v1 -> coe d138 v1
      C66 v1 -> coe d142 v1
      C68 v1 -> coe d146 v1
      C70 v1 -> coe d150 v1
      C72 v1 -> coe d154 v1
      C74 v1 -> coe d158 v1
      C76 v1 -> coe d162 v1
      C78 v1 -> coe d166 v1
      C80 v1 -> coe d170 v1
      C82 v1 -> coe d174 v1
      C84 -> coe Data.Text.pack "[aws]"
      C86 -> coe Data.Text.pack "[aws-bar-4]"
      C88 -> coe Data.Text.pack "[aws-bar-5]"
      C90 -> coe Data.Text.pack "[ows]"
      C92 -> coe Data.Text.pack "[ows-star-7]"
      C94 -> coe Data.Text.pack "[ws]"
      C96 -> coe Data.Text.pack "[ws-plus-6]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name222 = "shoot-types.norm-posinfo"
d222 v0 = coe v0
name226 = "shoot-types.isParseTree"
d226 = erased
name234 = "shoot-types.ptr"
d234 = coe MAlonzo.Code.QparseZ45Ztree.C1 d178