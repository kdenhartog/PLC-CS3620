open import lib

prob1 : 𝔹
prob1 = ff && ff 

prob2 : ℕ
prob2 = 1 * 1 + 1

prob3 : 𝔹 → ℕ
prob3 x = if x then 1 else 2

prob4 : 𝔹 → ℕ → ℕ
prob4 x y = if x then y * 10 else 2

prob5 : 𝔹 → (y : 𝔹) → 𝔹
prob5 x = λ y → x && y 

prob6 : (ℕ → ℕ) → ℕ → ℕ
prob6 x y = x y + y

prob7 : (𝔹 → ℕ) → 𝔹 → ℕ
prob7 x y = 2 + (x (y || ff))

prob8 : (𝔹 → ℕ) → ℕ → ℕ
prob8 = λ _ z → z

prob9 : ∀ {A B : Set} → (A → A → B) → A → B
prob9 = λ z z₁ → z z₁ z₁

prob10 : ∀ {A : Set} → ((𝔹 → 𝔹) → A) → A
prob10 = λ z → z (λ z₁ → z₁)

prob11 : ∀ {A B C : Set} → A → (A → B) → (A → B → C) → C
prob11 = λ z z₁ z₂ → z₂ z (z₁ z)

prob12 : ∀{A B : Set} (b : 𝔹) → if b then ℕ else 𝔹 → if b then 𝔹 else ℕ
prob12 tt y = tt
prob12 ff y = 1

