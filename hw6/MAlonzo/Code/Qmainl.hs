{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qmainl where

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
import qualified MAlonzo.Code.Qio
import qualified MAlonzo.Code.Qlettuce
import qualified MAlonzo.Code.QlettuceZ45Ztypes
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qmaybe
import qualified MAlonzo.Code.Qparse
import qualified MAlonzo.Code.Qrun
import qualified MAlonzo.Code.Qstring
import qualified MAlonzo.Code.Qsum
import qualified MAlonzo.Code.Qtrie

name6 = "mainl.parsem.pderiv.RE"
d6 a0 a1 = ()
name10 = "mainl.parsem.pderiv.insert-back-id"
d10 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du172 v2 v3
name12 = "mainl.parsem.pderiv.insert-front-id"
d12 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du164 v2 v3
name14 = "mainl.parsem.pderiv.parse"
d14
  = coe MAlonzo.Code.Qparse.du190 MAlonzo.Code.QlettuceZ45Ztypes.d230
name16 = "mainl.parsem.pderiv.parse-filter"
d16
  = coe MAlonzo.Code.Qparse.du204 MAlonzo.Code.QlettuceZ45Ztypes.d230
name18 = "mainl.parsem.pderiv.re-to-run"
d18 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du140 v2 v3
name20 = "mainl.parsem.pderiv.rewrite-main"
d20 v0 v1 v2 v3 v4 = coe MAlonzo.Code.Qparse.du504 v0 v3 v4
name22 = "mainl.parsem.pderiv.rewriteRun"
d22 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du604 v0 v3
name26 = "mainl.parsem.pderiv.runRtn"
d26
  = coe MAlonzo.Code.Qparse.du484 MAlonzo.Code.QlettuceZ45Ztypes.d230
name36 = "mainl.parsem.pnoderiv.RE"
d36 a0 a1 = ()
name40 = "mainl.parsem.pnoderiv.insert-back-id"
d40 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du670 v2 v3
name42 = "mainl.parsem.pnoderiv.insert-front-id"
d42 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du662 v2 v3
name44 = "mainl.parsem.pnoderiv.parse"
d44
  = coe MAlonzo.Code.Qparse.du688 MAlonzo.Code.QlettuceZ45Ztypes.d230
name46 = "mainl.parsem.pnoderiv.parse-filter"
d46
  = coe MAlonzo.Code.Qparse.du702 MAlonzo.Code.QlettuceZ45Ztypes.d230
name48 = "mainl.parsem.pnoderiv.re-to-run"
d48 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du644 v2 v3
name50 = "mainl.parsem.pnoderiv.rewrite-main"
d50 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du998 v0 v2 v3
name52 = "mainl.parsem.pnoderiv.rewriteRun"
d52 v0 v1 v2 = coe MAlonzo.Code.Qparse.du1096 v0 v2
name56 = "mainl.parsem.pnoderiv.runRtn"
d56
  = coe MAlonzo.Code.Qparse.du982 MAlonzo.Code.QlettuceZ45Ztypes.d230
name82 = "mainl._.rewriteRun"
d82 = coe MAlonzo.Code.Qparse.du1096 MAlonzo.Code.Qlettuce.d340
name86 = "mainl._.runRtn"
d86
  = coe
      MAlonzo.Code.Qparse.du982 MAlonzo.Code.QlettuceZ45Ztypes.d230
      erased MAlonzo.Code.Qlettuce.d66
name154 = "mainl._.noderiv.Run"
d154 = erased
name156 = "mainl._.noderiv.Run-to-string"
d156
  = coe MAlonzo.Code.Qrun.d134 MAlonzo.Code.QlettuceZ45Ztypes.d230
name182 = "mainl.get-used"
d182 v0 = du182
du182 = MAlonzo.Code.Qlist.C12
name186 = "mainl.get-declared"
d186 v0 = du186
du186 = MAlonzo.Code.Qlist.C12
name190 = "mainl.vars-to-string-h2"
d190 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe Data.Text.pack ""
      MAlonzo.Code.Qlist.C18 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "")
             (coe
                MAlonzo.Code.Qstring.d12 v1
                (coe
                   MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ") (coe d190 v2)))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name196 = "mainl.vars-to-string-h1"
d196 v0 v1 v2
  = case coe v1 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v3 v4
        -> coe d196 (coe MAlonzo.Code.Qtrie.du254 v0 v3 v2) v4 v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name210 = "mainl.vars-to-string"
d210 v0
  = coe
      d190
      (coe
         MAlonzo.Code.Qtrie.du426
         (coe d196 MAlonzo.Code.Qtrie.du138 v0 (coe Data.Text.pack "")))
name214 = "mainl.test0"
d214
  = coe
      MAlonzo.Code.Qlist.C18 (coe Data.Text.pack "test")
      (coe
         MAlonzo.Code.Qlist.C18 (coe Data.Text.pack "cat")
         (coe
            MAlonzo.Code.Qlist.C18 (coe Data.Text.pack "dog")
            (coe
               MAlonzo.Code.Qlist.C18 (coe Data.Text.pack "do")
               (coe
                  MAlonzo.Code.Qlist.C18 (coe Data.Text.pack "dog")
                  MAlonzo.Code.Qlist.C12))))
name216 = "mainl.global-to-var"
d216 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C24 v1 v2 -> coe v1
      _ -> coe MAlonzo.RTE.mazUnreachableError
name222 = "mainl.global-to-num"
d222 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C24 v1 v2 -> coe v2
      _ -> coe MAlonzo.RTE.mazUnreachableError
name228 = "mainl.process-g-test-h"
d228 v0 v1
  = case coe v1 of
      MAlonzo.Code.QlettuceZ45Ztypes.C26 v2 v3
        -> let v4 = coe MAlonzo.Code.Qtrie.du180 v0 (coe d216 v2) in
           case coe v4 of
             MAlonzo.Code.Qmaybe.C12 v5 -> coe v5
             MAlonzo.Code.Qmaybe.C14
               -> coe
                    d228 (coe MAlonzo.Code.Qtrie.du254 v0 (coe d216 v2) (coe d222 v2))
                    v3
             _ -> coe MAlonzo.RTE.mazUnreachableError
      MAlonzo.Code.QlettuceZ45Ztypes.C28 -> coe Data.Text.pack ""
      _ -> coe MAlonzo.RTE.mazUnreachableError
name256 = "mainl.gs-to-var"
d256 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C26 v1 v2
        -> coe MAlonzo.Code.Qlist.C18 (coe d216 v1) (coe d256 v2)
      MAlonzo.Code.QlettuceZ45Ztypes.C28 -> coe MAlonzo.Code.Qlist.C12
      _ -> coe MAlonzo.RTE.mazUnreachableError
name262 = "mainl.ls-to-var"
d262 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C30 v1 v2 v3 v4
        -> coe
             MAlonzo.Code.Qlist.C18 v2
             (coe MAlonzo.Code.Qlist.du88 (coe d262 v3) (coe d262 v4))
      MAlonzo.Code.QlettuceZ45Ztypes.C32 v1 -> coe d262 v1
      MAlonzo.Code.QlettuceZ45Ztypes.C34 v1 v2
        -> coe MAlonzo.Code.Qlist.du88 (coe d262 v1) (coe d262 v2)
      MAlonzo.Code.QlettuceZ45Ztypes.C36 v1 v2
        -> coe MAlonzo.Code.Qlist.C12
      _ -> coe MAlonzo.RTE.mazUnreachableError
name282 = "mainl.ls-to-var1"
d282 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C30 v1 v2 v3 v4
        -> coe MAlonzo.Code.Qlist.du88 (coe d282 v3) (coe d282 v4)
      MAlonzo.Code.QlettuceZ45Ztypes.C32 v1 -> coe d282 v1
      MAlonzo.Code.QlettuceZ45Ztypes.C34 v1 v2
        -> coe MAlonzo.Code.Qlist.du88 (coe d282 v1) (coe d282 v2)
      MAlonzo.Code.QlettuceZ45Ztypes.C36 v1 v2
        -> coe MAlonzo.Code.Qlist.C18 v2 MAlonzo.Code.Qlist.C12
      _ -> coe MAlonzo.RTE.mazUnreachableError
name302 = "mainl.dec-print"
d302 v0 v1
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "declared: ")
      (coe
         d210 (coe MAlonzo.Code.Qlist.du88 (coe d256 v0) (coe d262 v1)))
name308 = "mainl.used-print"
d308 v0 v1
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "used: ")
      (coe
         d210 (coe MAlonzo.Code.Qlist.du88 (coe d256 v0) (coe d282 v1)))
