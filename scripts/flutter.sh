#!/bin/sh
set -eu
if [ -n "${FLUTTER_LAB_BIN:-}" ]; then
  exec "$FLUTTER_LAB_BIN" "$@"
fi
FLUTTER_LAB_SDK_DIR="${FLUTTER_LAB_SDK_DIR:-$HOME/.cache/flutter-ui-proof-lab/flutter-3.44.1}"
if [ ! -x "$FLUTTER_LAB_SDK_DIR/bin/flutter" ]; then
  echo 'Flutter lab SDK missing. Run sh .cursor/install-lab.sh first.' >&2
  exit 2
fi
exec "$FLUTTER_LAB_SDK_DIR/bin/flutter" "$@"
