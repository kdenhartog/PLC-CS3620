{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QxmlZ45Zspans where

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
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qstring

name2 = "xml-spans.tagged-val"
d2 = erased
name4 = "xml-spans.tagged-val-to-string"
d4 v0
  = case coe v0 of
      MAlonzo.Code.Qproduct.C24 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\"")
             (coe
                MAlonzo.Code.Qstring.d12 v1
                (coe
                   MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\":\"")
                   (coe MAlonzo.Code.Qstring.d12 v2 (coe Data.Text.pack "\""))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name10 = "xml-spans.tagged-vals-to-string"
d10 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v1 v2
        -> coe MAlonzo.Code.Qstring.d12 (coe d4 v1) (coe d10 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name16 = "xml-spans.span"
d16 = ()
data T16 a0 a1 a2 a3 = C18 a0 a1 a2 a3
name20 = "xml-spans.span-to-string"
d20 v0
  = case coe v0 of
      C18 v1 v2 v3 v4
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "[\"")
             (coe
                MAlonzo.Code.Qstring.d12 v1
                (coe
                   MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\",")
                   (coe
                      MAlonzo.Code.Qstring.d12 v2
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe Data.Text.pack ",")
                         (coe
                            MAlonzo.Code.Qstring.d12 v3
                            (coe
                               MAlonzo.Code.Qstring.d12 (coe Data.Text.pack ",{")
                               (coe
                                  MAlonzo.Code.Qstring.d12 (coe d10 v4)
                                  (coe Data.Text.pack "}]"))))))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name30 = "xml-spans.spans-to-string"
d30 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "{\"spans\":[")
      (coe
         MAlonzo.Code.Qstring.d12
         (coe MAlonzo.Code.Qstring.du90 (coe Data.Text.pack ",") d20 v0)
         (coe Data.Text.pack "]}"))
name34 = "xml-spans.global-error-string"
d34 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "{\"error\":\"")
      (coe
         MAlonzo.Code.Qstring.d12 v0
         (coe
            MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\"")
            (coe Data.Text.pack "}")))
name38 = "xml-spans.StartEnd-span"
d38 v0 v1 v2 = du38 v0 v2
du38 v0 v1
  = coe
      C18 (coe Data.Text.pack "Startend") v0 v1 MAlonzo.Code.Qlist.C12
name46 = "xml-spans.error-data"
d46 v0
  = coe MAlonzo.Code.Qproduct.C24 (coe Data.Text.pack "error") v0
name50 = "xml-spans.Nested-span"
d50 v0 v1
  = coe
      C18 (coe Data.Text.pack "Element") v0 v1 MAlonzo.Code.Qlist.C12
name56 = "xml-spans.endtag-mismatch-span"
d56 v0 v1 v2 v3 = du56 v0 v1 v2
du56 v0 v1 v2
  = coe
      C18 (coe Data.Text.pack "Mismatch") v0 v1
      (coe
         MAlonzo.Code.Qlist.du26
         (coe
            d46
            (coe
               MAlonzo.Code.Qstring.d12
               (coe Data.Text.pack "incorrect endtag, should be ") v2)))