name314 = "mainl.process-start"
d314 v0
  = case coe v0 of
      MAlonzo.Code.QlettuceZ45Ztypes.C38 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe d228 MAlonzo.Code.Qtrie.du138 v1)
             (coe MAlonzo.Code.Qstring.d12 (coe d302 v1 v2) (coe d308 v1 v2))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name320 = "mainl.process"
d320 v0
  = let v1
          = coe
              MAlonzo.Code.Qstring.d12
              (coe Data.Text.pack "Parsing failure (run with -")
              (coe Data.Text.pack "-showParsed).\n") in
    case coe v0 of
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v2 of
             MAlonzo.Code.Qrun.C112 v4
               -> case coe v4 of
                    MAlonzo.Code.QlettuceZ45Ztypes.C52 v5
                      -> case coe v3 of
                           MAlonzo.Code.Qlist.C12 -> coe d314 v5
                           _ -> coe v1
                    _ -> coe v1
             _ -> coe v1
      _ -> coe v1
name326 = "mainl.putStrRunIf"
d326 v0 v1
  = case coe v0 of
      True
        -> coe
             MAlonzo.Code.Qio.du86
             (coe
                MAlonzo.Code.Qio.d14
                (coe
                   MAlonzo.Code.Qrun.d134 MAlonzo.Code.QlettuceZ45Ztypes.d230 v1))
             (coe MAlonzo.Code.Qio.d14 (coe Data.Text.pack "\n"))
      False -> coe MAlonzo.Code.Qio.d6 erased erased
      _ -> coe MAlonzo.RTE.mazUnreachableError
