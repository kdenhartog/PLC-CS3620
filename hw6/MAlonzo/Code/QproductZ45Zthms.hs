{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.QproductZ45Zthms where

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
import qualified MAlonzo.Code.Qfunctions
import qualified MAlonzo.Code.Qproduct

name10 = "product-thms.keep"
d10 v0 v1 v2 = du10 v2
du10 v0 = coe MAlonzo.Code.Qproduct.C24 v0 erased
name30 = "product-thms.,inj"
d30 v0 v1 v2 v3 v4 v5 v6 v7 v8 = du30
du30 = coe MAlonzo.Code.Qproduct.C24 erased erased
name48 = "product-thms.eta-\215"
d48 = erased
name68 = "product-thms._.eta-\215-aux"
d68 = erased
name90 = "product-thms.eq-\215"
d90 = erased
name98 = "product-thms.\8743-Isos.ext-set"
d98
  = error
      "MAlonzo Runtime Error: postulate evaluated: product-thms.\8743-Isos.ext-set"
name104 = "product-thms.\8743-Isos.\8743-unit-l"
d104 v0 v1 v2 = du104 v2
du104 v0 = coe MAlonzo.Code.Qproduct.C24 v0 erased
name112 = "product-thms.\8743-Isos.\8743-unit-r"
d112 v0 v1 v2 = du112 v2
du112 v0 = coe MAlonzo.Code.Qproduct.du152 (coe du104 v0)
name120 = "product-thms.\8743-Isos.\8743-unit-l-iso"
d120 v0 v1 = du120
du120
  = coe MAlonzo.Code.Qfunctions.C142 du104 MAlonzo.Code.Qproduct.du98
name130 = "product-thms.\8743-Isos._.aux"
d130 = erased
name138 = "product-thms.\8743-Isos.\8743-unit-r-iso"
d138 v0 v1 = du138
du138
  = coe
      MAlonzo.Code.Qfunctions.C142 du112 MAlonzo.Code.Qproduct.du112
name148 = "product-thms.\8743-Isos._.aux"
d148 = erased
name160 = "product-thms.\8743-Isos.\8743-assoc\8321"
d160 v0 v1 v2 v3 v4 = du160 v4
du160 v0
  = case coe v0 of
      MAlonzo.Code.Qproduct.C24 v1 v2
        -> case coe v2 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> coe
                    MAlonzo.Code.Qproduct.C24 (coe MAlonzo.Code.Qproduct.C24 v1 v3) v4
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name176 = "product-thms.\8743-Isos.\8743-assoc\8322"
d176 v0 v1 v2 v3 v4 = du176 v4
du176 v0
  = case coe v0 of
      MAlonzo.Code.Qproduct.C24 v1 v2
        -> case coe v1 of
             MAlonzo.Code.Qproduct.C24 v3 v4
               -> coe
                    MAlonzo.Code.Qproduct.C24 v3 (coe MAlonzo.Code.Qproduct.C24 v4 v2)
             _ -> coe MAlonzo.RTE.mazUnreachableError
      _ -> coe MAlonzo.RTE.mazUnreachableError
name192 = "product-thms.\8743-Isos.\8743-assoc-iso"
d192 v0 v1 v2 v3 = du192
du192 = coe MAlonzo.Code.Qfunctions.C142 du160 du176
name206 = "product-thms.\8743-Isos._.aux\8321"
d206 = erased
name216 = "product-thms.\8743-Isos._.aux\8322"
d216 = erased