open import lib

fact : ℕ → ℕ → ℕ
{- fact zero zero = 1
fact zero (suc y) = 1 
fact (suc x) zero = (suc x) * (fact x 0)
fact (suc x) (suc y) = if x < y then 1 else (suc x) * (fact (x suc y) + 1) -}
fact 0 y = 1 
fact (suc x) y = if (suc x) ≥ (y + 1) then (suc x) * (fact x y) else 1

test-fact : fact 6 3 ≡ 6 * 5 * 4 
test-fact = refl

fact0-factorial : ∀ (n : ℕ) → fact n 0 ≡ factorial n
fact0-factorial zero = refl
fact0-factorial (suc n) rewrite fact0-factorial n | 0-≤ n = refl 



