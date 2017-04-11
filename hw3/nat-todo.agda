open import lib

prob1 : ∀ (x : ℕ) → x ≤ 0 ≡ tt → x ≡ 0
prob1 zero = λ _ → refl
prob1 (suc b) = λ ()

prob2a : ∀(x y z : ℕ) → x ≤ y ≡ tt → z + x ≤ z + y ≡ tt
prob2a x y zero p  = p
prob2a x y (suc z) p = prob2a x y z p

prob2 : ∀(x y z : ℕ) → x ≤ y ≡ tt → x + z ≤ y + z ≡ tt
prob2 x y z p rewrite +comm x z | +comm y z = prob2a x y z p

