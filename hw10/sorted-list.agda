open import lib hiding (min ; max)
open import bool-relations using (transitive ; total )

module sorted-list(A : Set)(aval : A)(_≤A_ : A → A → 𝔹)
                  (≤A-trans : transitive _≤A_)
                  (≤A-total : total _≤A_) where

open import bool-relations _≤A_ hiding (transitive ; total)
open import minmax _≤A_ ≤A-trans ≤A-total

data sorted-list : (l u : A) → Set where
  nil : (l u : A) → l ≤A u ≡ tt → sorted-list l u
  cons : {l' u' : A}(l u : A)(h : A) → (o : l ≤A h ≡ tt) → (o : h ≤A l' ≡ tt) → (o : u' ≤A u ≡ tt) →
         sorted-list l' u' → sorted-list l u

sorted-list-to-𝕃 : {l u : A} → sorted-list l u → 𝕃 A
sorted-list-to-𝕃 = λ _ → []

{- Commented out to remove incomplete holes
relax-lb : (l' : A){l u : A} → l' ≤A l ≡ tt → sorted-list l u → sorted-list l' u
relax-lb = {!!}

relax-ub : (u' : A){l u : A} → u ≤A u' ≡ tt → sorted-list l u → sorted-list l u'
relax-ub = {!!} 

{- create function for appending sorted lists -}

{- create function for inserting data into a sorted list while preserving sorted order -}

insertion-sort : 𝕃 A → Σ A (λ l → Σ A (λ u → sorted-list l u))
insertion-sort = {!!}
-}
