{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qmainx where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qnat
import qualified MAlonzo.Code.QnatZ45ZtoZ45Zstring
import qualified MAlonzo.Code.Qparse
import qualified MAlonzo.Code.Qrun
import qualified MAlonzo.Code.Qstring
import qualified MAlonzo.Code.Qsum
import qualified MAlonzo.Code.Qxml
import qualified MAlonzo.Code.QxmlZ45Zspans
import qualified MAlonzo.Code.QxmlZ45Ztypes

name6 = "mainx.parsem.pderiv.RE"
d6 a0 a1 = ()
name10 = "mainx.parsem.pderiv.insert-back-id"
d10 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du172 v2 v3
name12 = "mainx.parsem.pderiv.insert-front-id"
d12 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du164 v2 v3
name14 = "mainx.parsem.pderiv.parse"
d14 = coe MAlonzo.Code.Qparse.du190 MAlonzo.Code.QxmlZ45Ztypes.d312
name16 = "mainx.parsem.pderiv.parse-filter"
d16 = coe MAlonzo.Code.Qparse.du204 MAlonzo.Code.QxmlZ45Ztypes.d312
name18 = "mainx.parsem.pderiv.re-to-run"
d18 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du140 v2 v3
name20 = "mainx.parsem.pderiv.rewrite-main"
d20 v0 v1 v2 v3 v4 = coe MAlonzo.Code.Qparse.du504 v0 v3 v4
name22 = "mainx.parsem.pderiv.rewriteRun"
d22 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du604 v0 v3
name26 = "mainx.parsem.pderiv.runRtn"
d26 = coe MAlonzo.Code.Qparse.du484 MAlonzo.Code.QxmlZ45Ztypes.d312
name36 = "mainx.parsem.pnoderiv.RE"
d36 a0 a1 = ()
name40 = "mainx.parsem.pnoderiv.insert-back-id"
d40 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du670 v2 v3
name42 = "mainx.parsem.pnoderiv.insert-front-id"
d42 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du662 v2 v3
name44 = "mainx.parsem.pnoderiv.parse"
d44 = coe MAlonzo.Code.Qparse.du688 MAlonzo.Code.QxmlZ45Ztypes.d312
name46 = "mainx.parsem.pnoderiv.parse-filter"
d46 = coe MAlonzo.Code.Qparse.du702 MAlonzo.Code.QxmlZ45Ztypes.d312
name48 = "mainx.parsem.pnoderiv.re-to-run"
d48 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du644 v2 v3
name50 = "mainx.parsem.pnoderiv.rewrite-main"
d50 v0 v1 v2 v3 = coe MAlonzo.Code.Qparse.du998 v0 v2 v3
name52 = "mainx.parsem.pnoderiv.rewriteRun"
d52 v0 v1 v2 = coe MAlonzo.Code.Qparse.du1096 v0 v2
name56 = "mainx.parsem.pnoderiv.runRtn"
d56 = coe MAlonzo.Code.Qparse.du982 MAlonzo.Code.QxmlZ45Ztypes.d312
name82 = "mainx._.rewriteRun"
d82 = coe MAlonzo.Code.Qparse.du1096 MAlonzo.Code.Qxml.d450
name86 = "mainx._.runRtn"
d86
  = coe
      MAlonzo.Code.Qparse.du982 MAlonzo.Code.QxmlZ45Ztypes.d312 erased
      MAlonzo.Code.Qxml.d76
name154 = "mainx._.noderiv.Run"
d154 = erased
name182 = "mainx.compute-spans"
d182 v0
  = case coe v0 of
      MAlonzo.Code.QxmlZ45Ztypes.C50 v1 v2 v3
        -> case coe v1 of
             MAlonzo.Code.QxmlZ45Ztypes.C48 v4 v5 v6 v7
               -> case coe v3 of
                    MAlonzo.Code.QxmlZ45Ztypes.C42 v8 v9 v10
                      -> coe
                           MAlonzo.Code.Qlist.C18 (coe MAlonzo.Code.QxmlZ45Zspans.d50 v4 v10)
                           (coe
                              MAlonzo.Code.Qlist.du88
                              (coe
                                 MAlonzo.Code.Qbool.du28 (coe MAlonzo.Code.Qstring.d18 v5 v9)
                                 MAlonzo.Code.Qlist.C12
                                 (coe
                                    MAlonzo.Code.Qlist.du26
                                    (coe MAlonzo.Code.QxmlZ45Zspans.du56 v8 v10 v5)))
                              (coe d182 v2))
                    _ -> coe MAlonzo.RTE.mazUnreachableError
             _ -> coe MAlonzo.RTE.mazUnreachableError
      MAlonzo.Code.QxmlZ45Ztypes.C52 v1 v2
        -> coe MAlonzo.Code.Qlist.du88 (coe d182 v1) (coe d182 v2)
      MAlonzo.Code.QxmlZ45Ztypes.C54 v1
        -> case coe v1 of
             MAlonzo.Code.QxmlZ45Ztypes.C46 v2 v3 v4 v5
               -> coe
                    MAlonzo.Code.Qlist.du26 (coe MAlonzo.Code.QxmlZ45Zspans.du38 v2 v5)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name212 = "mainx.process-start"
d212 v0
  = case coe v0 of
      MAlonzo.Code.QxmlZ45Ztypes.C44 v1
        -> coe MAlonzo.Code.QxmlZ45Zspans.d30 (coe d182 v1)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name216 = "mainx.process"
d216 v0
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
                    MAlonzo.Code.QxmlZ45Ztypes.C62 v5
                      -> case coe v3 of
                           MAlonzo.Code.Qlist.C12 -> coe d212 v5
                           _ -> coe v1
                    _ -> coe v1
             _ -> coe v1
      _ -> coe v1
name222 = "mainx.putStrLn"
d222 v0
  = coe
      MAlonzo.Code.Qio.d14
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack "\n"))
name226 = "mainx.checkFile"
d226 v0
  = coe
      MAlonzo.Code.Qio.d12 erased erased (coe MAlonzo.Code.Qio.d64 v0)
      (\ v1 ->
         coe
           MAlonzo.Code.Qbool.du28 v1
           (coe
              MAlonzo.Code.Qio.d12 erased erased (coe MAlonzo.Code.Qio.d16 v0)
              (coe d234 v0))
           (coe
              d222
              (coe
                 MAlonzo.Code.QxmlZ45Zspans.d34
                 (coe
                    MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "Cannot open file \"")
                    (coe
                       MAlonzo.Code.Qstring.d12 v0
                       (coe Data.Text.pack "\" for reading."))))))
