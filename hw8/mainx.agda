module mainx where

import parse
open import lib
open import xml-spans
open import xml-types
import xml

module parsem = parse xml.gratr2-nt ptr
open parsem
open parsem.pnoderiv xml.rrs xml.xml-rtn
open import run ptr
open noderiv {- from run.agda -}

compute-spans : xml → 𝕃 span
compute-spans (Nested (StartTag pi x aa pi') m (EndTag pi2 x2 pi2')) =
  Nested-span pi pi2' ::
  (if x =string x2 then [] else [ endtag-mismatch-span pi2 pi2' x x2 ]) ++
  compute-spans m 
compute-spans (Seq x1 x2) = compute-spans x1 ++ compute-spans x2
compute-spans (StartEnd (Startendtag pi x aa pi')) = [ StartEnd-span pi x pi' ]

process-start : start → string
process-start (Strt x) = spans-to-string (compute-spans x)

process : Run → string
process (ParseTree (parsed-start p) :: []) = process-start p
process r = "Parsing failure (run with -" ^ "-showParsed).\n"

putStrLn : string → IO ⊤
putStrLn str = putStr (str ^ "\n")

checkFile : string → IO ⊤
checkFile filename =
 doesFileExist filename >>= λ b → 
   (if b then
     (readFiniteFile filename >>= processText)
   else
     putStrLn (global-error-string ("Cannot open file \"" ^ filename ^ "\" for reading.")))

  where processText : string → IO ⊤
        processText x with string-to-𝕃char x
        processText _ | x with runRtn x
        processText _ | x | inj₁ cs =
          putStrLn (global-error-string ("Parse error in file " ^ filename ^ " at position " ^ (ℕ-to-string (length x ∸ length cs)) ^ "."))
        processText _ | x | inj₂ r with rewriteRun r
        processText _ | x | inj₂ r | r' = putStrLn (process r')

-- this is the function that handles requests (from the frontend) on standard input
{-# TERMINATING #-}
readFilenamesForProcessing : IO ⊤
readFilenamesForProcessing =
    getLine >>= checkFile >> readFilenamesForProcessing 

main : IO ⊤
main = readFilenamesForProcessing

