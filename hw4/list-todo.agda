open import lib

take : {A : Set} → ℕ → 𝕃 A → 𝕃 A
take {_} zero [] = []
take {_} (suc _) [] = []
take 0 (x :: A) = []
take (suc n) (x :: A) = x :: (take n A)

take-test : take 3 ('a' :: 'b' :: 'c' :: 'd' :: 'e' :: 'f' :: []) ≡ 'a' :: 'b' :: 'c' :: [] 
take-test = refl

drop : {A : Set} → ℕ → 𝕃 A → 𝕃 A
drop {_} zero [] = []
drop {_} n [] = []
drop 0 A = A
drop (suc n) (x :: A) = nthTail (suc n) (x :: A)

drop-test : drop 3 ('a' :: 'b' :: 'c' :: 'd' :: 'e' :: 'f' :: []) ≡ 'd' :: 'e' :: 'f' :: []
drop-test = refl

splitAt : {A : Set} → ℕ → 𝕃 A → 𝕃 A × 𝕃 A
splitAt zero [] = [] , []
splitAt zero (x :: l) = [] , (x :: l)
splitAt (suc n) [] = [] , []
splitAt (suc n) (x :: l) with splitAt n l
... | l1 , l2 = x :: l1 , l2

splitAt-test : splitAt 3 ('a' :: 'b' :: 'c' :: 'd' :: 'e' :: 'f' :: []) ≡ ('a' :: 'b' :: 'c' :: [] , 'd' :: 'e' :: 'f' :: [])
splitAt-test = refl

splitAt-thm : {A : Set}(n : ℕ)(l : 𝕃 A) → splitAt n l ≡ take n l , drop n l
splitAt-thm n l rewrite take n l (x :: l) = {!x :: l1, l2!}

filter-pos : {A : Set} → 𝕃 A → (ℕ → 𝔹) → 𝕃 A 
filter-pos l p = {!!}

filter-pos-test : filter-pos ('a' :: 'b' :: 'c' :: 'd' :: 'e' :: 'f' :: []) is-even ≡ 'a' :: 'c' :: 'e' :: []
filter-pos-test = refl

grid : ℕ → ℕ → 𝕃 (ℕ × ℕ)
grid x y = {!!}

eqPair : ℕ × ℕ → ℕ × ℕ → 𝔹
eqPair (x , y) (x' , y') = x =ℕ x' && y =ℕ y'

a-grid : 𝕃 (ℕ × ℕ)
a-grid = grid 2 3

test-grid : list-member eqPair (2 , 3) a-grid &&
            list-member eqPair (1 , 3) a-grid &&
            list-member eqPair (0 , 3) a-grid &&
            list-member eqPair (2 , 2) a-grid &&
            list-member eqPair (1 , 2) a-grid &&
            list-member eqPair (0 , 2) a-grid &&
            list-member eqPair (2 , 1) a-grid &&
            list-member eqPair (1 , 1) a-grid &&
            list-member eqPair (0 , 1) a-grid &&
            list-member eqPair (2 , 0) a-grid &&
            list-member eqPair (1 , 0) a-grid &&
            list-member eqPair (0 , 0) a-grid ≡ tt
test-grid = refl
