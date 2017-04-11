{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qtermination where

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
import qualified MAlonzo.Code.QnatZ45Zthms
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qsum

name10 = "termination.\8595"
d10 a0 a1 a2 a3 a4 = ()
data T10 a0 a1 = C24 a0 a1
name32 = "termination.\8595\120121"
d32 = erased
name48 = "termination.\8595->"
d48 v0 = coe C24 v0 (\ v1 v2 -> coe du60 v0 v1)
name60 = "termination._.h"
d60 v0 v1 v2 v3 = du60 v1 v2
du60 v0 v1
  = let v2 = coe subInt v0 (1 :: Integer) in
    let v3 = coe MAlonzo.Code.QnatZ45Zthms.du358 v1 v2 in
    case coe v3 of
      MAlonzo.Code.Qsum.C22 v4 -> coe d48 v2
      MAlonzo.Code.Qsum.C26 v4 -> coe du60 v2 v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name112 = "termination.lexcomb._>lex_"
d112 = erased
name128 = "termination.lexcomb.\8595-lex"
d128 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11
  = du128 v0 v1 v2 v3 v8 v9 v10 v11
du128 v0 v1 v2 v3 v4 v5 v6 v7
  = case coe v5 of
      C24 v8 v9
        -> coe
             C24 (coe MAlonzo.Code.Qproduct.C24 v4 v7)
             (coe du150 v0 v1 v2 v3 v6 v9 (coe v6 v7))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name150 = "termination.lexcomb._.helper"
d150 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17
  = du150 v0 v3 v4 v5 v10 v13 v15 v16 v17
du150 v0 v1 v2 v3 v4 v5 v6 v7 v8
  = case coe v7 of
      MAlonzo.Code.Qproduct.C24 v9 v10
        -> case coe v8 of
             MAlonzo.Code.Qsum.C22 v11
               -> coe du128 v0 v1 v2 v3 v9 (coe v5 v9 v11) v4 v10
             MAlonzo.Code.Qsum.C26 v11
               -> case coe v6 of
                    C24 v12 v13
                      -> case coe v11 of
                           MAlonzo.Code.Qproduct.C24 v14 v15
                             -> coe C24 v7 (coe du150 v0 v1 v2 v3 v4 v5 (coe v13 v10 v15))
                           _ -> coe MAlonzo.RTE.mazUnreachableError
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name204 = "termination.measure.measure-\8595"
d204 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11
  = du204 v0 v1 v2 v3 v8 v9 v10 v11
du204 v0 v1 v2 v3 v4 v5 v6 v7
  = case coe v7 of
      C24 v8 v9 -> coe C24 v6 (coe du216 v0 v1 v2 v3 v4 v6 v5 v9)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name216 = "termination.measure._.h"
d216 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13
  = du216 v0 v1 v2 v3 v8 v9 v10 v11 v12 v13
du216 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9
  = coe
      du204 v0 v1 v2 v3 v4 v6 v8 (coe v7 (coe v4 v8) (coe v6 v5 v8 v9))