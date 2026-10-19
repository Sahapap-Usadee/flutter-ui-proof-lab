# Flutter UI proof lab — Saved Places

Author-created teaching example, not Lauren Tan's app or source. Baseline deliberately contains a Saved filter bug. Flutter **3.44.1**, framework revision `924134a44c189315be2148659913dda1671cbe99`, Dart **3.12.1**.

## Start in Cursor Cloud

1. Connect only the dedicated training repository; use its own environment and Project. Do not reuse CSV/Python commands as Flutter configuration.
2. Environment prerequisites: Linux Flutter prerequisites from https://docs.flutter.dev/install/manual , Python 3, Chrome/Chromium for browser evidence, and a working desktop/browser controller. Ask setup owner to install missing system packages. No assumption that Android emulator, KVM or macOS is present.
3. Install command: `sh .cursor/install-lab.sh`. It installs a pinned Flutter SDK in a dedicated user-cache directory and checks its exact revision. The script needs network access to Flutter/GitHub/pub archives; it does not request sudo or silently upgrade an existing SDK. Missing shared-library/network permissions are setup blockers.
4. In a task terminal run `sh scripts/serve-web.sh`, then open port 8080 in the actual Cloud browser/Forwarded Ports. Keep the server task alive while driving the UI. Do not put a never-ending web server in the environment install command.
5. App opts into Flutter web semantics for UI control. Inspect actual browser roles/labels and click **All**, **Saved**, **Save Park**, **Unsave Museum**. Dart ValueKeys are for Flutter tests, not promised CSS selectors.
6. The verifier skill `verify-saved-places` is kept in the Cursor Project **Flutter UI Proof Lab** Agent Store (path `docs/verifier-skill/`), not in this git repository. After app launch works, agents run helpers from that store path in the lab checkout (do not commit `.cursor/skills/`), drive the mapped features, and reproduce the known Saved-filter failure without fixing the product as part of verifier setup. `/maintain-verification-skill` updates the store copy.

`flutter` might not be on PATH in a new Cloud session. All lab commands use `sh scripts/flutter.sh` to locate the pinned SDK; shell PATH from an install run is not persistent configuration.

## Checks

```bash
sh scripts/flutter.sh analyze
sh scripts/flutter.sh test
sh scripts/flutter.sh build web --release --no-web-resources-cdn
```

The baseline smoke test passes; it deliberately does not cover the Saved bug. For a failing regression:

```bash
cp exercise/saved_filter_regression.dart test/saved_filter_regression_test.dart
sh scripts/flutter.sh test test/saved_filter_regression_test.dart
```

Keep the regression in the fix PR. Full requirements/repro/proof/finish: `exercise/issue.md`.

## Local use

Use the same install command (requires shell tools on PATH), or point `FLUTTER_LAB_BIN` to your already installed Flutter 3.44.1 binary:

```bash
export FLUTTER_LAB_BIN=/absolute/path/to/flutter-3.44.1/bin/flutter
sh scripts/flutter.sh pub get --enforce-lockfile
sh scripts/serve-web.sh
```

Replace the path with the actual installed SDK. Do not commit user SDK paths, Android local.properties, generated iOS config, signing identity, .dart_tool or build outputs.

## What proof does and does not cover

Cloud/browser runs prove **Flutter web**, even with a phone-sized viewport. They do not prove native Android/iOS, platform channels, OS permissions, lifecycle, TalkBack or VoiceOver. Generated Android/iOS scaffolds are starting points for a separately authorized native follow-up.

Widget tests do not produce a video. Browser-driven before/after screenshots and a short recording are separate deliverables. Verify native recording/artifact facilities in the run before claiming a video exists. If unavailable, report that gap and provide real screenshots/actions/outputs, without declaring the requested media complete.

No GitHub Actions workflow is included. Report CI as **not configured/not run** until a real workflow is created and run on the proposed revision; do not label local checks as CI green. The initial repository contains the bug and a red regression exercise, so environment install must not run the failing regression.
