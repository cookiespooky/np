#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BIN="${NOTEPUB_BIN:-notepub}"
EN_CFG="./config.yaml"
EN_RULES="./rules.yaml"
RU_CFG="./config.ru.yaml"
RU_RULES="./rules.ru.yaml"

EN_ART="./.notepub/artifacts"
RU_ART="./.notepub-ru/artifacts"
EN_DIST="./.dist-en"
RU_DIST="./.dist-ru"
OUT_DIST="./dist"

BASE_URL="$(awk -F'"' '/base_url:/ {print $2; exit}' "$EN_CFG")"
BASE_URL="${BASE_URL%/}"

if ! command -v "$BIN" >/dev/null 2>&1; then
  echo "notepub binary not found: $BIN"
  echo "Set NOTEPUB_BIN, for example:"
  echo "  NOTEPUB_BIN=/path/to/notepub $0"
  exit 1
fi

echo "[1/6] EN index/build"
"$BIN" index --config "$EN_CFG" --rules "$EN_RULES"
"$BIN" build --config "$EN_CFG" --rules "$EN_RULES" --artifacts "$EN_ART" --dist "$EN_DIST"

echo "[2/6] RU index/build"
"$BIN" index --config "$RU_CFG" --rules "$RU_RULES"
"$BIN" build --config "$RU_CFG" --rules "$RU_RULES" --artifacts "$RU_ART" --dist "$RU_DIST"

echo "[3/6] prepare output"
find "$OUT_DIST" -mindepth 1 -delete 2>/dev/null || true
mkdir -p "$OUT_DIST"

echo "[4/6] merge EN + RU"
cp -R "$EN_DIST"/. "$OUT_DIST"/
mkdir -p "$OUT_DIST/ru"
cp -R "$RU_DIST/ru"/. "$OUT_DIST/ru"/
if [[ -f "$RU_DIST/search.json" ]]; then
  cp "$RU_DIST/search.json" "$OUT_DIST/ru/search.json"
fi

echo "[5/6] generate combined sitemap.xml"
find "$OUT_DIST" -maxdepth 1 -type f \( -name 'sitemap-index.xml' -o -name 'sitemap-*.xml' \) -delete 2>/dev/null || true
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  jq -r '.routes | to_entries[] | select(.value.status == 200) | .key' "$EN_ART/resolve.json" "$RU_ART/resolve.json" \
    | sort -u \
    | while IFS= read -r p; do
        [[ -z "$p" ]] && continue
        echo "  <url><loc>${BASE_URL}${p}</loc></url>"
      done
  echo '</urlset>'
} > "$OUT_DIST/sitemap.xml"

echo "[6/6] done -> $OUT_DIST"
