open import lib

attribute-list : Set
attribute-list = 𝕃 (string × string)

data html : Set where
  tagged : (name : string) → (attrs : attribute-list) →
            (subelts : 𝕃 html) → html
  text : (the-text : string) → html

attributes-to-string : attribute-list → string
attributes-to-string [] = ""
attributes-to-string ((attr , val) :: l) =
  " " ^ attr ^ " = \"" ^ val ^ "\"" ^ attributes-to-string l

html-to-string : html → string
html-list-to-string : 𝕃 html → 𝕃 string
html-to-string (tagged name attrs subelts) =
  "<" ^ name ^ (attributes-to-string attrs) ^ ">" ^ -- start tag
  (string-concat-sep "" (html-list-to-string subelts)) ^
  "</" ^ name ^ ">" -- end tag
html-to-string (text the-text) = the-text
html-list-to-string (l :: ls) = html-to-string l :: html-list-to-string ls
html-list-to-string [] = []



html-to-indented-helper : html → string → string
html-list-to-indented : 𝕃 html → string → 𝕃 string
html-to-indented-helper (tagged name attrs subelts) indent =
  indent ^ "<" ^ name ^ (attributes-to-string attrs) ^ ">\n" ^ -- start tag
  (string-concat-sep "\n" (html-list-to-indented subelts indent)) ^
  "\n" ^ indent ^ "</" ^ name ^ ">" -- end tag
html-to-indented-helper (text the-text) indent = indent ^ the-text
html-list-to-indented (x :: xs) indent =
  (html-to-indented-helper x (indent ^ " ")) :: html-list-to-indented xs indent
html-list-to-indented [] indent = []

html-to-indented : html → string
html-to-indented h = html-to-indented-helper h ""
-- the boolean is for whether this should be a ul list (tt) or an ol list (ff)
do-ul-list : 𝔹
do-ul-list = tt

do-ol-list : 𝔹
do-ol-list = ff

helper-li : html → html
helper-li (tagged name attrs subelts) = tagged "li" attrs subelts
helper-li (text the-text) = tagged "li" [] ((text the-text) :: [])

html-list : 𝔹 → 𝕃 html → html
html-list tt ((tagged name attrs subelts) :: ls) = tagged name attrs subelts
html-list tt ((text t) :: ls) = tagged "ul" [] (map helper-li ((text t) :: ls))
html-list tt [] = (tagged "" [] [])
html-list ff ((tagged name attrs subelts) :: ls) = tagged name attrs subelts
html-list ff ((text t) :: ls) = tagged "ol" [] (map helper-li ((text t) :: ls))
html-list ff [] = (tagged "" [] [])

num-subelts : html → ℕ
num-subelts (tagged name attrs subelts) = length subelts
num-subelts (text the-text) = 0


list-helper : ∀{ A : Set} → 𝕃 A → 𝕃 A
list-helper [] = []
list-helper (x :: xs) = let r = list-helper xs in x :: r


list-prefixes : ∀{A : Set} → 𝕃 A → 𝕃 (𝕃 A)
list-prefixes [] = []
list-prefixes (x :: l) = [ x ] :: (map list-helper (list-prefixes l))

list1 : 𝕃 string
list1 = "a" :: "b" :: "c" :: []

p-prefixes : 𝕃 char → 𝕃 html
p-prefixes s = [] -- fill in

-- nested selectors are not supported
css-decl : Set
css-decl = string × string

{-# NON_TERMINATING #-}
-- this could fail to terminate, so we are marking it non terminating
gradient : (starting-red : ℕ) → (starting-blue : ℕ) → (starting-green : ℕ) →
           (increment-red : ℕ) → (increment-blue : ℕ) → (increment-green : ℕ) →
           (ending-red : ℕ) → (ending-blue : ℕ) → (ending-green : ℕ) →
           𝕃 (ℕ × ℕ × ℕ)
gradient sr sb sg ir ib ig er eb eg = [] -- fill in

tuples-to-decls : 𝕃 (ℕ × ℕ × ℕ) → 𝕃 css-decl
tuples-to-decls ls = [] -- fill in

zip-html-css-decls : 𝕃 html → 𝕃 css-decl → 𝕃 html
zip-html-css-decls hs ds = [] -- fill in
