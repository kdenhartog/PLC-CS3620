{-# LANGUAGE EmptyDataDecls, ExistentialQuantification,
             ScopedTypeVariables, NoMonomorphismRestriction, Rank2Types #-}
module MAlonzo.Code.Qio where

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
import qualified MAlonzo.Code.Qlist
import qualified MAlonzo.Code.Qstring
import qualified MAlonzo.Code.Qunit

name2 = "io.IO"
d2 = error "MAlonzo Runtime Error: postulate evaluated: io.IO"
name6 = "io.return"
d6 :: (forall xA. (() -> (xA -> (IO xA))))
d6 = (\ _ -> return )
name12 = "io._>>=_"
d12 ::
  (forall xA. (() -> (forall xB. (() -> ((IO xA) -> ((xA -> (IO xB)) -> (IO xB)))))))
d12 = (\ _ _ -> (>>=))
name14 = "io.putStr"
d14 :: (Data.Text.Text -> (IO ()))
d14 = Data.Text.IO.putStr
name16 = "io.readFiniteFile"
d16 :: (Data.Text.Text -> (IO Data.Text.Text))
d16
  = (\y -> let x = Data.Text.unpack y in do inh <- System.IO.openFile x System.IO.ReadMode; System.IO.hSetEncoding inh System.IO.utf8; fileAsString <- System.IO.hGetContents inh; Control.DeepSeq.rnf fileAsString `seq` System.IO.hClose inh; return (Data.Text.pack fileAsString))
name18 = "io.writeFile"
d18 :: (Data.Text.Text -> (Data.Text.Text -> (IO ())))
d18
  = (\path -> (\str -> do outh <- System.IO.openFile (Data.Text.unpack path) System.IO.WriteMode; System.IO.hSetNewlineMode outh System.IO.noNewlineTranslation; System.IO.hSetEncoding outh System.IO.utf8; Data.Text.IO.hPutStr outh str; System.IO.hFlush outh; System.IO.hClose outh; return () ))
name20 = "io.initializeStdoutToUTF8"
d20 :: (IO ())
d20 = System.IO.hSetEncoding System.IO.stdout System.IO.utf8
name22 = "io.setStdoutNewlineMode"
d22 :: (IO ())
d22
  = System.IO.hSetNewlineMode System.IO.stdout System.IO.universalNewlineMode
name24 = "io.getLine"
d24 :: (IO Data.Text.Text)
d24 = (Data.Text.IO.hGetLine System.IO.stdin)
name28 = "io.simple-list"
d28 a0 = ()
check32 :: (forall xA. (([]) xA))
check32 = []
check34 :: (forall xA. (xA -> ((([]) xA) -> (([]) xA))))
check34 = (:)
cover28 :: ([]) a1 -> ()
cover28 x
  = case x of
      [] -> ()
      (:) _ _ -> ()
name32 = "io.simple-list.nil"
d32 :: (forall xA. (([]) xA))
d32 = []
name34 = "io.simple-list.cons"
d34 :: (forall xA. (xA -> ((([]) xA) -> (([]) xA))))
d34 = (:)
name38 = "io.simple-list-to-\120131"
d38 v0 v1 = du38 v1
du38 v0
  = case coe v0 of
      [] -> coe MAlonzo.Code.Qlist.C12
      (:) v1 v2 -> coe MAlonzo.Code.Qlist.C18 v1 (coe du38 v2)
      _ -> coe MAlonzo.RTE.mazUnreachableError
name44 = "io.privGetArgs"
d44 :: (IO (([]) Data.Text.Text))
d44
  = (do l <- System.Environment.getArgs; return (map Data.Text.pack l))
name46 = "io.privDoesFileExist"
d46 :: (Data.Text.Text -> (IO Bool))
d46 = (\ s -> System.Directory.doesFileExist (Data.Text.unpack s))
name48 = "io.privCreateDirectoryIfMissing"
d48 :: (Bool -> (Data.Text.Text -> (IO ())))
d48
  = (\ b s -> System.Directory.createDirectoryIfMissing b (Data.Text.unpack s))
name50 = "io.privTakeDirectory"
d50 :: (Data.Text.Text -> Data.Text.Text)
d50
  = (\ s -> Data.Text.pack (System.FilePath.takeDirectory (Data.Text.unpack s)))
name52 = "io.privTakeFileName"
d52 :: (Data.Text.Text -> Data.Text.Text)
d52
  = (\ s -> Data.Text.pack (System.FilePath.takeFileName (Data.Text.unpack s)))
name54 = "io.privCombineFileNames"
d54 :: (Data.Text.Text -> (Data.Text.Text -> Data.Text.Text))
d54
  = (\ s1 s2 -> Data.Text.pack (System.FilePath.combine (Data.Text.unpack s1) (Data.Text.unpack s2)))
name56 = "io.privForceFileRead"
d56 :: (Data.Text.Text -> (IO ()))
d56
  = (\ contents -> seq (length (Data.Text.unpack contents)) (return ()))
name58 = "io.privGetHomeDirectory"
d58 :: (IO Data.Text.Text)
d58
  = (do x <- System.Directory.getHomeDirectory; return (Data.Text.pack x))
name60 = "io.getArgs"
d60
  = coe d12 erased erased d44 (\ v0 -> coe d6 erased (coe du38 v0))
name64 = "io.doesFileExist"
d64 = d46
name66 = "io.createDirectoryIfMissing"
d66 = d48
name68 = "io.takeDirectory"
d68 = d50
name70 = "io.takeFileName"
d70 = d52
name72 = "io.combineFileNames"
d72 = d54
name74 = "io.forceFileRead"
d74 = d56
name76 = "io.getHomeDirectory"
d76 = d58
name78 = "io.fileIsOlder"
d78 :: (Data.Text.Text -> (Data.Text.Text -> (IO Bool)))
d78
  = (\ s1 s2 -> (System.Directory.getModificationTime (Data.Text.unpack s1)) >>= \ t1 -> (System.Directory.getModificationTime (Data.Text.unpack s2)) >>= \ t2 -> return (t1 < t2))
name80 = "io.canonicalizePath"
d80 :: (Data.Text.Text -> (IO Data.Text.Text))
d80
  = (\ s -> do x <- System.Directory.canonicalizePath (Data.Text.unpack s); return (Data.Text.pack x))
name86 = "io._>>_"
d86 v0 v1 v2 v3 = du86 v2 v3
du86 v0 v1 = coe d12 erased erased v0 (\ v2 -> v1)
name94 = "io.base-filenameh"
d94 v0
  = case coe v0 of
      MAlonzo.Code.Qlist.C12 -> coe v0
      MAlonzo.Code.Qlist.C18 v1 v2
        -> let v3 = coe d94 v2 in
           case coe v1 of
             '.' -> coe v2
             _ -> coe v3
      _ -> coe MAlonzo.RTE.mazUnreachableError
name100 = "io.base-filename"
d100 v0
  = coe
      MAlonzo.Code.Qstring.d16
      (coe
         MAlonzo.Code.Qlist.du256
         (coe
            d94
            (coe MAlonzo.Code.Qlist.du256 (coe MAlonzo.Code.Qstring.d14 v0))))