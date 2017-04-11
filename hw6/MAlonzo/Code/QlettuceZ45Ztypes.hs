{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QlettuceZ45Ztypes where

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

name2 = "lettuce-types.posinfo"
d2 = erased
name4 = "lettuce-types.num"
d4 = erased
name6 = "lettuce-types.num-plus-6"
d6 = erased
name8 = "lettuce-types.num-range-5"
d8 = erased
name10 = "lettuce-types.var"
d10 = erased
name12 = "lettuce-types.var-plus-8"
d12 = erased
name14 = "lettuce-types.var-range-7"
d14 = erased
name16 = "lettuce-types.global"
d16 = ()
data T16 a0 a1 = C24 a0 a1
name18 = "lettuce-types.globals"
d18 = ()
data T18 a0 a1 = C26 a0 a1 | C28
name20 = "lettuce-types.letterm"
d20 = ()
data T20 a0 a1 a2 a3
  = C30 a0 a1 a2 a3 | C32 a0 | C34 a0 a1 | C36 a0 a1
name22 = "lettuce-types.start"
d22 = ()
data T22 a0 a1 = C38 a0 a1
name40 = "lettuce-types.atom"
d40 = erased
name42 = "lettuce-types.term"
d42 = erased
name44 = "lettuce-types.ParseTreeT"
d44 = ()
data T44 a0
  = C46 a0 | C48 a0 | C50 a0 | C52 a0 | C54 a0 | C56 a0 | C58 a0 |
    C60 a0 | C62 a0 | C64 a0 | C66 a0 | C68 a0 | C70 a0 | C72 | C74 |
    C76 | C78 | C80 | C82 | C84
name86 = "lettuce-types.posinfoToString"
d86 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name90 = "lettuce-types.numToString"
d90 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name94 = "lettuce-types.num-plus-6ToString"
d94 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-plus-6 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name98 = "lettuce-types.num-range-5ToString"
d98 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-range-5 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name102 = "lettuce-types.varToString"
d102 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name106 = "lettuce-types.var-plus-8ToString"
d106 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-plus-8 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name110 = "lettuce-types.var-range-7ToString"
d110 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-range-7 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name114 = "lettuce-types.globalToString"
d114 v0
  = case coe v0 of
      C24 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Global")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d102 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d90 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name116 = "lettuce-types.globalsToString"
d116 v0
  = case coe v0 of
      C26 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(GlobalsCons")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d114 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d116 v2) (coe Data.Text.pack ")")))))
      C28
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "GlobalsNil")
             (coe Data.Text.pack "")
      _ -> coe MAlonzo.RTE.mazUnreachableError
name118 = "lettuce-types.lettermToString"
d118 v0
  = case coe v0 of
      C30 v1 v2 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Let")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d86 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d102 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d118 v3)
                               (coe
                                  MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                  (coe
                                     MAlonzo.Code.Qstring.d12 (coe d118 v4)
                                     (coe Data.Text.pack ")")))))))))
      C32 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Parens")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d118 v1) (coe Data.Text.pack ")")))
      C34 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Plus")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d118 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d118 v2) (coe Data.Text.pack ")")))))
      C36 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Var")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d86 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d102 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name120 = "lettuce-types.startToString"
d120 v0
  = case coe v0 of
      C38 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(InputTerm")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d116 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d118 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name152 = "lettuce-types.ParseTreeToString"
d152 v0
  = case coe v0 of
      C46 v1 -> coe d114 v1
      C48 v1 -> coe d116 v1
      C50 v1 -> coe d118 v1
      C52 v1 -> coe d120 v1
      C54 v1 -> coe d118 v1
      C56 v1 -> coe d118 v1
      C58 v1 -> coe d86 v1
      C60 v1 -> coe d90 v1
      C62 v1 -> coe d94 v1
      C64 v1 -> coe d98 v1
      C66 v1 -> coe d102 v1
      C68 v1 -> coe d106 v1
      C70 v1 -> coe d110 v1
      C72 -> coe Data.Text.pack "[aws]"
      C74 -> coe Data.Text.pack "[aws-bar-1]"
      C76 -> coe Data.Text.pack "[aws-bar-2]"
      C78 -> coe Data.Text.pack "[ows]"
      C80 -> coe Data.Text.pack "[ows-star-4]"
      C82 -> coe Data.Text.pack "[ws]"
      C84 -> coe Data.Text.pack "[ws-plus-3]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name182 = "lettuce-types.norm-term"
d182 v0 = coe v0
name186 = "lettuce-types.norm-start"
d186 v0 = coe v0
name190 = "lettuce-types.norm-posinfo"
d190 v0 = coe v0
name194 = "lettuce-types.norm-letterm"
d194 v0 = coe v0
name198 = "lettuce-types.norm-globals"
d198 v0 = coe v0
name202 = "lettuce-types.norm-global"
d202 v0 = coe v0
name206 = "lettuce-types.norm-atom"
d206 v0 = coe v0
name222 = "lettuce-types.isParseTree"
d222 = erased
name230 = "lettuce-types.ptr"
d230 = coe MAlonzo.Code.QparseZ45Ztree.C1 d152