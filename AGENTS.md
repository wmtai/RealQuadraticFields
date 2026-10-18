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

- Stage: setup complete and build verified; exercise 1 has not been assigned.
- Verification passed: `lake build --wfail RealQuadraticFields RealQuadraticFieldsTests`.
- Next conversational action: wait for the user's `ok`, then
  present exercise 1 only.
