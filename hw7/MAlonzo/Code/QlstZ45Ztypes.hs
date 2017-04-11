{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QlstZ45Ztypes where

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

name2 = "lst-types.posinfo"
d2 = erased
name4 = "lst-types.var"
d4 = erased
name6 = "lst-types.var-plus-2"
d6 = erased
name8 = "lst-types.var-range-1"
d8 = erased
name10 = "lst-types.expr"
d10 = ()
data T10 a0 a1 = C14 a0 a1 | C16 a0 a1 | C18 | C20 a0 | C22 a0
name12 = "lst-types.strt"
d12 = ()
newtype T12 a0 = C24 a0
name26 = "lst-types.ParseTreeT"
d26 = ()
data T26 a0
  = C28 a0 | C30 a0 | C32 a0 | C34 a0 | C36 a0 | C38 a0 | C40 | C42 |
    C44 | C46 | C48 | C50 | C52 | C54 | C56
name58 = "lst-types.posinfoToString"
d58 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name62 = "lst-types.varToString"
d62 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name66 = "lst-types.var-plus-2ToString"
d66 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-plus-2 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name70 = "lst-types.var-range-1ToString"
d70 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(var-range-1 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name74 = "lst-types.exprToString"
d74 v0
  = case coe v0 of
      C14 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(App")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d74 v2) (coe Data.Text.pack ")")))))
      C16 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Cons")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d74 v2) (coe Data.Text.pack ")")))))
      C18
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "Nil")
             (coe Data.Text.pack "")
      C20 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Parens")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1) (coe Data.Text.pack ")")))
      C22 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Var")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d62 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name76 = "lst-types.strtToString"
d76 v0
  = case coe v0 of
      C24 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name92 = "lst-types.ParseTreeToString"
d92 v0
  = case coe v0 of
      C28 v1 -> coe d74 v1
      C30 v1 -> coe d76 v1
      C32 v1 -> coe d58 v1
      C34 v1 -> coe d62 v1
      C36 v1 -> coe d66 v1
      C38 v1 -> coe d70 v1
      C40 -> coe Data.Text.pack "[arrow]"
      C42 -> coe Data.Text.pack "[arrow-bar-3]"
      C44 -> coe Data.Text.pack "[aws]"
      C46 -> coe Data.Text.pack "[aws-bar-6]"
      C48 -> coe Data.Text.pack "[aws-bar-7]"
      C50 -> coe Data.Text.pack "[ows]"
      C52 -> coe Data.Text.pack "[ows-star-4]"
      C54 -> coe Data.Text.pack "[ws]"
      C56 -> coe Data.Text.pack "[ws-plus-5]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name108 = "lst-types.norm-strt"
d108 v0 = coe v0
name112 = "lst-types.norm-posinfo"
d112 v0 = coe v0
name116 = "lst-types.norm-expr"
d116 v0
  = case coe v0 of
      C14 v1 v2
        -> case coe v1 of
             C14 v3 v4 -> coe d116 (coe C14 v3 (coe d116 (coe C14 v4 v2)))
             _ -> coe v0
      C16 v1 v2
        -> let v3
                 = case coe v1 of
                     C14 v3 v4 -> coe d116 (coe C14 v3 (coe d116 (coe C16 v4 v2)))
                     C16 v3 v4 -> coe d116 (coe C16 v3 (coe d116 (coe C16 v4 v2)))
                     _ -> coe v0 in
           case coe v2 of
             C14 v4 v5 -> coe d116 (coe C14 (coe d116 (coe C16 v1 v4)) v5)
             _ -> coe v3
      _ -> coe v0
name148 = "lst-types.isParseTree"
d148 = erased
name156 = "lst-types.ptr"
d156 = coe MAlonzo.Code.QparseZ45Ztree.C1 d92