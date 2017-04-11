{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QboolZ45Zthms where

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
import qualified MAlonzo.Code.Qsum

name4 = "bool-thms.~~-elim"
d4 = erased
name8 = "bool-thms.&&-idem"
d8 = erased
name12 = "bool-thms.||-idem"
d12 = erased
name18 = "bool-thms.||\8801ff\8321"
d18 = erased
name28 = "bool-thms.||\8801ff\8322"
d28 = erased
name34 = "bool-thms.||-tt"
d34 = erased
name42 = "bool-thms.||-cong\8321"
d42 = erased
name50 = "bool-thms.||-cong\8322"
d50 = erased
name66 = "bool-thms.ite-same"
d66 = erased
name88 = "bool-thms.ite-arg"
d88 = erased
name106 = "bool-thms.\120121-contra"
d106 = MAlonzo.RTE.mazUnreachableError
name112 = "bool-thms.||-split"
d112 v0 v1 v2 = du112 v0 v1
du112 v0 v1
  = case coe v0 of
      True -> coe seq v1 (coe MAlonzo.Code.Qsum.C22 erased)
      False -> coe seq v1 (coe MAlonzo.Code.Qsum.C26 erased)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name122 = "bool-thms.\120121-dec"
d122 v0
  = case coe v0 of
      True -> coe MAlonzo.Code.Qsum.C22 erased
      False -> coe MAlonzo.Code.Qsum.C26 erased
      _ -> coe MAlonzo.RTE.mazUnreachableError
name128 = "bool-thms.&&-snd"
d128 = erased
name136 = "bool-thms.&&-fst"
d136 = erased
name144 = "bool-thms.&&-combo"
d144 = erased
name156 = "bool-thms.&&-ff"
d156 = erased