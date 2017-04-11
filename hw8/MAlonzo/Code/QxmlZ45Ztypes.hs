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
name10 = "xml-types.namechar-range-12"
d10 = erased
name12 = "xml-types.strlit"
d12 = erased
name14 = "xml-types.strlit-bar-10"
d14 = erased
name16 = "xml-types.strlit-bar-6"
d16 = erased
name18 = "xml-types.strlit-bar-7"
d18 = erased
name20 = "xml-types.strlit-bar-8"
d20 = erased
name22 = "xml-types.strlit-bar-9"
d22 = erased
name24 = "xml-types.strlit-star-11"
d24 = erased
name26 = "xml-types.attrs"
d26 = ()
data T26 a0 a1 a2 a3 a4 a5 a6 = C38 a0 a1 a2 a3 a4 a5 a6 | C40
name28 = "xml-types.endtag"
d28 = ()
data T28 a0 a1 a2 = C42 a0 a1 a2
name30 = "xml-types.start"
d30 = ()
newtype T30 a0 = C44 a0
name32 = "xml-types.startendtag"
d32 = ()
data T32 a0 a1 a2 a3 = C46 a0 a1 a2 a3
name34 = "xml-types.starttag"
d34 = ()
data T34 a0 a1 a2 a3 = C48 a0 a1 a2 a3
name36 = "xml-types.xml"
d36 = ()
data T36 a0 a1 a2 = C50 a0 a1 a2 | C52 a0 a1 | C54 a0
name56 = "xml-types.ParseTreeT"
d56 = ()
data T56 a0
  = C58 a0 | C60 a0 | C62 a0 | C64 a0 | C66 a0 | C68 a0 | C70 a0 |
    C72 a0 | C74 a0 | C76 a0 | C78 a0 | C80 a0 | C82 a0 | C84 a0 |
    C86 a0 | C88 a0 | C90 a0 | C92 a0 | C94 | C96 | C98 | C100 | C102 |
    C104 | C106
name108 = "xml-types.posinfoToString"
d108 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name112 = "xml-types.idToString"
d112 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name116 = "xml-types.id-plus-5ToString"
d116 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-plus-5 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name120 = "xml-types.namecharToString"
d120 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(namechar ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name124 = "xml-types.namechar-range-12ToString"
d124 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(namechar-range-12 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name128 = "xml-types.strlitToString"
d128 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name132 = "xml-types.strlit-bar-10ToString"
d132 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-10 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name136 = "xml-types.strlit-bar-6ToString"
d136 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-6 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name140 = "xml-types.strlit-bar-7ToString"
d140 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-7 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name144 = "xml-types.strlit-bar-8ToString"
d144 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-8 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name148 = "xml-types.strlit-bar-9ToString"
d148 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-bar-9 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name152 = "xml-types.strlit-star-11ToString"
d152 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(strlit-star-11 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name156 = "xml-types.attrsToString"
d156 v0
  = case coe v0 of
      C38 v1 v2 v3 v4 v5 v6 v7
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(AttrsCons")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d112 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d108 v3)
                               (coe
                                  MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                  (coe
                                     MAlonzo.Code.Qstring.d12 (coe d108 v4)
                                     (coe
                                        MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                        (coe
                                           MAlonzo.Code.Qstring.d12 (coe d128 v5)
                                           (coe
                                              MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                              (coe
                                                 MAlonzo.Code.Qstring.d12 (coe d108 v6)
                                                 (coe
                                                    MAlonzo.Code.Qstring.d12
                                                    (coe Data.Text.pack " ")
                                                    (coe
                                                       MAlonzo.Code.Qstring.d12 (coe d156 v7)
                                                       (coe Data.Text.pack ")")))))))))))))))
      C40
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "AttrsNil")
             (coe Data.Text.pack "")
      _ -> coe MAlonzo.RTE.mazUnreachableError
name158 = "xml-types.endtagToString"
d158 v0
  = case coe v0 of
      C42 v1 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(EndTag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d112 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d108 v3)
                               (coe Data.Text.pack ")")))))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name160 = "xml-types.startToString"
d160 v0
  = case coe v0 of
      C44 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d166 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name162 = "xml-types.startendtagToString"
d162 v0
  = case coe v0 of
      C46 v1 v2 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Startendtag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d112 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d156 v3)
                               (coe
                                  MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                  (coe
                                     MAlonzo.Code.Qstring.d12 (coe d108 v4)
                                     (coe Data.Text.pack ")")))))))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name164 = "xml-types.starttagToString"
d164 v0
  = case coe v0 of
      C48 v1 v2 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(StartTag")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d112 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d156 v3)
                               (coe
                                  MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                                  (coe
                                     MAlonzo.Code.Qstring.d12 (coe d108 v4)
                                     (coe Data.Text.pack ")")))))))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name166 = "xml-types.xmlToString"
d166 v0
  = case coe v0 of
      C50 v1 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Nested")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d164 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d166 v2)
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe d158 v3)
                               (coe Data.Text.pack ")")))))))
      C52 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Seq")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d166 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d166 v2) (coe Data.Text.pack ")")))))
      C54 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(StartEnd")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d162 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name218 = "xml-types.ParseTreeToString"
d218 v0
  = case coe v0 of
      C58 v1 -> coe d156 v1
      C60 v1 -> coe d158 v1
      C62 v1 -> coe d160 v1
      C64 v1 -> coe d162 v1
      C66 v1 -> coe d164 v1
      C68 v1 -> coe d166 v1
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
      C90 v1 -> coe d148 v1
      C92 v1 -> coe d152 v1
      C94 -> coe Data.Text.pack "[aws]"
      C96 -> coe Data.Text.pack "[aws-bar-1]"
      C98 -> coe Data.Text.pack "[aws-bar-2]"
      C100 -> coe Data.Text.pack "[ows]"
      C102 -> coe Data.Text.pack "[ows-star-4]"
      C104 -> coe Data.Text.pack "[ws]"
      C106 -> coe Data.Text.pack "[ws-plus-3]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name258 = "xml-types.norm-xml"
d258 v0
  = case coe v0 of
      C52 v1 v2
        -> case coe v1 of
             C52 v3 v4 -> coe d258 (coe C52 v3 (coe d258 (coe C52 v4 v2)))
             _ -> coe v0
      _ -> coe v0
name262 = "xml-types.norm-starttag"
d262 v0 = coe v0
name266 = "xml-types.norm-startendtag"
d266 v0 = coe v0
name270 = "xml-types.norm-start"
d270 v0 = coe v0
name274 = "xml-types.norm-posinfo"
d274 v0 = coe v0
name278 = "xml-types.norm-endtag"
d278 v0 = coe v0
name282 = "xml-types.norm-attrs"
d282 v0 = coe v0
name304 = "xml-types.isParseTree"
d304 = erased
name312 = "xml-types.ptr"
d312 = coe MAlonzo.Code.QparseZ45Ztree.C1 d218