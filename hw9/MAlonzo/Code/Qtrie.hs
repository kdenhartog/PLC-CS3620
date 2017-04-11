{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qtrie where

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
import qualified MAlonzo.Code.Qchar
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qmaybe
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qstring

name2 = "trie.cal"
d2 = erased
name8 = "trie.empty-cal"
d8 v0 = du8
du8 = MAlonzo.Code.Qlist.C12
name12 = "trie.cal-lookup"
d12 v0 v1 v2 = du12 v1 v2
du12 v0 v1
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe MAlonzo.Code.Qmaybe.C14
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qproduct.C24 v4 v5
               -> let v6 = coe MAlonzo.Code.Qchar.d10 v4 v1 in
                  case coe v6 of
                    True -> coe MAlonzo.Code.Qmaybe.C12 v5
                    False -> coe du12 v3 v1
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name44 = "trie.cal-insert"
d44 v0 v1 v2 v3 = du44 v1 v2 v3
du44 v0 v1 v2
  = case coe v0 of
      MAlonzo.Code.Qlist.C12
        -> coe
             MAlonzo.Code.Qlist.C18 (coe MAlonzo.Code.Qproduct.C24 v1 v2) v0
      MAlonzo.Code.Qlist.C18 v3 v4
        -> case coe v3 of
             MAlonzo.Code.Qproduct.C24 v5 v6
               -> let v7 = coe MAlonzo.Code.Qchar.d10 v1 v5 in
                  case coe v7 of
                    True
                      -> coe
                           MAlonzo.Code.Qlist.C18 (coe MAlonzo.Code.Qproduct.C24 v1 v2) v4
                    False -> coe MAlonzo.Code.Qlist.C18 v3 (coe du44 v4 v1 v2)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name86 = "trie.cal-remove"
d86 v0 v1 v2 = du86 v1 v2
du86 v0 v1
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qproduct.C24 v4 v5
               -> let v6 = coe MAlonzo.Code.Qchar.d10 v4 v1 in
                  case coe v6 of
                    True -> coe du86 v3 v1
                    False -> coe MAlonzo.Code.Qlist.C18 v2 (coe du86 v3 v1)
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name118 = "trie.cal-add"
d118 v0 v1 v2 v3 = du118 v1 v2 v3
du118 v0 v1 v2
  = coe
      MAlonzo.Code.Qlist.C18 (coe MAlonzo.Code.Qproduct.C24 v1 v2) v0
name126 = "trie.test-cal-insert"
d126
  = coe
      du44
      (coe
         MAlonzo.Code.Qlist.C18
         (coe MAlonzo.Code.Qproduct.C24 'a' (1 :: Integer))
         (coe
            MAlonzo.Code.Qlist.C18
            (coe MAlonzo.Code.Qproduct.C24 'b' (2 :: Integer))
            MAlonzo.Code.Qlist.C12))
      'b' (20 :: Integer)
name130 = "trie.trie"
d130 a0 = ()
data T130 a0 a1 = C134 a0 a1
name138 = "trie.empty-trie"
d138 v0 = du138
du138 = coe C134 MAlonzo.Code.Qmaybe.C14 du8
name142 = "trie.trie-lookup-h"
d142 v0 v1 v2 = du142 v1 v2
du142 v0 v1
  = case coe v0 of
      C134 v2 v3
        -> case coe v1 of
             MAlonzo.Code.Qlist.C12 -> coe v2
             MAlonzo.Code.Qlist.C18 v4 v5
               -> let v6 = coe du12 v3 v4 in
                  case coe v6 of
                    MAlonzo.Code.Qmaybe.C12 v7 -> coe du142 v7 v5
                    MAlonzo.Code.Qmaybe.C14 -> coe v6
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name180 = "trie.trie-lookup"
d180 v0 v1 v2 = du180 v1 v2
du180 v0 v1 = coe du142 v0 (coe MAlonzo.Code.Qstring.d14 v1)
name188 = "trie.trie-contains"
d188 v0 v1 v2 = du188 v1 v2
du188 v0 v1
  = let v2 = coe du180 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qmaybe.C12 v3 -> coe True
      MAlonzo.Code.Qmaybe.C14 -> coe False
      _ -> coe MAlonzo.RTE.mazUnreachableError
name208 = "trie.trie-insert-h"
d208 v0 v1 v2 v3 = du208 v1 v2 v3
du208 v0 v1 v2
  = case coe v0 of
      C134 v3 v4
        -> case coe v1 of
             MAlonzo.Code.Qlist.C12
               -> coe C134 (coe MAlonzo.Code.Qmaybe.C12 v2) v4
             MAlonzo.Code.Qlist.C18 v5 v6
               -> let v7 = coe du12 v4 v5 in
                  case coe v7 of
                    MAlonzo.Code.Qmaybe.C12 v8
                      -> coe C134 v3 (coe du44 v4 v5 (coe du208 v8 v6 v2))
                    MAlonzo.Code.Qmaybe.C14
                      -> coe C134 v3 (coe du118 v4 v5 (coe du208 du138 v6 v2))
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name254 = "trie.trie-insert"
d254 v0 v1 v2 v3 = du254 v1 v2 v3
du254 v0 v1 v2 = coe du208 v0 (coe MAlonzo.Code.Qstring.d14 v1) v2
name264 = "trie.trie-remove-h"
d264 v0 v1 v2 = du264 v1 v2
du264 v0 v1
  = case coe v0 of
      C134 v2 v3
        -> case coe v1 of
             MAlonzo.Code.Qlist.C12 -> coe C134 MAlonzo.Code.Qmaybe.C14 v3
             MAlonzo.Code.Qlist.C18 v4 v5
               -> let v6 = coe du12 v3 v4 in
                  case coe v6 of
                    MAlonzo.Code.Qmaybe.C12 v7
                      -> coe C134 v2 (coe du44 v3 v4 (coe du264 v7 v5))
                    MAlonzo.Code.Qmaybe.C14 -> coe v0
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name302 = "trie.trie-remove"
d302 v0 v1 v2 = du302 v1 v2
du302 v0 v1 = coe du264 v0 (coe MAlonzo.Code.Qstring.d14 v1)
name312 = "trie.trie-map"
d312 v0 v1 v2 v3 = du312 v2 v3
du312 v0 v1
  = case coe v1 of
      C134 v2 v3
        -> coe C134 (coe MAlonzo.Code.Qmaybe.du72 v0 v2) (coe du318 v0 v3)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name318 = "trie.trie-cal-map"
d318 v0 v1 v2 v3 = du318 v2 v3
du318 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> coe v1
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qproduct.C24 v4 v5
               -> coe
                    MAlonzo.Code.Qlist.C18
                    (coe MAlonzo.Code.Qproduct.C24 v4 (coe du312 v0 v5))
                    (coe du318 v0 v3)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name338 = "trie.trie-to-string-h"
d338 v0 v1 v2 v3 v4 = du338 v1 v2 v3 v4
du338 v0 v1 v2 v3
  = case coe v2 of
      C134 v4 v5
        -> case coe v4 of
             MAlonzo.Code.Qmaybe.C12 v6
               -> coe
                    MAlonzo.Code.Qstring.d12
                    (coe MAlonzo.Code.Qstring.d16 (coe MAlonzo.Code.Qlist.du256 v3))
                    (coe
                       MAlonzo.Code.Qstring.d12 v0
                       (coe
                          MAlonzo.Code.Qstring.d12 (coe v1 v6)
                          (coe
                             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "\n")
                             (coe du342 v0 v1 v5 v3))))
             MAlonzo.Code.Qmaybe.C14 -> coe du342 v0 v1 v5 v3
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name342 = "trie.trie-cal-to-string-h"
d342 v0 v1 v2 v3 v4 = du342 v1 v2 v3 v4
du342 v0 v1 v2 v3
  = case coe v2 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v4 v5
        -> case coe v4 of
             MAlonzo.Code.Qproduct.C24 v6 v7
               -> coe
                    MAlonzo.Code.Qstring.d12
                    (coe du338 v0 v1 v7 (coe MAlonzo.Code.Qlist.C18 v6 v3))
                    (coe du342 v0 v1 v5 v3)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name382 = "trie.trie-to-string"
