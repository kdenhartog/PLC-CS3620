{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qhmain where

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
import qualified MAlonzo.Code.Qhtml
import qualified MAlonzo.Code.Qio
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.QnatZ45ZtoZ45Zstring
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qstring

name2 = "hmain.prefixes"
d2 = MAlonzo.Code.Qhtml.du128
name4 = "hmain.test"
d4 v0
  = let v1
          = coe
              MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "html")
              MAlonzo.Code.Qlist.C12
              (coe
                 MAlonzo.Code.Qlist.du26
                 (coe
                    MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "body")
                    MAlonzo.Code.Qlist.C12
                    (coe
                       MAlonzo.Code.Qlist.du26
                       (coe
                          MAlonzo.Code.Qhtml.C16
                          (coe
                             MAlonzo.Code.Qstring.d12
                             (coe Data.Text.pack "There is no test numbered ")
                             (coe MAlonzo.Code.QnatZ45ZtoZ45Zstring.d80 v0)))))) in
    case coe v0 of
      1 -> coe
             MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "html")
             MAlonzo.Code.Qlist.C12
             (coe
                MAlonzo.Code.Qlist.du26
                (coe
                   MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "body")
                   MAlonzo.Code.Qlist.C12
                   (coe
                      MAlonzo.Code.Qlist.C18
                      (coe
                         MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "p")
                         MAlonzo.Code.Qlist.C12
                         (coe
                            MAlonzo.Code.Qlist.du26
                            (coe MAlonzo.Code.Qhtml.C16 (coe Data.Text.pack "Go Hawks"))))
                      (coe
                         MAlonzo.Code.Qlist.C18
                         (coe
                            MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "p")
                            MAlonzo.Code.Qlist.C12
                            (coe
                               MAlonzo.Code.Qlist.du26
                               (coe MAlonzo.Code.Qhtml.C16 (coe Data.Text.pack "Big Ten"))))
                         MAlonzo.Code.Qlist.C12))))
      2 -> coe
             MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "html")
             MAlonzo.Code.Qlist.C12
             (coe
                MAlonzo.Code.Qlist.du26
                (coe
                   MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "body")
                   MAlonzo.Code.Qlist.C12
                   (coe
                      MAlonzo.Code.Qlist.C18
                      (coe
                         MAlonzo.Code.Qhtml.d84 MAlonzo.Code.Qhtml.d70
                         (coe
                            MAlonzo.Code.Qlist.C18
                            (coe MAlonzo.Code.Qhtml.C16 (coe Data.Text.pack "some items "))
                            (coe
                               MAlonzo.Code.Qlist.C18
                               (coe
                                  MAlonzo.Code.Qhtml.C16 (coe Data.Text.pack "in a nice little "))
                               (coe
                                  MAlonzo.Code.Qlist.C18
                                  (coe MAlonzo.Code.Qhtml.C16 (coe Data.Text.pack "unordered list"))
                                  MAlonzo.Code.Qlist.C12))))
                      (coe
                         MAlonzo.Code.Qlist.C18
                         (coe
                            MAlonzo.Code.Qhtml.d84 MAlonzo.Code.Qhtml.d72
                            (coe
                               MAlonzo.Code.Qlist.C18
                               (coe
                                  MAlonzo.Code.Qhtml.C16
                                  (coe Data.Text.pack "and a couple more items "))
                               (coe
                                  MAlonzo.Code.Qlist.C18
                                  (coe
                                     MAlonzo.Code.Qhtml.C16
                                     (coe Data.Text.pack "in an ordered list"))
                                  MAlonzo.Code.Qlist.C12)))
                         MAlonzo.Code.Qlist.C12))))
      3 -> coe
             MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "html")
             MAlonzo.Code.Qlist.C12
             (coe
                MAlonzo.Code.Qlist.du26
                (coe
                   MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "body")
                   (coe
                      MAlonzo.Code.Qlist.du26
                      (coe
                         MAlonzo.Code.Qproduct.C24 (coe Data.Text.pack "style")
                         (coe Data.Text.pack "font-size : 2em")))
                   d2))
      4 -> coe
             MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "html")
             MAlonzo.Code.Qlist.C12
             (coe
                MAlonzo.Code.Qlist.du26
                (coe
                   MAlonzo.Code.Qhtml.C12 (coe Data.Text.pack "body")
                   (coe
                      MAlonzo.Code.Qlist.du26
                      (coe
                         MAlonzo.Code.Qproduct.C24 (coe Data.Text.pack "style")
                         (coe Data.Text.pack "font-size : 2em")))
                   MAlonzo.Code.Qhtml.du176))
      _ | geqInt v0 (4 :: Integer) -> coe v1
      _ | geqInt v0 (3 :: Integer) -> coe v1
      _ | geqInt v0 (2 :: Integer) -> coe v1
      _ | geqInt v0 (1 :: Integer) -> coe v1
      _ -> coe v1
name8 = "hmain.show-test"
d8 v0 = coe MAlonzo.Code.Qio.d14 (coe MAlonzo.Code.Qhtml.d26 v0)
name12 = "hmain.do-test"
d12 v0 v1
  = case coe v0 of
      True
        -> coe
             MAlonzo.Code.Qio.d14 (coe MAlonzo.Code.Qhtml.d66 (coe d4 v1))
      False
        -> coe
             MAlonzo.Code.Qio.d14 (coe MAlonzo.Code.Qhtml.d26 (coe d4 v1))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name18 = "hmain.processArgs"
d18 v0
  = let v1
          = coe
              MAlonzo.Code.Qio.d14
              (coe
                 MAlonzo.Code.Qstring.d12
                 (coe
                    Data.Text.pack
                    "Please run with a command-line that looks like this:\n")
                 (coe
                    MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "  hmain I N\n")
                    (coe
                       Data.Text.pack
                       "where I is either \"indented\" or \"not\" (without the quotes), and N is a number.\n"))) in
    case coe v0 of
      MAlonzo.Code.Qlist.C18 v2 v3
        -> case coe v3 of
             MAlonzo.Code.Qlist.C18 v4 v5
               -> case coe v5 of
                    MAlonzo.Code.Qlist.C12
                      -> coe
                           d12 (coe du28 v2) (coe MAlonzo.Code.QnatZ45ZtoZ45Zstring.d118 v4)
                    _ -> coe v1
             _ -> coe v1
      _ -> coe v1
name28 = "hmain._.is-indented"
d28 v0 v1 v2 = du28 v2
du28 v0
  = case coe v0 of
      _ | (==) v0 (Data.Text.pack "indented") -> coe True
      _ -> coe False
main = d30
name30 = "hmain.main"
d30
  = coe MAlonzo.Code.Qio.d12 erased erased MAlonzo.Code.Qio.d60 d18