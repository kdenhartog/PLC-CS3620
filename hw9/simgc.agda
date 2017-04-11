module simgc where

import parse
open import lib
open import memgraph-types
import memgraph

module parsem = parse memgraph.gratr2-nt ptr
open parsem
open parsem.pnoderiv memgraph.rrs memgraph.memgraph-rtn
open import run ptr
open noderiv {- from run.agda -}

process-strt : strt → 𝕃 string
process-strt s = strtToString s :: []

writeStringsToFiles : string → ℕ → 𝕃 string → IO ⊤
writeStringsToFiles name num (contents :: rest) =
  writeFile (name ^ "-" ^ (ℕ-to-string num) ^ ".gv") contents >>
  writeStringsToFiles name (suc num) rest
writeStringsToFiles _ _ [] = return triv

process : Run → IO ⊤
process (ParseTree (parsed-strt p) :: []) =
  writeStringsToFiles "mem" 0 (process-strt p)
process r = putStr ("Parsing failure (run with -" ^ "-showParsed).\n")

putStrRunIf : 𝔹 → Run → IO ⊤
putStrRunIf tt r = putStr (Run-to-string r) >> putStr "\n"
putStrRunIf ff r = return triv


processArgs : (showRun : 𝔹) → (showParsed : 𝔹) → 𝕃 string → IO ⊤ 
processArgs showRun showParsed (input-filename :: []) = (readFiniteFile input-filename) >>= processText
  where processText : string → IO ⊤
        processText x with runRtn (string-to-𝕃char x)
        processText x | s with s
        processText x | s | inj₁ cs = putStr "Characters left before failure : " >> putStr (𝕃char-to-string cs) >> putStr "\nCannot proceed to parsing.\n"
        processText x | s | inj₂ r with putStrRunIf showRun r | rewriteRun r
        processText x | s | inj₂ r | sr | r' with putStrRunIf showParsed r'
        processText x | s | inj₂ r | sr | r' | sr' = sr >> sr' >> process r'
                                     
processArgs showRun showParsed ("--showRun" :: xs) = processArgs tt showParsed xs 
processArgs showRun showParsed ("--showParsed" :: xs) = processArgs showRun tt xs 
processArgs showRun showParsed (x :: xs) = putStr ("Unknown option " ^ x ^ "\n")
processArgs showRun showParsed [] = putStr "Please run with the name of a file to process.\n"

main : IO ⊤
main = getArgs >>= processArgs ff ff
