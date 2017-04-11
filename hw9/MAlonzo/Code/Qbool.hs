{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qbool where

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

name2 = "bool.\120121"
d2 = ()
check4 :: Bool
check4 = True
check6 :: Bool
check6 = False
cover2 :: Bool -> ()
cover2 x
  = case x of
      True -> ()
      False -> ()
name4 = "bool.\120121.tt"
d4 :: Bool
d4 = True
name6 = "bool.\120121.ff"
d6 :: Bool
d6 = False
name8 = "bool.bool"
d8 = erased
name10 = "bool.~_"
d10 v0
  = case coe v0 of
      True -> coe False
      False -> coe True
      _ -> coe MAlonzo.RTE.mazUnreachableError
name12 = "bool._&&_"
d12 v0 v1
  = case coe v0 of
      True -> coe v1
      False -> coe v0
      _ -> coe MAlonzo.RTE.mazUnreachableError
name18 = "bool._||_"
d18 v0 v1
  = case coe v0 of
      True -> coe v0
      False -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name28 = "bool.if_then_else_"
d28 v0 v1 v2 v3 v4 = du28 v2 v3 v4
du28 v0 v1 v2
  = case coe v0 of
      True -> coe v1
      False -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name46 = "bool.if*_then_else_"
d46 v0 v1 v2 v3 v4 v5 = du46 v3 v4 v5
du46 v0 v1 v2
  = case coe v0 of
      True -> coe v1
      False -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name56 = "bool._xor_"
d56 v0 v1
  = case coe v0 of
      True
        -> case coe v1 of
             True -> coe False
             False -> coe v0
             _ -> coe MAlonzo.RTE.mazUnreachableError
      False
        -> case coe v1 of
             True -> coe v1
             False -> coe v1
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name58 = "bool._imp_"
d58 v0 v1
  = case coe v0 of
      True -> coe v1
      False -> coe True
      _ -> coe MAlonzo.RTE.mazUnreachableError
name64 = "bool._nand_"
d64 v0 v1
  = case coe v0 of
      True
        -> case coe v1 of
             True -> coe False
             False -> coe v0
             _ -> coe MAlonzo.RTE.mazUnreachableError
      False -> coe seq v1 True
      _ -> coe MAlonzo.RTE.mazUnreachableError
name66 = "bool._nor_"
d66 v0 v1 = coe d10 (coe d18 v0 v1)