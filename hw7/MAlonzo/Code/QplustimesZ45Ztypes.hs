{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QplustimesZ45Ztypes where

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

name2 = "plustimes-types.posinfo"
d2 = erased
name4 = "plustimes-types.anyDigs"
d4 = erased
name6 = "plustimes-types.anyDigs-range-5"
d6 = erased
name8 = "plustimes-types.anyDigs-star-6"
d8 = erased
name10 = "plustimes-types.id"
d10 = erased
name12 = "plustimes-types.id-plus-12"
d12 = erased
name14 = "plustimes-types.id-range-11"
d14 = erased
name16 = "plustimes-types.num"
d16 = erased
name18 = "plustimes-types.num-opt-10"
d18 = erased
name20 = "plustimes-types.numFirstPart"
d20 = erased
name22 = "plustimes-types.numFirstPart-bar-8"
d22 = erased
name24 = "plustimes-types.numSecondPart"
d24 = erased
name26 = "plustimes-types.numSecondPart-bar-9"
d26 = erased
name28 = "plustimes-types.posDig"
d28 = erased
name30 = "plustimes-types.posDig-range-7"
d30 = erased
name32 = "plustimes-types.expr"
d32 = ()
data T32 a0 a1 = C36 a0 | C38 a0 | C40 a0 | C42 a0 a1 | C44 a0 a1
name34 = "plustimes-types.strt"
d34 = ()
newtype T34 a0 = C46 a0
name48 = "plustimes-types.ParseTreeT"
d48 = ()
data T48 a0
  = C50 a0 | C52 a0 | C54 a0 | C56 a0 | C58 a0 | C60 a0 | C62 a0 |
    C64 a0 | C66 a0 | C68 a0 | C70 a0 | C72 a0 | C74 a0 | C76 a0 |
    C78 a0 | C80 a0 | C82 a0 | C84 | C86 | C88 | C90 | C92 | C94 | C96
name98 = "plustimes-types.posinfoToString"
d98 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name102 = "plustimes-types.anyDigsToString"
d102 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(anyDigs ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name106 = "plustimes-types.anyDigs-range-5ToString"
d106 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(anyDigs-range-5 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name110 = "plustimes-types.anyDigs-star-6ToString"
d110 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(anyDigs-star-6 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name114 = "plustimes-types.idToString"
d114 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name118 = "plustimes-types.id-plus-12ToString"
d118 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-plus-12 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name122 = "plustimes-types.id-range-11ToString"
d122 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(id-range-11 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name126 = "plustimes-types.numToString"
d126 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name130 = "plustimes-types.num-opt-10ToString"
d130 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-opt-10 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name134 = "plustimes-types.numFirstPartToString"
d134 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(numFirstPart ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name138 = "plustimes-types.numFirstPart-bar-8ToString"
d138 v0
  = coe
      MAlonzo.Code.Qstring.d12
      (coe Data.Text.pack "(numFirstPart-bar-8 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name142 = "plustimes-types.numSecondPartToString"
d142 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(numSecondPart ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name146 = "plustimes-types.numSecondPart-bar-9ToString"
d146 v0
  = coe
      MAlonzo.Code.Qstring.d12
      (coe Data.Text.pack "(numSecondPart-bar-9 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name150 = "plustimes-types.posDigToString"
d150 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posDig ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name154 = "plustimes-types.posDig-range-7ToString"
d154 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posDig-range-7 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name158 = "plustimes-types.exprToString"
d158 v0
  = case coe v0 of
      C36 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Id")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d114 v1) (coe Data.Text.pack ")")))
      C38 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Num")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d126 v1) (coe Data.Text.pack ")")))
      C40 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Parens")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1) (coe Data.Text.pack ")")))
      C42 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Plus")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d158 v2) (coe Data.Text.pack ")")))))
      C44 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Times")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d158 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name160 = "plustimes-types.strtToString"
d160 v0
  = case coe v0 of
      C46 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d158 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name178 = "plustimes-types.ParseTreeToString"
d178 v0
  = case coe v0 of
      C50 v1 -> coe d158 v1
      C52 v1 -> coe d160 v1
      C54 v1 -> coe d98 v1
      C56 v1 -> coe d102 v1
      C58 v1 -> coe d106 v1
      C60 v1 -> coe d110 v1
      C62 v1 -> coe d114 v1
      C64 v1 -> coe d118 v1
      C66 v1 -> coe d122 v1
      C68 v1 -> coe d126 v1
      C70 v1 -> coe d130 v1
      C72 v1 -> coe d134 v1
      C74 v1 -> coe d138 v1
      C76 v1 -> coe d142 v1
      C78 v1 -> coe d146 v1
      C80 v1 -> coe d150 v1
      C82 v1 -> coe d154 v1
      C84 -> coe Data.Text.pack "[aws]"
      C86 -> coe Data.Text.pack "[aws-bar-1]"
      C88 -> coe Data.Text.pack "[aws-bar-2]"
      C90 -> coe Data.Text.pack "[ows]"
      C92 -> coe Data.Text.pack "[ows-star-4]"
      C94 -> coe Data.Text.pack "[ws]"
      C96 -> coe Data.Text.pack "[ws-plus-3]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name216 = "plustimes-types.norm-strt"
d216 v0 = coe v0
name220 = "plustimes-types.norm-posinfo"
d220 v0 = coe v0
name224 = "plustimes-types.norm-expr"
d224 v0
  = case coe v0 of
      C42 v1 v2
        -> case coe v1 of
             C42 v3 v4 -> coe d224 (coe C42 v3 (coe d224 (coe C42 v4 v2)))
             _ -> coe v0
      C44 v1 v2
        -> let v3
                 = case coe v1 of
                     C42 v3 v4 -> coe d224 (coe C42 v3 (coe d224 (coe C44 v4 v2)))
                     C44 v3 v4 -> coe d224 (coe C44 v3 (coe d224 (coe C44 v4 v2)))
                     _ -> coe v0 in
           case coe v2 of
             C42 v4 v5 -> coe d224 (coe C42 (coe d224 (coe C44 v1 v4)) v5)
             _ -> coe v3
      _ -> coe v0
name256 = "plustimes-types.isParseTree"
d256 = erased
name264 = "plustimes-types.ptr"
d264 = coe MAlonzo.Code.QparseZ45Ztree.C1 d178