d382 v0 v1 v2 v3 = du382 v1 v2 v3
du382 v0 v1 v2 = coe du338 v0 v1 v2 MAlonzo.Code.Qlist.C12
name392 = "trie.trie-mappings-h"
d392 v0 v1 v2 = du392 v1 v2
du392 v0 v1
  = case coe v0 of
      C134 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qmaybe.C12 v4
               -> coe
                    MAlonzo.Code.Qlist.C18
                    (coe
                       MAlonzo.Code.Qproduct.C24
                       (coe MAlonzo.Code.Qstring.d16 (coe MAlonzo.Code.Qlist.du256 v1))
                       v4)
                    (coe du396 v3 v1)
             MAlonzo.Code.Qmaybe.C14 -> coe du396 v3 v1
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name396 = "trie.trie-cal-mappings-h"
d396 v0 v1 v2 = du396 v1 v2
du396 v0 v1
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qproduct.C24 v4 v5
               -> coe
                    MAlonzo.Code.Qlist.du88
                    (coe du392 v5 (coe MAlonzo.Code.Qlist.C18 v4 v1)) (coe du396 v3 v1)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name420 = "trie.trie-mappings"
d420 v0 v1 = du420 v1
du420 v0 = coe du392 v0 MAlonzo.Code.Qlist.C12
name426 = "trie.trie-strings"
d426 v0 v1 = du426 v1
du426 v0
  = coe
      MAlonzo.Code.Qlist.du128 MAlonzo.Code.Qproduct.du98 (coe du420 v0)
