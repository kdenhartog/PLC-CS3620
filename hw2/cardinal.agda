data direction : Set where
  N : direction
  S : direction
  E : direction
  W : direction
  NE : direction
  NW : direction
  SE : direction
  SW : direction

clockwise_ : direction → direction
clockwise N = NE
clockwise NE = E
clockwise E = SE
clockwise SE = S
clockwise S = SW
clockwise SW = W
clockwise W = NW
clockwise NW = N

counterclockwise_ : direction → direction
counterclockwise N = NW
counterclockwise NW = W
counterclockwise W = SW
counterclockwise SW = S
counterclockwise S = SE
counterclockwise SE = E
counterclockwise E = NE
counterclockwise NE = N

clockwise-inverse_ : ∀(d : direction) → counterclockwise (clockwise d) → d 
clockwise-inverse a = ?
