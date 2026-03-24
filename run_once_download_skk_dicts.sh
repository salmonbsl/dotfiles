#!/bin/sh
set -eu

DICT_DIR="$HOME/.local/share/skk"
BASE_URL="https://skk-dev.github.io/dict"

mkdir -p "$DICT_DIR"

download_and_extract () {
  name="$1"
  file="$DICT_DIR/$name"

  if [ -s "$file" ]; then
    echo "skip: $name"
    return
  fi

  echo "download: $name"

  tmp="${file}.tmp"

  curl -L "$BASE_URL/${name}.gz" \
    | gzip -d > "$tmp"

  mv "$tmp" "$file"
}

download_and_extract SKK-JISYO.L
download_and_extract SKK-JISYO.geo
download_and_extract SKK-JISYO.jinmei
download_and_extract SKK-JISYO.okinawa
download_and_extract SKK-JISYO.propernoun
download_and_extract SKK-JISYO.station
download_and_extract SKK-JISYO.law
