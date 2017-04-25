open import lib
open import sorted-list ℕ _≤_ (λ{x y z} → ≤-trans{x}{y}{z}) (λ{x y} → ≤-total{x}{y})

-- list containing data 4, 8 (other numbers are lower and upper bounds)
test-sorted-list : sorted-list 3 10
test-sorted-list = cons 3 10 4 refl refl refl (cons 5 9 8 refl refl refl (nil 9 9 (≤-refl 9)))