name432 = "trie.trie-nonempty"
d432 v0 v1 = du432 v1
du432 v0
  = case coe v0 of
      C134 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qmaybe.C12 v3 -> coe True
             MAlonzo.Code.Qmaybe.C14 -> coe du436 v2
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name436 = "trie.trie-cal-nonempty"
d436 v0 v1 = du436 v1
du436 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe False
      MAlonzo.Code.Qlist.C18 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> coe MAlonzo.Code.Qbool.d18 (coe du432 v4) (coe du436 v2)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name450 = "trie.\120131trie"
d450 = erased
name456 = "trie.\120131trie-lookup"
d456 v0 v1 v2 = du456 v1 v2
du456 v0 v1
  = let v2 = coe du180 v0 v1 in
    case coe v2 of
      MAlonzo.Code.Qmaybe.C12 v3 -> coe v3
      MAlonzo.Code.Qmaybe.C14 -> coe MAlonzo.Code.Qlist.C12
      _ -> coe MAlonzo.RTE.mazUnreachableError
name478 = "trie.\120131trie-add"
d478 v0 v1 v2 v3 = du478 v1 v2 v3
du478 v0 v1 v2
  = coe du254 v0 v1 (coe MAlonzo.Code.Qlist.C18 v2 (coe du456 v0 v1))
name488 = "trie.\120131trie-add*"
d488 v0 v1 v2 v3 = du488 v1 v2 v3
du488 v0 v1 v2
  = coe
      du254 v0 v1 (coe MAlonzo.Code.Qlist.du88 v2 (coe du456 v0 v1))
name496 = "trie.stringset"
d496 = erased
name498 = "trie.stringset-contains"
d498 v0 v1 = coe du188 v0 v1
name504 = "trie.stringset-insert"
d504 v0 v1 = coe du254 v0 v1 erased
name510 = "trie.stringset-remove"
d510 v0 v1 = coe du302 v0 v1
name516 = "trie.stringset-insert\120131"
d516 v0 v1 = coe du208 v0 v1 erased
name522 = "trie.empty-stringset"
d522 = du138
name524 = "trie.stringset-insert*"
d524 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v2 v3 -> coe d504 (coe d524 v0 v3) v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name536 = "trie.stringset-strings"
d536 v0 v1 = du536 v1
du536 v0
  = coe
      MAlonzo.Code.Qlist.du128 MAlonzo.Code.Qproduct.du98 (coe du420 v0)