name334 = "mainl.processText"
d334 v0 v1
  = let v2
          = coe
              MAlonzo.Code.Qparse.du982 MAlonzo.Code.QlettuceZ45Ztypes.d230
              erased MAlonzo.Code.Qlettuce.d66
              (coe MAlonzo.Code.Qstring.d14 v1) in
    case coe v2 of
      MAlonzo.Code.Qsum.C22 v3
        -> coe
             MAlonzo.Code.Qio.du86
             (coe
                MAlonzo.Code.Qio.du86
                (coe
                   MAlonzo.Code.Qio.d14
                   (coe Data.Text.pack "Characters left before failure : "))
                (coe MAlonzo.Code.Qio.d14 (coe MAlonzo.Code.Qstring.d16 v3)))
             (coe
                MAlonzo.Code.Qio.d14
                (coe Data.Text.pack "\nCannot proceed to parsing.\n"))
      MAlonzo.Code.Qsum.C26 v3
        -> let v4
                 = coe MAlonzo.Code.Qparse.du1096 MAlonzo.Code.Qlettuce.d340 v3 in
           let v5 = coe d326 v0 v4 in
           coe
             MAlonzo.Code.Qio.du86 v5 (coe MAlonzo.Code.Qio.d14 (coe d320 v4))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name402 = "mainl.processArgs"
d402 v0 v1
  = case coe v1 of
      MAlonzo.Code.Qlist.C12
        -> coe
             MAlonzo.Code.Qio.d14
             (coe
                Data.Text.pack "Please run with the name of a file to process.\n")
      MAlonzo.Code.Qlist.C18 v2 v3
        -> let v4
                 = let v4
                         = coe
                             MAlonzo.Code.Qio.d14
                             (coe
                                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "Unknown option ")
                                (coe MAlonzo.Code.Qstring.d12 v2 (coe Data.Text.pack "\n"))) in
                   case coe v2 of
                     _ | (==) v2 (Data.Text.pack "--showParsed") -> coe d402 True v3
                     _ -> coe v4 in
           case coe v3 of
             MAlonzo.Code.Qlist.C12
               -> coe
                    MAlonzo.Code.Qio.d12 erased erased (coe MAlonzo.Code.Qio.d16 v2)
                    (coe d334 v0)
             _ -> coe v4
      _ -> coe MAlonzo.RTE.mazUnreachableError
main = d420
name420 = "mainl.main"
d420
  = coe
      MAlonzo.Code.Qio.d12 erased erased MAlonzo.Code.Qio.d60
      (coe d402 False)