{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QxmlZ45Ztypes where

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

name2 = "xml-types.posinfo"
d2 = erased
name4 = "xml-types.id"
d4 = erased
name6 = "xml-types.id-plus-5"
d6 = erased
name8 = "xml-types.namechar"
d8 = erased
name10 = "xml-types.namechar-range-11"
d10 = erased
name12 = "xml-types.strlit"
d12 = erased
name14 = "xml-types.strlit-bar-6"
d14 = erased
name16 = "xml-types.strlit-bar-7"
d16 = erased
name18 = "xml-types.strlit-bar-8"
d18 = erased
name20 = "xml-types.strlit-bar-9"
d20 = erased
name22 = "xml-types.strlit-star-10"
d22 = erased
name24 = "xml-types.attrs"
d24 = ()
data T24 a0 a1 a2 = C36 a0 a1 a2 | C38
name26 = "xml-types.endtag"
d26 = ()
newtype T26 a0 = C40 a0
name28 = "xml-types.start"
d28 = ()
newtype T28 a0 = C42 a0
name30 = "xml-types.startendtag"
d30 = ()
data T30 a0 a1 = C44 a0 a1
name32 = "xml-types.starttag"
d32 = ()
data T32 a0 a1 = C46 a0 a1
name34 = "xml-types.xml"
d34 = ()
data T34 a0 a1 a2 = C48 a0 a1 a2 | C50 a0 a1 | C52 a0
name54 = "xml-types.ParseTreeT"
d54 = ()
data T54 a0
  = C56 a0 | C58 a0 | C60 a0 | C62 a0 | C64 a0 | C66 a0 | C68 a0 |
    C70 a0 | C72 a0 | C74 a0 | C76 a0 | C78 a0 | C80 a0 | C82 a0 |
    C84 a0 | C86 a0 | C88 a0 | C90 | C92 | C94 | C96 | C98 | C100 |
    C102
name104 = "xml-types.posinfoToString"
d104 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name108 = "xml-types.idToString"
d108 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name112 = "xml-types.id-plus-5ToString"
d112 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-plus-5 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name116 = "xml-types.namecharToString"
d116 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(namechar ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name120 = "xml-types.namechar-range-11ToString"
d120 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(namechar-range-11 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name124 = "xml-types.strlitToString"
d124 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name128 = "xml-types.strlit-bar-6ToString"
d128 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-6 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name132 = "xml-types.strlit-bar-7ToString"
d132 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-7 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name136 = "xml-types.strlit-bar-8ToString"
d136 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-8 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name140 = "xml-types.strlit-bar-9ToString"
d140 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-9 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name144 = "xml-types.strlit-star-10ToString"
d144 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-star-10 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name148 = "xml-types.attrsToString"
d148 v0
  = case coe v0 of
      C36 v1 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(AttrsCons")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d124 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d148 v3)
                               (coe Data.Text.pack ")")))))))
      C38
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "AttrsNil")
             (coe Data.Text.pack "")
      _ -> coe MAlonzo.RTE.mazUnreachableError
name150 = "xml-types.endtagToString"
d150 v0
  = case coe v0 of
      C40 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(EndTag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name152 = "xml-types.startToString"
d152 v0
  = case coe v0 of
      C42 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name154 = "xml-types.startendtagToString"
d154 v0
  = case coe v0 of
      C44 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Startendtag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d148 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name156 = "xml-types.starttagToString"
d156 v0
  = case coe v0 of
      C46 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(StartTag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d148 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name158 = "xml-types.xmlToString"
d158 v0
  = case coe v0 of
      C48 v1 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Nested")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d156 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d158 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d150 v3)
                               (coe Data.Text.pack ")")))))))
      C50 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Seq")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d158 v2) (coe Data.Text.pack ")")))))
      C52 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(StartEnd")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d154 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name190 = "xml-types.ParseTreeToString"
d190 v0
  = case coe v0 of
      C56 v1 -> coe d148 v1
      C58 v1 -> coe d150 v1
      C60 v1 -> coe d152 v1
      C62 v1 -> coe d154 v1
      C64 v1 -> coe d156 v1
      C66 v1 -> coe d158 v1
      C68 v1 -> coe d104 v1
      C70 v1 -> coe d108 v1
      C72 v1 -> coe d112 v1
      C74 v1 -> coe d116 v1
      C76 v1 -> coe d120 v1
      C78 v1 -> coe d124 v1
      C80 v1 -> coe d128 v1
      C82 v1 -> coe d132 v1
      C84 v1 -> coe d136 v1
      C86 v1 -> coe d140 v1
      C88 v1 -> coe d144 v1
      C90 -> coe Data.Text.pack "[aws]"
      C92 -> coe Data.Text.pack "[aws-bar-1]"
      C94 -> coe Data.Text.pack "[aws-bar-2]"
      C96 -> coe Data.Text.pack "[ows]"
      C98 -> coe Data.Text.pack "[ows-star-4]"
      C100 -> coe Data.Text.pack "[ws]"
      C102 -> coe Data.Text.pack "[ws-plus-3]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name228 = "xml-types.norm-xml"
d228 v0
  = case coe v0 of
      C50 v1 v2
        -> case coe v1 of
             C50 v3 v4 -> coe d228 (coe C50 v3 (coe d228 (coe C50 v4 v2)))
             _ -> coe v0
      _ -> coe v0
name232 = "xml-types.norm-starttag"
d232 v0 = coe v0
name236 = "xml-types.norm-startendtag"
d236 v0 = coe v0
name240 = "xml-types.norm-start"
d240 v0 = coe v0
name244 = "xml-types.norm-posinfo"
d244 v0 = coe v0
name248 = "xml-types.norm-endtag"
d248 v0 = coe v0
name252 = "xml-types.norm-attrs"
d252 v0 = coe v0
name274 = "xml-types.isParseTree"
d274 = erased
name282 = "xml-types.ptr"
d282 = coe MAlonzo.Code.QparseZ45Ztree.C1 d190