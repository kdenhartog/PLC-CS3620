{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qnat where

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

name2 = "nat.\8469"
d2 = ()
name8 = "nat.nat"
d8 = erased
name10 = "nat._+_"
d10 = ((+) :: Integer -> Integer -> Integer)
name18 = "nat._*_"
d18 = ((*) :: Integer -> Integer -> Integer)
name26 = "nat.pred"
d26 v0
  = case coe v0 of
      0 -> 0 :: Integer
      _ -> coe subInt v0 (1 :: Integer)
name30 = "nat._\8760_"
d30 = ((\ x y -> max 0 (x - y)) :: Integer -> Integer -> Integer)
name40 = "nat.square"
d40 v0 = coe mulInt v0 v0
name44 = "nat._<_"
d44 v0 v1
  = case coe v0 of
      0 -> case coe v1 of
             0 -> coe False
             _ -> coe True
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             0 -> coe False
             _ -> let v3 = coe subInt v1 (1 :: Integer) in coe d44 v2 v3
name54 = "nat._=\8469_"
d54 v0 v1
  = case coe v0 of
      0 -> case coe v1 of
             0 -> coe True
             _ -> coe False
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             _ | geqInt v1 (1 :: Integer) ->
                 let v3 = coe subInt v1 (1 :: Integer) in coe d54 v2 v3
             _ -> coe False
name60 = "nat._\8804_"
d60 v0 v1
  = coe MAlonzo.Code.Qbool.d18 (coe d44 v0 v1) (coe d54 v0 v1)
name66 = "nat._>_"
d66 v0 v1 = coe d44 v1 v0
name72 = "nat._\8805_"
d72 v0 v1 = coe d60 v1 v0
name78 = "nat.min"
d78 v0 v1 = coe MAlonzo.Code.Qbool.du28 (coe d44 v0 v1) v0 v1
name84 = "nat.max"
d84 v0 v1 = coe MAlonzo.Code.Qbool.du28 (coe d44 v0 v1) v1 v0
name90 = "nat.compare-t"
d90 = ()
data T90 = C92 | C94 | C96
name98 = "nat.compare"
d98 v0 v1
  = case coe v0 of
      0 -> case coe v1 of
             0 -> coe C94
             _ -> coe C92
      _ -> let v2 = coe subInt v0 (1 :: Integer) in
           case coe v1 of
             0 -> coe C96
             _ -> let v3 = coe subInt v1 (1 :: Integer) in coe d98 v2 v3
name108 = "nat.iszero"
d108 v0
  = case coe v0 of
      0 -> coe True
      _ -> coe False
name110 = "nat.parity"
d110 v0
  = case coe v0 of
      0 -> coe False
      _ -> let v1 = coe subInt v0 (1 :: Integer) in
           coe MAlonzo.Code.Qbool.d10 (coe d110 v1)
name114 = "nat._pow_"
d114 v0 v1
  = case coe v1 of
      0 -> 1 :: Integer
      _ -> let v2 = coe subInt v1 (1 :: Integer) in
           coe mulInt v0 (coe d114 v0 v2)
name122 = "nat.factorial"
d122 v0
  = case coe v0 of
      0 -> 1 :: Integer
      _ -> let v1 = coe subInt v0 (1 :: Integer) in
           coe mulInt v0 (coe d122 v1)
name126 = "nat.is-even"
d126 v0
  = case coe v0 of
      0 -> coe True
      _ -> let v1 = coe subInt v0 (1 :: Integer) in coe d128 v1
name128 = "nat.is-odd"
d128 v0
  = case coe v0 of
      0 -> coe False
      _ -> let v1 = coe subInt v0 (1 :: Integer) in coe d126 v1