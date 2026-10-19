#!/bin/sh
set -eu
for FLUTTER_LAB_TOOL in git curl unzip xz zip python3; do
  command -v "$FLUTTER_LAB_TOOL" >/dev/null || {
    echo "Missing prerequisite: $FLUTTER_LAB_TOOL; ask the environment setup owner to install it." >&2
    exit 2
  }
done
FLUTTER_LAB_SDK_DIR="${FLUTTER_LAB_SDK_DIR:-$HOME/.cache/flutter-ui-proof-lab/flutter-3.44.1}"
if [ ! -x "$FLUTTER_LAB_SDK_DIR/bin/flutter" ]; then
  mkdir -p "$(dirname "$FLUTTER_LAB_SDK_DIR")"
  git clone --depth 1 --branch 3.44.1 https://github.com/flutter/flutter.git "$FLUTTER_LAB_SDK_DIR"
fi
FLUTTER_LAB_ACTUAL_REF="$(git -C "$FLUTTER_LAB_SDK_DIR" rev-parse HEAD)"
if [ "$FLUTTER_LAB_ACTUAL_REF" != '924134a44c189315be2148659913dda1671cbe99' ]; then
  echo 'Flutter SDK revision differs from the lab pin; inspect instead of upgrading/resetting it.' >&2
  exit 2
fi
export FLUTTER_LAB_BIN="$FLUTTER_LAB_SDK_DIR/bin/flutter"
sh scripts/flutter.sh --version
sh scripts/flutter.sh precache --web
sh scripts/flutter.sh pub get --enforce-lockfile
