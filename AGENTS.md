# Tutoring instructions

This is a learner-owned Lean library. Use the neighboring `HighSchoolMath`
project as a reference for module organization and public interfaces.

## User's workflow

- Give exercises one at a time, with minimal hints.
- After setup, wait for the user's `ok` before giving exercise 1.
- The user implements each exercise. Their subsequent `ok` requests review:
  inspect their work, run appropriate Lean checks, and give feedback.
- After feedback, wait for another `ok` before giving the next exercise.
- If the user submits revisions or asks a question, respond in the current
  exercise's context. Do not automatically advance.
- Leave definitions and proofs to the user unless they explicitly request
  implementation help. Do not prefill solutions or future exercises.
- Update the checkpoint below as exercises are assigned and reviewed.

## Project conventions

- Keep the Lean and mathlib versions aligned with `lean-toolchain` and
  `lakefile.toml`.
- Use namespace `RealQuadraticFields` and the module/public-section conventions
  already present in `RealQuadraticFields/Basic.lean`.
- Reexport completed modules from `RealQuadraticFields.lean`.
- Put client examples in `RealQuadraticFieldsTests.lean`, importing the public
  entry point.
- Standard verification: `lake build --wfail RealQuadraticFields RealQuadraticFieldsTests`.
- The existing `.lake/packages` symlink shares installed dependencies with
  `HighSchoolMath`. Avoid modifying the shared dependency sources.

## Current checkpoint

- Stage: exercise 1 implemented and reviewed; public-interface examples added
  at the user's request. Awaiting permission to present exercise 2.
- Last verification: exercise 1 and its examples passed
  `lake build --wfail RealQuadraticFields RealQuadraticFieldsTests`.
- Review: all assigned results are present, with no unfinished proofs or added
  axioms. Client examples cover coordinate equality, constructor evaluation
  (including fractional coordinates), irrationality, coefficient uniqueness,
  and injectivity for radicands 2, 3, and 5.
- Next `ok`: present exercise 2 only.

## Assigned exercise 1: Rational coordinates and irrationality

- Work in `RealQuadraticFields/Basic.lean` within namespace `RealQuadraticFields`.
- Define `Quad (d : ℕ)` with rational fields `re` and `im`. Define its real
  evaluation as `re + im * Real.sqrt d`, with explicit rational-to-real casts.
- Keep the coordinate type and its evaluation available for every natural `d`;
  put `Squarefree d` and `1 < d` hypotheses on the theorems that need them.
- Prove coordinate extensionality and an evaluation formula for a constructor.
- For squarefree `d > 1`, prove no rational square equals `d`, and prove
  `Irrational (Real.sqrt (d : ℝ))`.
- Prove `a + b * sqrt d = 0` iff both rational coefficients vanish, uniqueness
  of rational coordinates, and injectivity of `Quad.eval` under those hypotheses.
- Add public-import examples for `d = 2, 3, 5` using the new lemmas.
- Arithmetic operations, ring instances, and field instances belong to later
  exercises; leave their implementation for those assignments.
