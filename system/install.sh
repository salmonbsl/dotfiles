#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"

case "${1:-}" in
  keyd)
    sudo install -Dm644 \
      "$SCRIPT_DIR/etc/keyd/default.conf" \
      /etc/keyd/default.conf

    if command -v keyd >/dev/null 2>&1;
    then
      sudo keyd reload
    fi
    ;;

  *)
    echo "Usage: $0 keyd"
    exit 1
    ;;
esac
