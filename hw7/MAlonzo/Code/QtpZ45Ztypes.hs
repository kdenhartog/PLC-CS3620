{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QtpZ45Ztypes where

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

name2 = "tp-types.posinfo"
d2 = erased
name4 = "tp-types.var"
d4 = erased
name6 = "tp-types.var-plus-2"
d6 = erased
name8 = "tp-types.var-range-1"
d8 = erased
name10 = "tp-types.decl"
d10 = ()
data T10 a0 a1 = C18 a0 a1 | C20
name12 = "tp-types.decls"
d12 = ()
data T12 a0 a1 = C22 a0 | C24 a0 a1
name14 = "tp-types.strt"
d14 = ()
newtype T14 a0 = C26 a0
name16 = "tp-types.tp"
d16 = ()
data T16 a0 a1 = C28 a0 a1 | C30 a0 | C32 a0
name34 = "tp-types.ParseTreeT"
d34 = ()
data T34 a0
  = C36 a0 | C38 a0 | C40 a0 | C42 a0 | C44 a0 | C46 a0 | C48 a0 |
    C50 a0 | C52 | C54 | C56 | C58 | C60 | C62 | C64 | C66
name68 = "tp-types.posinfoToString"
d68 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name72 = "tp-types.varToString"
d72 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name76 = "tp-types.var-plus-2ToString"
d76 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-plus-2 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name80 = "tp-types.var-range-1ToString"
d80 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-range-1 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name84 = "tp-types.declToString"
d84 v0
  = case coe v0 of
      C18 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Decl")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d72 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d90 v2) (coe Data.Text.pack ")")))))
      C20
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "Decl/1")
             (coe Data.Text.pack "")
      _ -> coe MAlonzo.RTE.mazUnreachableError
name86 = "tp-types.declsToString"
d86 v0
  = case coe v0 of
      C22 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(CmdsStart")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d84 v1) (coe Data.Text.pack ")")))
      C24 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(declNext")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d84 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d86 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name88 = "tp-types.strtToString"
d88 v0
  = case coe v0 of
      C26 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d86 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name90 = "tp-types.tpToString"
d90 v0
  = case coe v0 of
      C28 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Arrow")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d90 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d90 v2) (coe Data.Text.pack ")")))))
      C30 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Parens")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d90 v1) (coe Data.Text.pack ")")))
      C32 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Var")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d72 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name112 = "tp-types.ParseTreeToString"
d112 v0
  = case coe v0 of
      C36 v1 -> coe d84 v1
      C38 v1 -> coe d86 v1
      C40 v1 -> coe d88 v1
      C42 v1 -> coe d90 v1
      C44 v1 -> coe d68 v1
      C46 v1 -> coe d72 v1
      C48 v1 -> coe d76 v1
      C50 v1 -> coe d80 v1
      C52 -> coe Data.Text.pack "[arrow]"
      C54 -> coe Data.Text.pack "[aws]"
      C56 -> coe Data.Text.pack "[aws-bar-5]"
      C58 -> coe Data.Text.pack "[aws-bar-6]"
      C60 -> coe Data.Text.pack "[ows]"
      C62 -> coe Data.Text.pack "[ows-star-3]"
      C64 -> coe Data.Text.pack "[ws]"
      C66 -> coe Data.Text.pack "[ws-plus-4]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name132 = "tp-types.norm-tp"
d132 v0
  = case coe v0 of
      C28 v1 v2
        -> case coe v1 of
             C28 v3 v4 -> coe d132 (coe C28 v3 (coe d132 (coe C28 v4 v2)))
             _ -> coe v0
      _ -> coe v0
name136 = "tp-types.norm-strt"
d136 v0 = coe v0
name140 = "tp-types.norm-posinfo"
d140 v0 = coe v0
name144 = "tp-types.norm-decls"
d144 v0 = coe v0
name148 = "tp-types.norm-decl"
d148 v0 = coe v0
name166 = "tp-types.isParseTree"
d166 = erased
name174 = "tp-types.ptr"
d174 = coe MAlonzo.Code.QparseZ45Ztree.C1 d112