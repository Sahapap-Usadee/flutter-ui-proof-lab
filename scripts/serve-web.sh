#!/bin/sh
set -eu
sh scripts/flutter.sh build web --release --no-web-resources-cdn
exec python3 -m http.server 8080 --bind 0.0.0.0 --directory build/web
