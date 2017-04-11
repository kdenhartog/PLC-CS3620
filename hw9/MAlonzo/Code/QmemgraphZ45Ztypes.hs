{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QmemgraphZ45Ztypes where

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
import qualified MAlonzo.Code.QparseZ45Ztree
import qualified MAlonzo.Code.Qstring

name2 = "memgraph-types.posinfo"
d2 = erased
name4 = "memgraph-types.id"
d4 = erased
name6 = "memgraph-types.id-plus-6"
d6 = erased
name8 = "memgraph-types.id-range-5"
d8 = erased
name10 = "memgraph-types.idlist"
d10 = ()
data T10 a0 a1 = C16 a0 | C18 a0 a1
name12 = "memgraph-types.ids"
d12 = ()
data T12 a0 a1 = C20 a0 a1 | C22 a0
name14 = "memgraph-types.strt"
d14 = ()
data T14 a0 a1 = C24 a0 a1
name26 = "memgraph-types.ParseTreeT"
d26 = ()
data T26 a0
  = C28 a0 | C30 a0 | C32 a0 | C34 a0 | C36 a0 | C38 a0 | C40 a0 |
    C42 | C44 | C46 | C48 | C50 | C52 | C54
name56 = "memgraph-types.posinfoToString"
d56 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name60 = "memgraph-types.idToString"
d60 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name64 = "memgraph-types.id-plus-6ToString"
d64 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-plus-6 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name68 = "memgraph-types.id-range-5ToString"
d68 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-range-5 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name72 = "memgraph-types.idlistToString"
d72 v0
  = case coe v0 of
      C16 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(LastIdList")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1) (coe Data.Text.pack ")")))
      C18 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(NextIdList")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d74 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d72 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name74 = "memgraph-types.idsToString"
d74 v0
  = case coe v0 of
      C20 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(edge")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d60 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d72 v2) (coe Data.Text.pack ")")))))
      C22 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(node")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d60 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name76 = "memgraph-types.strtToString"
d76 v0
  = case coe v0 of
      C24 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d72 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d72 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name94 = "memgraph-types.ParseTreeToString"
d94 v0
  = case coe v0 of
      C28 v1 -> coe d72 v1
      C30 v1 -> coe d74 v1
      C32 v1 -> coe d76 v1
      C34 v1 -> coe d56 v1
      C36 v1 -> coe d60 v1
      C38 v1 -> coe d64 v1
      C40 v1 -> coe d68 v1
      C42 -> coe Data.Text.pack "[aws]"
      C44 -> coe Data.Text.pack "[aws-bar-1]"
      C46 -> coe Data.Text.pack "[aws-bar-2]"
      C48 -> coe Data.Text.pack "[ows]"
      C50 -> coe Data.Text.pack "[ows-star-4]"
      C52 -> coe Data.Text.pack "[ws]"
      C54 -> coe Data.Text.pack "[ws-plus-3]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name112 = "memgraph-types.norm-strt"
d112 v0 = coe v0
name116 = "memgraph-types.norm-posinfo"
d116 v0 = coe v0
name120 = "memgraph-types.norm-ids"
d120 v0 = coe v0
name124 = "memgraph-types.norm-idlist"
d124 v0 = coe v0
name134 = "memgraph-types.isParseTree"
d134 = erased
name142 = "memgraph-types.ptr"
d142 = coe MAlonzo.Code.QparseZ45Ztree.C1 d94