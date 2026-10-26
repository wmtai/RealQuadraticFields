module

public import RealQuadraticFields.Basic

/-!
# Arithmetic and the rational algebra structure

Working module for exercise 2.
-/

public section

namespace RealQuadraticFields

instance {d : ℕ} : Zero (Quad d) where
  zero := ⟨0, 0⟩

instance {d : ℕ} : Add (Quad d) where
  add x y := ⟨x.re + y.re, x.im + y.im⟩

instance {d : ℕ} : One (Quad d) where
  one := ⟨1, 0⟩

instance {d : ℕ} : Neg (Quad d) where
  neg x := ⟨-x.re, -x.im⟩

instance {d : ℕ} : Mul (Quad d) where
  mul x y := ⟨x.re*y.re + x.im*y.im*d, x.re*y.im + x.im*y.re⟩

instance {d : ℕ} : SMul ℚ (Quad d) where
  smul r x := ⟨r*x.re, r*x.im⟩

def Quad.ofRat {d : ℕ} (r : ℚ) : Quad d :=
  ⟨r, 0⟩

end RealQuadraticFields
