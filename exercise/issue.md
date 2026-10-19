## Problem
Saved filter stays selected but still shows unsaved places.
Synthetic Flutter UI lab; no production service or credentials.

## Reproduce on the baseline
1. Start the web app and reload for the seeded state.
2. All shows Park, Museum, Cafe; only Museum is saved.
3. Select Saved. Observe that Park and Cafe remain visible (bug).
4. Unsave Museum while Saved is selected. Observe that the empty state is missing (bug).

## Acceptance
- U1: All shows all three places.
- U2: Saved initially shows only Museum and count 1.
- U3: Unsave Museum while in Saved: no rows, count 0, "No saved places".
- U4: Return to All, save Park, switch to Saved: only Park. Switching filters preserves in-memory selection.
- U5: At 360x800 and 412x915 CSS-pixel browser viewports, controls work and there is no overflow or clipped essential control.

## Scope
Flutter widget/UI state only. No persistence across reload, backend, authentication, native plugins, deployment, signing or production access.
Seeded state resets on full reload. Native Android/iOS runtime remains unverified unless a separate device run is explicitly authorized and performed.

## Required evidence
- Baseline and fixed UI: same tap sequence, actual screenshots plus one short video showing actions and resulting state.
- Widget regression: copy exercise/saved_filter_regression.dart to test/saved_filter_regression_test.dart; run red on baseline, green after fix. Keep acceptance assertions intact.
- Analyze, full tests and release web build results; browser console/runtime exceptions if available.
- Evidence index links each U1-U5 to actual command/action, result, artifacts and tested revision/build/viewport. No fake screenshots or copied reference results.
- Fresh verifier uses the proposed revision, runs the UI independently, posts a verdict with evidence links on the same PR (or reports posting unavailable and returns the exact verdict for manual posting).

## Route and finish
Chief -> Engineering Lead -> Cursor Project coordinator -> one coding Cloud worker.
Create/use Project for this repo after explicit repo and quota authorization. Reuse existing runs/PRs; no duplicate dispatch.
Finish: one draft PR with evidence and independent verification for human review. No merge, deployment, billing change, routine or external notification.
