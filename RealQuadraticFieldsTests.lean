module

import RealQuadraticFields

/-!
# Public interface checks

Examples for exercise 1, using the public entry point and squarefree
radicands 2, 3, and 5.
-/

open RealQuadraticFields

-- Coordinate equality does not require a squarefree radicand.
example (d : ℕ) (x y : Quad d) :
    x = y ↔ x.re = y.re ∧ x.im = y.im := by
  exact quad_eq_iff_coordinates_eq d x y

-- Constructor evaluation works with both integer and fractional coordinates.
example : (Quad.mk 3 4 : Quad 2).eval = 3 + 4 * Real.sqrt 2 := by
  simpa using eval_eq_explicit_coordinates 2 3 4

example : (Quad.mk (1 / 2) (-3 / 4) : Quad 5).eval =
    (1 : ℝ) / 2 - (3 : ℝ) / 4 * Real.sqrt 5 := by
  norm_num [eval_eq_explicit_coordinates, sub_eq_add_neg]

-- Both conclusions of the irrationality theorem are available to clients.
-- Primality supplies squarefreeness for these radicands.
example : ¬ ∃ q : ℚ, q ^ 2 = (2 : ℚ) := by
  exact (irrationality 2 Nat.prime_two.prime.squarefree (by norm_num)).1

example : Irrational (Real.sqrt (2 : ℝ)) := by
  exact (irrationality 2 Nat.prime_two.prime.squarefree (by norm_num)).2

example : Irrational (Real.sqrt (3 : ℝ)) := by
  exact (irrationality 3 Nat.prime_three.prime.squarefree (by norm_num)).2

example : Irrational (Real.sqrt (5 : ℝ)) := by
  exact (irrationality 5 Nat.prime_five.prime.squarefree (by norm_num)).2

-- Vanishing and equality of real evaluations recover rational coordinates.
example (a b : ℚ) :
    (a : ℝ) + (b : ℝ) * Real.sqrt 2 = 0 ↔ a = 0 ∧ b = 0 := by
  exact uniqueness_zero 2 a b Nat.prime_two.prime.squarefree (by norm_num)

example (a b c e : ℚ) :
    (a : ℝ) + (b : ℝ) * Real.sqrt 3 =
      (c : ℝ) + (e : ℝ) * Real.sqrt 3 ↔ a = c ∧ b = e := by
  exact uniqueness_eq 3 a b c e Nat.prime_three.prime.squarefree (by norm_num)

example : Function.Injective (Quad.eval (d := 5)) := by
  exact uniqueness_injective 5 Nat.prime_five.prime.squarefree (by norm_num)

-- Distinct coefficient pairs give distinct real numbers.
example : (Quad.mk 0 1 : Quad 2).eval ≠ (Quad.mk 1 0 : Quad 2).eval := by
  intro h
  have hcoord := (uniqueness_injective 2 Nat.prime_two.prime.squarefree (by norm_num)) h
  have hre := congrArg Quad.re hcoord
  norm_num at hre
