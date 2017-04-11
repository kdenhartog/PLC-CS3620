{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QboolZ45Zthms2 where

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
import qualified MAlonzo.Code.Qproduct
import qualified MAlonzo.Code.Qsum

name4 = "bool-thms2.ff-imp"
d4 = erased
name8 = "bool-thms2.imp-tt"
d8 = erased
name12 = "bool-thms2.imp-ff"
d12 = erased
name16 = "bool-thms2.tt-imp"
d16 = erased
name20 = "bool-thms2.&&-tt"
d20 = erased
name24 = "bool-thms2.||-ff"
d24 = erased
name28 = "bool-thms2.&&-contra"
d28 = erased
name34 = "bool-thms2.&&-comm"
d34 = erased
name40 = "bool-thms2.||-comm"
d40 = erased
name48 = "bool-thms2.&&-assoc"
d48 = erased
name56 = "bool-thms2.||-assoc"
d56 = erased
name62 = "bool-thms2.~-over-&&"
d62 = erased
name68 = "bool-thms2.~-over-||"
d68 = erased
name76 = "bool-thms2.&&-over-||-l"
d76 = erased
name84 = "bool-thms2.&&-over-||-r"
d84 = erased
name92 = "bool-thms2.||-over-&&-l"
d92 = erased
name100 = "bool-thms2.||-over-&&-r"
d100 = erased
name108 = "bool-thms2.&&-cong\8321"
d108 = erased
name116 = "bool-thms2.&&-cong\8322"
d116 = erased
name122 = "bool-thms2.&&-intro"
d122 = erased
name128 = "bool-thms2.||-intro1"
d128 = erased
name136 = "bool-thms2.&&-elim"
d136 v0 v1 v2 = du136 v0 v1
du136 v0 v1
  = coe
      seq v0 (coe seq v1 (coe MAlonzo.Code.Qproduct.C24 erased erased))
name142 = "bool-thms2.&&-elim1"
d142 = erased
name156 = "bool-thms2.&&-elim2"
d156 = erased
name172 = "bool-thms2.||-elim"
d172 v0 v1 v2 = du172 v0
du172 v0
  = case coe v0 of
      True -> coe MAlonzo.Code.Qsum.C22 erased
      False -> coe MAlonzo.Code.Qsum.C26 erased
      _ -> coe MAlonzo.RTE.mazUnreachableError
name178 = "bool-thms2.~-cong"
d178 = erased
name192 = "bool-thms2.ite-cong\8321"
d192 = erased
name210 = "bool-thms2.ite-cong\8322"
d210 = erased
name228 = "bool-thms2.ite-cong\8323"
d228 = erased
name238 = "bool-thms2.&&-split"
d238 v0 v1 v2 = du238 v0 v1
du238 v0 v1
  = coe seq v0 (coe seq v1 (coe MAlonzo.Code.Qsum.C22 erased))
name244 = "bool-thms2.imp-same"
d244 = erased
name250 = "bool-thms2.imp-to-||"
d250 = erased
name256 = "bool-thms2.imp-mp"
d256 = erased
name276 = "bool-thms2.imp-antisymm"
d276 = erased
name292 = "bool-thms2.ff-xor"
d292 = erased
name296 = "bool-thms2.tt-xor"
d296 = erased
name302 = "bool-thms2.~-xor-distrb"
d302 = erased
name308 = "bool-thms2.xor-distrib-&&"
d308 = erased
name314 = "bool-thms2.xor~hop"
d314 = erased
name320 = "bool-thms2.xor-comm"
d320 = erased
name328 = "bool-thms2.xor-assoc"
d328 = erased
name332 = "bool-thms2.xor-anti-idem"
d332 = erased
name338 = "bool-thms2.xor-\8801"
d338 = erased
name346 = "bool-thms2.nor-not"
d346 = erased
name352 = "bool-thms2.nor-or"
d352 = erased
name360 = "bool-thms2.nor-and"
d360 = erased
name368 = "bool-thms2.nor-comm"
d368 = erased
name374 = "bool-thms2.nand-comm"
d374 = erased