module hmain where

open import lib
open import html

prefixes : 𝕃 html
prefixes = p-prefixes (string-to-𝕃char "Moses supposes his toeses are roses.")

test : ℕ → html

test 1 = tagged "html" [] [ tagged "body" []
           ((tagged "p" [] [ text "Go Hawks" ]) ::
            (tagged "p" [] [ text "Big Ten" ] ) :: [])
           ]

test 2 = tagged "html" [] [ tagged "body" []
           ((html-list do-ul-list ( text "some items " :: text "in a nice little " :: text "unordered list" :: [])) ::
            (html-list do-ol-list ( text "and a couple more items " :: text "in an ordered list" :: [])) :: []) ]

test 3 = tagged "html" [] [ tagged "body" ["style","font-size : 2em"] prefixes ]

test 4 = tagged "html" [] [ tagged "body" ["style","font-size : 2em"]
            (zip-html-css-decls prefixes (tuples-to-decls (gradient 0 0 0 6 2 2 255 180 180))) ]

test x = tagged "html" [] [ tagged "body" [] [ text ("There is no test numbered " ^ (ℕ-to-string x)) ] ] 


show-test : html → IO ⊤
show-test x = putStr (html-to-string x)

do-test : 𝔹 → ℕ → IO ⊤
do-test tt n = putStr (html-to-indented (test n))
do-test ff n = putStr (html-to-string (test n))

processArgs : 𝕃 string → IO ⊤
processArgs (i :: n :: []) = do-test (is-indented i) (string-to-ℕ0 n)
  where is-indented : string → 𝔹
        is-indented "indented" = tt
        is-indented _ = ff
processArgs _ = putStr ("Please run with a command-line that looks like this:\n" ^
                        "  hmain I N\n" ^
                        "where I is either \"indented\" or \"not\" (without the quotes), and N is a number.\n")

main : IO ⊤
main = getArgs >>= processArgs 
