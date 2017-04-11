{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qhtml where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qstring

name2 = "html.attribute-list"
d2 = erased
name4 = "html.html"
d4 = ()
data T4 a0 a1 a2 = C12 a0 a1 a2 | C16 a0
name18 = "html.attributes-to-string"
d18 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> coe
                    MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                    (coe
                       MAlonzo.Code.Qstring.d12 v3
                       (coe
                          MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " = \"")
                          (coe
                             MAlonzo.Code.Qstring.d12 v4
                             (coe
                                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\"") (coe d18 v2)))))
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name26 = "html.html-to-string"
d26 v0
  = case coe v0 of
      C12 v1 v2 v3
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "<")
             (coe
                MAlonzo.Code.Qstring.d12 v1
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d18 v2)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack ">")
                      (coe
                         MAlonzo.Code.Qstring.d12
                         (coe MAlonzo.Code.Qstring.d56 (coe Data.Text.pack "") (coe d28 v3))
                         (coe
                            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "</")
                            (coe MAlonzo.Code.Qstring.d12 v1 (coe Data.Text.pack ">")))))))
      C16 v1 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name28 = "html.html-list-to-string"
d28 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v1 v2
        -> coe MAlonzo.Code.Qlist.C18 (coe d26 v1) (coe d28 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name42 = "html.html-to-indented-helper"
d42 v0 v1
  = case coe v0 of
      C12 v2 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 v1
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "<")
                (coe
                   MAlonzo.Code.Qstring.d12 v2
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe d18 v3)
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe Data.Text.pack ">\n")
                         (coe
                            MAlonzo.Code.Qstring.d12
                            (coe
                               MAlonzo.Code.Qstring.d56 (coe Data.Text.pack "\n") (coe d44 v4 v1))
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\n")
                               (coe
                                  MAlonzo.Code.Qstring.d12 v1
                                  (coe
                                     MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "</")
                                     (coe
                                        MAlonzo.Code.Qstring.d12 v2
                                        (coe Data.Text.pack ">"))))))))))
      C16 v2 -> coe MAlonzo.Code.Qstring.d12 v1 v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name44 = "html.html-list-to-indented"
d44 v0 v1
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v2 v3
        -> coe
             MAlonzo.Code.Qlist.C18
             (coe
                d42 v2 (coe MAlonzo.Code.Qstring.d12 v1 (coe Data.Text.pack " ")))
             (coe d44 v3 v1)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name66 = "html.html-to-indented"
d66 v0 = coe d42 v0 (coe Data.Text.pack "")
name70 = "html.do-ul-list"
d70 = True
name72 = "html.do-ol-list"
d72 = False
name74 = "html.helper-li"
d74 v0
  = case coe v0 of
      C12 v1 v2 v3 -> coe C12 (coe Data.Text.pack "li") v2 v3
      C16 v1
        -> coe
             C12 (coe Data.Text.pack "li") MAlonzo.Code.Qlist.C12
             (coe MAlonzo.Code.Qlist.C18 v0 MAlonzo.Code.Qlist.C12)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name84 = "html.html-list"
d84 v0 v1
  = case coe v0 of
      True
        -> case coe v1 of
             MAlonzo.Code.Qlist.C12 -> coe C12 (coe Data.Text.pack "") v1 v1
             MAlonzo.Code.Qlist.C18 v2 v3
               -> case coe v2 of
                    C12 v4 v5 v6 -> coe v2
                    C16 v4
                      -> coe
                           C12 (coe Data.Text.pack "ul") MAlonzo.Code.Qlist.C12
                           (coe MAlonzo.Code.Qlist.du128 d74 v1)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      False
        -> case coe v1 of
             MAlonzo.Code.Qlist.C12 -> coe C12 (coe Data.Text.pack "") v1 v1
             MAlonzo.Code.Qlist.C18 v2 v3
               -> case coe v2 of
                    C12 v4 v5 v6 -> coe v2
                    C16 v4
                      -> coe
                           C12 (coe Data.Text.pack "ol") MAlonzo.Code.Qlist.C12
                           (coe MAlonzo.Code.Qlist.du128 d74 v1)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name110 = "html.num-subelts"
d110 v0
  = case coe v0 of
      C12 v1 v2 v3 -> coe MAlonzo.Code.Qlist.du232 v3
      C16 v1 -> 0 :: Integer
      _ -> coe MAlonzo.RTE.mazUnreachableError
name122 = "html.list-prefixes"
d122 v0 v1 = du122 v1
du122 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v1 v2
        -> coe MAlonzo.Code.Qlist.C18 v0 (coe du122 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name128 = "html.p-prefixes"
d128 v0 = du128
du128 = MAlonzo.Code.Qlist.C12
name132 = "html.css-decl"
d132 = erased
name152 = "html.gradient"
d152 v0 v1 v2 v3 v4 v5 v6 v7 v8 = du152
du152 = MAlonzo.Code.Qlist.C12
name172 = "html.tuples-to-decls"
d172 v0 = du172
du172 = MAlonzo.Code.Qlist.C12
name176 = "html.zip-html-css-decls"
d176 v0 v1 = du176
du176 = MAlonzo.Code.Qlist.C12