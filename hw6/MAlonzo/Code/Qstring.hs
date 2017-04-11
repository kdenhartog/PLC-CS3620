{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qstring where

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

name2 = "string.string"
d2
  = error "MAlonzo Runtime Error: postulate evaluated: string.string"
name4 = "string.primStringToList"
d4 = Data.Text.unpack
name6 = "string.primStringAppend"
d6
  = ((Data.Text.append) :: Data.Text.Text->Data.Text.Text->Data.Text.Text)
name8 = "string.primStringFromList"
d8 = Data.Text.pack
name10 = "string.primStringEquality"
d10
  = (\ x y -> ((==) :: Data.Text.Text -> Data.Text.Text -> Bool) ( x) ( y))
name12 = "string._^_"
d12 = d6
name14 = "string.string-to-\120131char"
d14 = d4
name16 = "string.\120131char-to-string"
d16 = d8
name18 = "string._=string_"
d18 = d10
name20 = "string.char-to-string"
d20 v0 = coe d16 (coe MAlonzo.Code.Qlist.du26 v0)
name24 = "string.string-append-t"
d24 = erased
name30 = "string.string-append-h"
d30 v0 v1
  = case coe v0 of
      0 -> coe d12 v1
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           \ v3 -> coe d30 v2 (coe d12 v1 v3)
name44 = "string.string-append"
d44 v0 = coe d30 v0 (coe Data.Text.pack "")
name48 = "string.string-concat"
d48 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v1 v2 -> coe d12 v1 (coe d48 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name56 = "string.string-concat-sep"
d56 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v3 of
             MAlonzo.Code.Qlist.C12 -> coe v2
             MAlonzo.Code.Qlist.C18 v4 v5
               -> coe d12 v2 (coe d12 v0 (coe d56 v0 v3))
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name90 = "string.string-concat-sep-map"
d90 v0 v1 v2 v3 = du90 v1 v2 v3
du90 v0 v1 v2 = coe d56 v0 (coe MAlonzo.Code.Qlist.du128 v1 v2)
name98 = "string.escape-string-h"
d98 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v1 v2
        -> let v3 = coe MAlonzo.Code.Qlist.C18 v1 (coe d98 v2) in
           case coe v1 of
             '\n'
               -> coe
                    MAlonzo.Code.Qlist.C18 '\\'
                    (coe MAlonzo.Code.Qlist.C18 'n' (coe d98 v2))
             '"'
               -> coe
                    MAlonzo.Code.Qlist.C18 '\\'
                    (coe MAlonzo.Code.Qlist.C18 '"' (coe d98 v2))
             _ -> coe v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name108 = "string.escape-string"
d108 v0 = coe d16 (coe d98 (coe d14 v0))
name112 = "string.string-length"
d112 v0 = coe MAlonzo.Code.Qlist.du232 (coe d14 v0)