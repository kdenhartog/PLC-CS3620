{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QlistZ45ZtoZ45Zstring where

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
import qualified MAlonzo.Code.Qstring

name10 = "list-to-string.\120131-to-string"
d10 v0 v1 v2 v3 v4 = du10 v2 v3 v4
du10 v0 v1 v2
  = case coe v2 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v3 v4
        -> case coe v4 of
             MAlonzo.Code.Qlist.C12 -> coe v0 v3
             MAlonzo.Code.Qlist.C18 v5 v6
               -> coe
                    MAlonzo.Code.Qstring.d12 (coe v0 v3)
                    (coe MAlonzo.Code.Qstring.d12 v1 (coe du10 v0 v1 v4))
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError