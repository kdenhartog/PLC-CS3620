{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qchar where

import MAlonzo.RTE (coe, erased, addInt, subInt, mulInt, quotInt,
                    remInt, geqInt, ltInt, eqInt, eqFloat)
import qualified Control.DeepSeq
import qualified Data.Text.IO
import qualified MAlonzo.RTE
import qualified System.Directory
import qualified System.Environment
import qualified System.FilePath
import qualified System.IO
import qualified Data.Char
import qualified Data.Text
import qualified MAlonzo.Code.Qbool

name2 = "char.char"
d2 = error "MAlonzo Runtime Error: postulate evaluated: char.char"
name4 = "char.primCharToNat"
d4 = (fromIntegral . fromEnum :: Char -> Integer)
name6 = "char.primCharEquality"
d6 = (\ x y -> ((==) :: Char -> Char -> Bool) ( x) ( y))
name8 = "char.toNat"
d8 = d4
name10 = "char._=char_"
d10 = d6
name16 = "char.\8801char-to-="
d16
  = error
      "MAlonzo Runtime Error: postulate evaluated: char.\8801char-to-="
name22 = "char.=char-to-\8801"
d22
  = error
      "MAlonzo Runtime Error: postulate evaluated: char.=char-to-\8801"
name28 = "char.=char-sym"
d28 = erased
name86 = "char._<char_"
d86 :: (Char -> (Char -> Bool))
d86 = (<)
name88 = "char.is-digit"
d88 v0
  = case coe v0 of
      '0' -> coe True
      '1' -> coe True
      '2' -> coe True
      '3' -> coe True
      '4' -> coe True
      '5' -> coe True
      '6' -> coe True
      '7' -> coe True
      '8' -> coe True
      '9' -> coe True
      _ -> coe False