name234 = "mainx._.processText"
d234 v0 v1
  = let v2 = coe MAlonzo.Code.Qstring.d14 v1 in
    let v3
          = coe
              MAlonzo.Code.Qparse.du982 MAlonzo.Code.QxmlZ45Ztypes.d312 erased
              MAlonzo.Code.Qxml.d76 v2 in
    case coe v3 of
      MAlonzo.Code.Qsum.C22 v4
        -> coe
             d222
             (coe
                MAlonzo.Code.QxmlZ45Zspans.d34
                (coe
                   MAlonzo.Code.Qstring.d12
                   (coe Data.Text.pack "Parse error in file ")
                   (coe
                      MAlonzo.Code.Qstring.d12 v0
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " at position ")
                         (coe
                            MAlonzo.Code.Qstring.d12
                            (coe
                               MAlonzo.Code.QnatZ45ZtoZ45Zstring.d80
                               (coe
                                  MAlonzo.Code.Qnat.d30 (coe MAlonzo.Code.Qlist.du232 v2)
                                  (coe MAlonzo.Code.Qlist.du232 v4)))
                            (coe Data.Text.pack "."))))))
      MAlonzo.Code.Qsum.C26 v4
        -> let v5
                 = coe MAlonzo.Code.Qparse.du1096 MAlonzo.Code.Qxml.d450 v4 in
           coe d222 (coe d216 v5)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name268 = "mainx.readFilenamesForProcessing"
d268
  = coe
      MAlonzo.Code.Qio.du86
      (coe MAlonzo.Code.Qio.d12 erased erased MAlonzo.Code.Qio.d24 d226)
      d268
main = d270
name270 = "mainx.main"
d270 = d268