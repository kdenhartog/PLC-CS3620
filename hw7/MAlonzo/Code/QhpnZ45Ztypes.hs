{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QhpnZ45Ztypes where

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

name2 = "hpn-types.posinfo"
d2 = erased
name4 = "hpn-types.num"
d4 = erased
name6 = "hpn-types.num-bar-4"
d6 = erased
name8 = "hpn-types.posdig"
d8 = erased
name10 = "hpn-types.posdig-range-1"
d10 = erased
name12 = "hpn-types.posnum"
d12 = erased
name14 = "hpn-types.posnum-bar-2"
d14 = erased
name16 = "hpn-types.posnum-plus-3"
d16 = erased
name18 = "hpn-types.atom"
d18 = ()
newtype T18 a0 = C28 a0
name20 = "hpn-types.cmd"
d20 = ()
data T20 a0 a1 = C30 a0 a1 | C32 a0 a1
name22 = "hpn-types.cmds"
d22 = ()
data T22 a0 a1 = C34 a0 a1 | C36 a0
name24 = "hpn-types.hpn"
d24 = ()
data T24 a0 a1 = C38 a0 a1 | C40 a0 | C42
name26 = "hpn-types.strt"
d26 = ()
newtype T26 a0 = C44 a0
name46 = "hpn-types.ParseTreeT"
d46 = ()
data T46 a0
  = C48 a0 | C50 a0 | C52 a0 | C54 a0 | C56 a0 | C58 a0 | C60 a0 |
    C62 a0 | C64 a0 | C66 a0 | C68 a0 | C70 a0 | C72 a0 | C74 | C76 |
    C78 | C80 | C82 | C84 | C86
name88 = "hpn-types.posinfoToString"
d88 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posinfo ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name92 = "hpn-types.numToString"
d92 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name96 = "hpn-types.num-bar-4ToString"
d96 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(num-bar-4 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name100 = "hpn-types.posdigToString"
d100 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posdig ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name104 = "hpn-types.posdig-range-1ToString"
d104 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posdig-range-1 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name108 = "hpn-types.posnumToString"
d108 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posnum ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name112 = "hpn-types.posnum-bar-2ToString"
d112 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posnum-bar-2 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name116 = "hpn-types.posnum-plus-3ToString"
d116 v0
  = coe
      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(posnum-plus-3 ")
      (coe MAlonzo.Code.Qstring.d12 v0 (coe Data.Text.pack ")"))
name120 = "hpn-types.atomToString"
d120 v0
  = case coe v0 of
      C28 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Pow")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d126 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name122 = "hpn-types.cmdToString"
d122 v0
  = case coe v0 of
      C30 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(ToDecimal")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d126 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d108 v2) (coe Data.Text.pack ")")))))
      C32 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(ToHpn")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d108 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d108 v2) (coe Data.Text.pack ")")))))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name124 = "hpn-types.cmdsToString"
d124 v0
  = case coe v0 of
      C34 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(CmdsNext")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d122 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d124 v2) (coe Data.Text.pack ")")))))
      C36 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(CmdsStart")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d122 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name126 = "hpn-types.hpnToString"
d126 v0
  = case coe v0 of
      C38 v1 v2
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(SeqNext")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d120 v1)
                   (coe
                      MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                      (coe
                         MAlonzo.Code.Qstring.d12 (coe d126 v2) (coe Data.Text.pack ")")))))
      C40 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(SeqStart")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d120 v1) (coe Data.Text.pack ")")))
      C42
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "Zero")
             (coe Data.Text.pack "")
      _ -> coe MAlonzo.RTE.mazUnreachableError
name128 = "hpn-types.strtToString"
d128 v0
  = case coe v0 of
      C44 v1
        -> coe
             MAlonzo.Code.Qstring.d12 (coe Data.Text.pack "(Strt")
             (coe
                MAlonzo.Code.Qstring.d12 (coe Data.Text.pack " ")
                (coe
                   MAlonzo.Code.Qstring.d12 (coe d124 v1) (coe Data.Text.pack ")")))
      _ -> coe MAlonzo.RTE.mazUnreachableError
name154 = "hpn-types.ParseTreeToString"
d154 v0
  = case coe v0 of
      C48 v1 -> coe d120 v1
      C50 v1 -> coe d122 v1
      C52 v1 -> coe d124 v1
      C54 v1 -> coe d126 v1
      C56 v1 -> coe d128 v1
      C58 v1 -> coe d88 v1
      C60 v1 -> coe d92 v1
      C62 v1 -> coe d96 v1
      C64 v1 -> coe d100 v1
      C66 v1 -> coe d104 v1
      C68 v1 -> coe d108 v1
      C70 v1 -> coe d112 v1
      C72 v1 -> coe d116 v1
      C74 -> coe Data.Text.pack "[aws]"
      C76 -> coe Data.Text.pack "[aws-bar-5]"
      C78 -> coe Data.Text.pack "[aws-bar-6]"
      C80 -> coe Data.Text.pack "[ows]"
      C82 -> coe Data.Text.pack "[ows-star-8]"
      C84 -> coe Data.Text.pack "[ws]"
      C86 -> coe Data.Text.pack "[ws-plus-7]"
      _ -> coe MAlonzo.RTE.mazUnreachableError
name184 = "hpn-types.norm-strt"
d184 v0 = coe v0
name188 = "hpn-types.norm-posinfo"
d188 v0 = coe v0
name192 = "hpn-types.norm-hpn"
d192 v0 = coe v0
name196 = "hpn-types.norm-cmds"
d196 v0 = coe v0
name200 = "hpn-types.norm-cmd"
d200 v0 = coe v0
name204 = "hpn-types.norm-atom"
d204 v0 = coe v0
name218 = "hpn-types.isParseTree"
d218 = erased
name226 = "hpn-types.ptr"
d226 = coe MAlonzo.Code.QparseZ45Ztree.C1 d154