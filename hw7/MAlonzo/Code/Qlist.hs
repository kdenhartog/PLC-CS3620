{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qlist where

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
import qualified MAlonzo.Code.Qmaybe
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qsum

name6 = "list.\120131"
d6 a0 a1 = ()
data T6 a0 a1 = C12 | C18 a0 a1
name20 = "list.list"
d20 = erased
name26 = "list.[_]"
d26 v0 v1 v2 = du26 v2
du26 v0 = coe C18 v0 C12
name34 = "list.is-empty"
d34 v0 v1 v2 = du34 v2
du34 v0
  = case coe v0 of
      C12 -> coe True
      C18 v1 v2 -> coe False
      _ -> coe MAlonzo.RTE.mazUnreachableError
name40 = "list.tail"
d40 v0
  = case coe v0 of
      C12 -> coe v0
      C18 v1 v2 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name52 = "list.head"
d52 v0 v1 v2 v3 = du52 v2
du52 v0
  = case coe v0 of
      C18 v1 v2 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name64 = "list.head2"
d64 v0 v1 v2 = du64 v2
du64 v0
  = case coe v0 of
      C12 -> coe MAlonzo.Code.Qmaybe.C14
      C18 v1 v2 -> coe MAlonzo.Code.Qmaybe.C12 v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name74 = "list.last"
d74 v0 v1 v2 v3 = du74 v2
du74 v0
  = case coe v0 of
      C18 v1 v2
        -> case coe v2 of
             C12 -> coe v1
             C18 v3 v4 -> coe du74 v2
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name88 = "list._++_"
d88 v0 v1 v2 v3 = du88 v2 v3
du88 v0 v1
  = case coe v0 of
      C12 -> coe v1
      C18 v2 v3 -> coe C18 v2 (coe du88 v3 v1)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name102 = "list.concat"
d102 v0 v1 v2 = du102 v2
du102 v0
  = case coe v0 of
      C12 -> coe v0
      C18 v1 v2 -> coe du88 v1 (coe du102 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name112 = "list.repeat"
d112 v0 v1 v2 v3 = du112 v2 v3
du112 v0 v1
  = case coe v0 of
      0 -> coe C12
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           coe C18 v1 (coe du112 v2 v1)
name128 = "list.map"
d128 v0 v1 v2 v3 v4 v5 = du128 v4 v5
du128 v0 v1
  = case coe v1 of
      C12 -> coe v1
      C18 v2 v3 -> coe C18 (coe v0 v2) (coe du128 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name142 = "list.list-funct"
d142 v0 v1 v2 v3 = du142 v2 v3
du142 v0 v1 = coe du128 v0 v1
name156 = "list.\120131maybe-map"
d156 v0 v1 v2 v3 v4 v5 = du156 v4 v5
du156 v0 v1
  = case coe v1 of
      C12 -> coe MAlonzo.Code.Qmaybe.C12 v1
      C18 v2 v3
        -> let v4 = coe v0 v2 in
           case coe v4 of
             MAlonzo.Code.Qmaybe.C12 v5
               -> let v6 = coe du156 v0 v3 in
                  case coe v6 of
                    MAlonzo.Code.Qmaybe.C12 v7
                      -> coe MAlonzo.Code.Qmaybe.C12 (coe C18 v5 v7)
                    MAlonzo.Code.Qmaybe.C14 -> coe v6
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             MAlonzo.Code.Qmaybe.C14 -> coe v4
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name214 = "list.foldr"
d214 v0 v1 v2 v3 v4 v5 v6 = du214 v4 v5 v6
du214 v0 v1 v2
  = case coe v2 of
      C12 -> coe v1
      C18 v3 v4 -> coe v0 v3 (coe du214 v0 v1 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name232 = "list.length"
d232 v0 v1 v2 = du232 v2
du232 v0
  = case coe v0 of
      C12 -> 0 :: Integer
      C18 v1 v2 -> coe addInt (1 :: Integer) (coe du232 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name242 = "list.reverse-helper"
d242 v0 v1 v2 v3 = du242 v2 v3
du242 v0 v1
  = case coe v1 of
      C12 -> coe v0
      C18 v2 v3 -> coe du242 (coe C18 v2 v0) v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name256 = "list.reverse"
d256 v0 v1 v2 = du256 v2
du256 v0 = coe du242 C12 v0
name270 = "list.list-member"
d270 v0 v1 v2 v3 v4 = du270 v2 v3 v4
du270 v0 v1 v2
  = case coe v2 of
      C12 -> coe False
      C18 v3 v4
        -> coe MAlonzo.Code.Qbool.d18 (coe v0 v1 v3) (coe du270 v0 v1 v4)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name294 = "list.list-minus"
d294 v0 v1 v2 v3 v4 = du294 v2 v3 v4
du294 v0 v1 v2
  = case coe v1 of
      C12 -> coe v1
      C18 v3 v4
        -> coe
             MAlonzo.Code.Qbool.du28 (coe du270 v0 v3 v2) (coe du294 v0 v4 v2)
             (coe C18 v3 (coe du294 v0 v4 v2))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name318 = "list._longer_"
d318 v0 v1 v2 v3 = du318 v2 v3
du318 v0 v1
  = case coe v0 of
      C12 -> coe False
      C18 v2 v3
        -> case coe v1 of
             C12 -> coe True
             C18 v4 v5 -> coe du318 v3 v5
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name342 = "list._shorter_"
d342 v0 v1 v2 v3 = du342 v2 v3
du342 v0 v1 = coe du318 v1 v0
name356 = "list.list-all"
d356 v0 v1 v2 v3 = du356 v2 v3
du356 v0 v1
  = case coe v1 of
      C12 -> coe True
      C18 v2 v3
        -> coe MAlonzo.Code.Qbool.d12 (coe v0 v2) (coe du356 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name368 = "list.all-pred"
d368 = erased
name386 = "list.list-any"
d386 v0 v1 v2 v3 = du386 v2 v3
du386 v0 v1
  = case coe v1 of
      C12 -> coe False
      C18 v2 v3
        -> coe MAlonzo.Code.Qbool.d18 (coe v0 v2) (coe du386 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name398 = "list.list-and"
d398 v0
  = case coe v0 of
      C12 -> coe True
      C18 v1 v2 -> coe MAlonzo.Code.Qbool.d12 v1 (coe d398 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name406 = "list.list-or"
d406 v0
  = case coe v0 of
      C12 -> coe False
      C18 v1 v2 -> coe MAlonzo.Code.Qbool.d18 v1 (coe d406 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name418 = "list.list-max"
d418 v0 v1 v2 v3 v4 = du418 v2 v3 v4
du418 v0 v1 v2
  = case coe v1 of
      C12 -> coe v2
      C18 v3 v4
        -> coe
             du418 v0 v4 (coe MAlonzo.Code.Qbool.du28 (coe v0 v3 v2) v2 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name436 = "list.isSublist"
d436 v0 v1 v2 v3 v4 = du436 v2 v3 v4
du436 v0 v1 v2 = coe du356 (\ v3 -> coe du270 v2 v3 v1) v0
name454 = "list.=\120131"
d454 v0 v1 v2 v3 v4 = du454 v2 v3 v4
du454 v0 v1 v2
  = case coe v1 of
      C12
        -> case coe v2 of
             C12 -> coe True
             _ -> coe False
      C18 v3 v4
        -> case coe v2 of
             C18 v5 v6
               -> coe MAlonzo.Code.Qbool.d12 (coe v0 v3 v5) (coe du454 v0 v4 v6)
             _ -> coe False
      _ -> coe MAlonzo.RTE.mazUnreachableError
name474 = "list.filter"
d474 v0 v1 v2 v3 = du474 v2 v3
du474 v0 v1
  = case coe v1 of
      C12 -> coe v1
      C18 v2 v3
        -> coe
             MAlonzo.Code.Qbool.du28 (coe v0 v2) (coe C18 v2 (coe du474 v0 v3))
             (coe du474 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name496 = "list.remove"
d496 v0 v1 v2 v3 v4 = du496 v2 v3 v4
du496 v0 v1 v2
  = coe du474 (\ v3 -> coe MAlonzo.Code.Qbool.d10 (coe v0 v1 v3)) v2
name510 = "list.nthTail"
d510 v0 v1 v2 v3 = du510 v2 v3
du510 v0 v1
  = case coe v0 of
      0 -> coe v1
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             C12 -> coe v1
             C18 v3 v4 -> coe du510 v2 v4
             _ -> coe MAlonzo.RTE.mazUnreachableError
name526 = "list.nth"
d526 v0 v1 v2 v3 = du526 v2 v3
du526 v0 v1
  = case coe v1 of
      C12 -> coe MAlonzo.Code.Qmaybe.C14
      C18 v2 v3
        -> case coe v0 of
             0 -> coe MAlonzo.Code.Qmaybe.C12 v2
             _ -> let v4 = coe subInt v0 (1 :: Integer) in coe du526 v4 v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name538 = "list.nats-down"
d538 v0
  = case coe v0 of
      0 -> coe du26 (0 :: Integer)
      _ -> let v1 = coe subInt v0 (1 :: Integer) in
           coe C18 v0 (coe d538 v1)
name550 = "list.zip"
d550 v0 v1 v2 v3 v4 v5 = du550 v4 v5
du550 v0 v1
  = case coe v0 of
      C12
        -> case coe v1 of
             C12 -> coe v1
             C18 v2 v3 -> coe v0
             _ -> coe MAlonzo.RTE.mazUnreachableError
      C18 v2 v3
        -> case coe v1 of
             C12 -> coe v1
             C18 v4 v5
               -> coe C18 (coe MAlonzo.Code.Qproduct.C24 v2 v4) (coe du550 v3 v5)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name576 = "list.unzip"
d576 v0 v1 v2 v3 v4 = du576 v4
du576 v0
  = case coe v0 of
      C12 -> coe MAlonzo.Code.Qproduct.C24 v0 v0
      C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> let v5 = coe du576 v2 in
                  case coe v5 of
                    MAlonzo.Code.Qproduct.C24 v6 v7
                      -> coe MAlonzo.Code.Qproduct.C24 (coe C18 v3 v6) (coe C18 v4 v7)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name610 = "list.map-\8846"
d610 v0 v1 v2 v3 v4 v5 v6 v7 v8 = du610 v6 v7 v8
du610 v0 v1 v2
  = case coe v2 of
      C12 -> coe v2
      C18 v3 v4
        -> case coe v3 of
             MAlonzo.Code.Qsum.C22 v5
               -> coe C18 (coe v0 v5) (coe du610 v0 v1 v4)
             MAlonzo.Code.Qsum.C26 v5
               -> coe C18 (coe v1 v5) (coe du610 v0 v1 v4)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name640 = "list.proj-\8846\8321"
d640 v0 v1 v2 v3 v4 = du640 v4
du640 v0
  = case coe v0 of
      C12 -> coe v0
      C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qsum.C22 v3 -> coe C18 v3 (coe du640 v2)
             MAlonzo.Code.Qsum.C26 v3 -> coe du640 v2
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name658 = "list.proj-\8846\8322"
d658 v0 v1 v2 v3 v4 = du658 v4
du658 v0
  = case coe v0 of
      C12 -> coe v0
      C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qsum.C22 v3 -> coe du658 v2
             MAlonzo.Code.Qsum.C26 v3 -> coe C18 v3 (coe du658 v2)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name672 = "list.drop-nothing"
d672 v0 v1 v2 = du672 v2
du672 v0
  = case coe v0 of
      C12 -> coe v0
      C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qmaybe.C12 v3 -> coe C18 v3 (coe du672 v2)
             MAlonzo.Code.Qmaybe.C14 -> coe du672 v2
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError