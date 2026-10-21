#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BIN="${NOTEPUB_BIN:-notepub}"
EN_CFG="${NOTEPUB_CONFIG_EN:-./config.yaml}"
EN_RULES="${NOTEPUB_RULES_EN:-./rules.yaml}"
RU_CFG="${NOTEPUB_CONFIG_RU:-./config.ru.yaml}"
RU_RULES="${NOTEPUB_RULES_RU:-./rules.ru.yaml}"

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

echo "[1/7] EN index/build"
"$BIN" index --config "$EN_CFG" --rules "$EN_RULES"
"$BIN" validate --config "$EN_CFG" --rules "$EN_RULES" --resolve "$EN_ART/resolve.json" --seo
"$BIN" build --config "$EN_CFG" --rules "$EN_RULES" --artifacts "$EN_ART" --dist "$EN_DIST"

echo "[2/7] RU index/build"
"$BIN" index --config "$RU_CFG" --rules "$RU_RULES"
"$BIN" validate --config "$RU_CFG" --rules "$RU_RULES" --resolve "$RU_ART/resolve.json" --seo
"$BIN" build --config "$RU_CFG" --rules "$RU_RULES" --artifacts "$RU_ART" --dist "$RU_DIST"

echo "[3/7] prepare output"
find "$OUT_DIST" -mindepth 1 -delete 2>/dev/null || true
mkdir -p "$OUT_DIST"

echo "[4/7] merge EN + RU"
cp -R "$EN_DIST"/. "$OUT_DIST"/
mkdir -p "$OUT_DIST/ru"
cp -R "$RU_DIST/ru"/. "$OUT_DIST/ru"/
if [[ -f "$RU_DIST/search.json" ]]; then
  cp "$RU_DIST/search.json" "$OUT_DIST/ru/search.json"
fi
if [[ -f "$OUT_DIST/assets/llms.txt" ]]; then
  cp "$OUT_DIST/assets/llms.txt" "$OUT_DIST/llms.txt"
fi
if [[ -f "$OUT_DIST/assets/llms-full.txt" ]]; then
  cp "$OUT_DIST/assets/llms-full.txt" "$OUT_DIST/llms-full.txt"
fi

# Export media files for local static preview (same intent as CI workflow).
rm -rf "$OUT_DIST/media"
mkdir -p "$OUT_DIST/media"
rsync -a --prune-empty-dirs \
  --exclude '.git/' \
  --exclude '.github/' \
  --exclude '.obsidian/' \
  --exclude '*.md' \
  ./content/en/ "$OUT_DIST/media/"
rsync -a --prune-empty-dirs \
  --exclude '.git/' \
  --exclude '.github/' \
  --exclude '.obsidian/' \
  --exclude '*.md' \
  ./content/ru/ "$OUT_DIST/media/"

echo "[5/7] generate combined sitemap.xml"
# Both language builds already wrote sitemaps with public URLs (trailing slash) and <lastmod>;
# the combined one keeps their <url> entries as they are.
find "$OUT_DIST" -maxdepth 1 -type f \( -name 'sitemap-index.xml' -o -name 'sitemap-*.xml' \) -delete 2>/dev/null || true
python3 - "$OUT_DIST/sitemap.xml" "$EN_ART" "$RU_ART" <<'PY'
import glob
import re
import sys

out, dirs = sys.argv[1], sys.argv[2:]
entries = {}
for d in dirs:
    for f in sorted(glob.glob(f"{d}/sitemap-*.xml")):
        if f.endswith("sitemap-index.xml"):
            continue
        for block in re.findall(r"<url>.*?</url>", open(f, encoding="utf-8").read(), re.S):
            loc = re.search(r"<loc>(.*?)</loc>", block).group(1)
            entries[loc] = re.sub(r"\s+", "", block)
with open(out, "w", encoding="utf-8") as fh:
    fh.write('<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n')
    for loc in sorted(entries):
        fh.write("  " + entries[loc] + "\n")
    fh.write("</urlset>\n")
print(f"sitemap: {len(entries)} urls")
PY

echo "[6/7] normalize robots and llms pointers"
if [[ -f "$OUT_DIST/robots.txt" ]]; then
  awk '!/^Sitemap: / && !/^LLM: /' "$OUT_DIST/robots.txt" > "$OUT_DIST/robots.txt.tmp"
  {
    cat "$OUT_DIST/robots.txt.tmp"
    echo "Sitemap: ${BASE_URL}/sitemap.xml"
    echo "LLM: ${BASE_URL}/llms.txt"
  } > "$OUT_DIST/robots.txt"
  rm -f "$OUT_DIST/robots.txt.tmp"
fi

echo "[7/7] done -> $OUT_DIST"
