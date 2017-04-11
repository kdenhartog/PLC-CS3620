open import lib hiding (leaf ; node)

data bintree (A : Set) : Set where
  leaf : bintree A
  node : A → bintree A → bintree A → bintree A

size : {A : Set} → bintree A → ℕ
size = {!!}

test-size : size (node 3 leaf (node 4 leaf leaf)) ≡ 5
test-size = refl

pre-order : {A : Set} → bintree A → 𝕃 A
pre-order = {!!} 

in-order : {A : Set} → bintree A → 𝕃 A
in-order = {!!}

test-in-order : in-order (node 3 (node 1 leaf leaf) (node 6 (node 5 leaf leaf) leaf)) ≡ 1 :: 3 :: 5 :: 6 :: []
test-in-order = refl

test-pre-order : pre-order (node 3 (node 1 leaf leaf) (node 6 (node 5 leaf leaf) leaf)) ≡ 3 :: 1 :: 6 :: 5 :: []
test-pre-order = refl

list-member-map : {A B : Set}(eqA : A → A → 𝔹)(eqB : B → B → 𝔹)(f : A → B)(l : 𝕃 A)(a : A) →
                  (∀(a1 a2 : A) → eqA a1 a2 ≡ eqB (f a1) (f a2)) → list-member eqA a l ≡ tt →
                  list-member eqB (f a) (map f l) ≡ tt
list-member-map eqA eqB f [] a u ()
list-member-map eqA eqB f (x :: l) a u p with keep (eqA a x)
... | tt , q = {!u a x p !}
... | ff , q rewrite q | list-member-map eqA eqB f l a u p | ||-tt (eqB (f a) (f x)) = refl

pre-in-thm : {A : Set}(b : bintree A)(eq : A → A → 𝔹)(x : A) → list-member eq x (pre-order b) ≡ tt → list-member eq x (in-order b) ≡ tt
pre-in-thm t eq a p = {!!}
