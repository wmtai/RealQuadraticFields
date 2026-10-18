# RealQuadraticFields

A Lean 4 library of real quadratic fields, built by completing ten cumulative
exercises. The project follows the module and public-interface style of
the neighboring `HighSchoolMath` project.

## Toolchain

- Lean: `leanprover/lean4:v4.35.0-rc4`
- mathlib: `v4.35.0-rc4`, with resolved revisions in `lake-manifest.json`

## Build

From this directory:

```bash
lake build
```

To check both the library and its public-interface examples with warnings
treated as failures:

```bash
lake build --wfail RealQuadraticFields RealQuadraticFieldsTests
```

For a fresh checkout with Lean's `elan` toolchain manager installed, prepare
the dependencies first:

```bash
lake exe cache get
lake build
```

This workspace reuses the neighboring project's installed dependency packages
through an ignored `.lake/packages` symlink. The tracked dependency configuration
and lockfile use the standard upstream mathlib dependency.

## Layout

- `RealQuadraticFields.lean`: public entry point, reexporting library modules.
- `RealQuadraticFields/Basic.lean`: initial working module.
- `RealQuadraticFieldsTests.lean`: examples using only the public entry point.
- `AGENTS.md`: tutoring workflow and current checkpoint for future sessions.

## Learning workflow

1. Finish project setup, then wait for your `ok` before presenting exercise 1.
2. Present one exercise with minimal hints; you implement it.
3. When you type `ok`, inspect your implementation, run the relevant Lean
   checks, and give feedback.
4. Wait for another `ok` before presenting the next exercise.

Definitions and proofs are left for you to implement. Feedback should focus
on correctness, hypotheses, reusable interfaces, and proof clarity.

## Roadmap

1. Rational coordinates and irrationality
2. Arithmetic and the algebra structure
3. Conjugation, trace, and norm
4. Inverses and field structure
5. Degree, bases, and minimal polynomials
6. Real embeddings, order, and classification
7. Algebraic integers, integral bases, and discriminants
8. Units, fundamental units, and Pell equations
9. Ideals and splitting of rational primes
10. Class groups and concrete arithmetic
