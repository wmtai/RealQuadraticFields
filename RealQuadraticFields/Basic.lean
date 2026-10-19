module

public import Mathlib

/-!
# Foundations

Starting module for the real quadratic fields library.
-/

public section

namespace RealQuadraticFields

structure Quad (d : ℕ) where
  re : ℚ
  im : ℚ

noncomputable def Quad.eval {d : ℕ} (x : Quad d) : ℝ :=
  (x.re : ℝ) + (x.im : ℝ) * Real.sqrt d

theorem quad_eq_iff_coordinates_eq (d : ℕ) (q1 q2 : Quad d) :
  q1 = q2 ↔ q1.re = q2.re ∧ q1.im = q2.im := by
  rcases q1 with ⟨a,b⟩
  rcases q2 with ⟨c,d⟩
  constructor
  <;> intro h
  <;> norm_num at *
  <;> exact h

theorem eval_eq_explicit_coordinates (d : ℕ) (a b : ℚ) :
    (Quad.mk a b : Quad d).eval =
      (a : ℝ) + (b : ℝ) * Real.sqrt (d : ℝ) := by
  rfl

theorem irrationality (d : ℕ) (hd1 : Squarefree d) (hd2 : 1 < d) :
  (¬ ∃ q : ℚ, q ^ 2 = (d : ℚ)) ∧ Irrational (Real.sqrt (d : ℝ)) := by
  have h : ¬ ∃ q : ℚ, q ^ 2 = (d : ℚ) := by
    by_contra hc
    choose q hq using hc
    have ab : ∃ (a:ℤ)(b:ℕ), b ≠ 0 ∧ a.gcd b = 1 ∧ q = a/b := by
      use q.num, q.den
      constructor
      · exact q.den_nz
      · constructor
        · exact q.reduced
        · symm; exact q.num_div_den
    choose a b h1 h2 h3 using ab
    obtain ⟨p,hp1,hp2⟩:= Nat.exists_prime_and_dvd (show d ≠ 1 by nlinarith [hd2])
    choose x hx using hp2
    rw [h3,div_pow, hx] at hq
    push_cast at hq
    have temp : (b:ℚ)^2 ≠ 0 := by
      have temp : b^2 ≠ 0 := by simp [h1]
      exact_mod_cast temp
    have h4 : (a:ℚ)^2 = p * x * b^2 := by rw [← hq, div_mul_cancel₀ ((a:ℚ)^2) temp]
    have h5 : a^2 = p * x * b^2 := by exact_mod_cast h4
    have h7 : (p:ℤ) ∣ a := by
      have temp : (p:ℤ) ∣ a^2 := by
        use (x*b^2); rw [h5, mul_assoc]
      have temp1 : Prime (p:ℤ) := by exact Nat.prime_iff_prime_int.mp hp1
      exact Prime.dvd_of_dvd_pow temp1 temp
    have hy : ∃ y, a = (p:ℤ)*y := by choose y hy using h7; use y
    choose y hy using hy
    rw [hy, mul_pow] at h5
    have h8 : p * y^2 = x * b^2 := by
      have  temp : (p:ℤ) ≠ 0 := by
        exact_mod_cast hp1.ne_zero
      apply mul_left_cancel₀ temp
      rw [← mul_assoc, ← mul_assoc, ← h5]
      ring
    have h9 : (p:ℤ) ∣ b := by
      have temp : (p:ℤ) ∣ (x * b^2) := by use (y^2); symm; exact h8
      have temp : p ∣ (x * b^2) := by exact_mod_cast temp
      rw [hp1.dvd_mul] at temp
      rcases temp with t|t
      · choose z hz using t
        rw [hz] at hx
        rw [hx] at hd1
        specialize hd1 p
        rw [← mul_assoc] at hd1
        norm_num at hd1
        rw [hd1] at hp1
        norm_num at hp1
      · have temp := Nat.Prime.dvd_of_dvd_pow hp1 t
        exact_mod_cast temp
    have h10 : p ∣ a.gcd b := Int.dvd_gcd h7 h9
    rw [h2] at h10
    norm_num at h10
    rw [h10] at hp1
    norm_num at hp1
  constructor
  · exact h
  · by_contra hc
    unfold Irrational at hc
    push Not at *
    norm_num at hc
    choose y hy using hc
    specialize h y
    revert h
    norm_num
    have temp : (y:ℝ)^2 = d := by rw [hy]; rw [Real.sq_sqrt (show 0 ≤ (d:ℝ) by linarith [hd2])]
    exact_mod_cast temp

theorem uniqueness_zero (d : ℕ) (a b : ℚ) (hd : Squarefree d) (hd1 : 1 < d) :
  a + b * Real.sqrt d = 0 ↔ a = 0 ∧ b = 0 := by
  have h1 := (irrationality d hd hd1 ).2
  constructor
  <;> intro h
  · by_cases hb : b = 0
    · constructor
      · rw [hb] at h
        norm_num at h
        exact h
      · exact hb
    · have h2: ∃ q : ℚ, Real.sqrt d = q := by
        use (-a/b)
        rw [(show (0:ℝ) = a - a by ring)] at h
        apply add_left_cancel at h
        push Not at hb
        push_cast
        field_simp [hb,h]
        rw [← h]
        ring
      unfold Irrational at h1
      norm_num at h1
      choose q hq using h2
      specialize h1 q
      rw [hq] at h1
      norm_num at h1
  · rcases h with ⟨h2,h3⟩
    rw [h2,h3]
    ring

theorem uniqueness_eq (d : ℕ) (a b c e : ℚ) (hd : Squarefree d) (hd1 : 1 < d) :
  a + b * Real.sqrt d = c + e * Real.sqrt d ↔
    a = c ∧ b = e := by
  constructor
  <;> intro h
  · have temp : (a-c) + (b-e) * Real.sqrt d = 0 := by linarith
    have temp1 := uniqueness_zero d (a-c) (b-e) hd hd1
    push_cast at temp1
    rw [temp1] at temp
    obtain ⟨ h1,h2⟩ := temp
    constructor
    <;> linarith
  · obtain ⟨h1,h2⟩ := h
    have temp : a-c = 0∧ b-e = 0:= by
      constructor
      <;> linarith
    rw [← uniqueness_zero d (a-c) (b-e) hd hd1] at temp
    push_cast at temp
    linarith

theorem uniqueness_injective (d : ℕ) (hd : Squarefree d) (hd1 : 1 < d) :
  Function.Injective (Quad.eval (d := d)) := by
  unfold Function.Injective
  intro a b h
  rw [eval_eq_explicit_coordinates, eval_eq_explicit_coordinates] at h
  rw [uniqueness_eq d a.re a.im b.re b.im hd hd1, ← quad_eq_iff_coordinates_eq] at h
  exact h

end RealQuadraticFields
