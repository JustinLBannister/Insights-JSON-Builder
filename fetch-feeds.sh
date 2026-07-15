#!/usr/bin/env bash
# ============================================================
# fetch-feeds.sh — populate ./data/{year}.xml from RBCCM feeds
# ============================================================
# The JSON Builder prefers same-origin ./data/{year}.xml files over
# live cross-origin fetches (which need a CORS proxy). Running this
# script downloads the three year feeds from rbccm.com and drops
# them into ./data/ so the tool loads instantly with no network
# round-trip on subsequent page loads.
#
# Re-run any time to refresh the cached feeds. Commit + push the
# resulting .xml files to redeploy the github-pages build.
#
# Usage:
#   bash fetch-feeds.sh
#   bash fetch-feeds.sh 2026        # single year
#
# Requires: curl. That's it.
# ------------------------------------------------------------

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR="${SCRIPT_DIR}/data"
mkdir -p "$DATA_DIR"

YEARS=("${@:-2024 2025 2026}")

for y in ${YEARS[@]}; do
  url="https://www.rbccm.com/en/insights/data/${y}-insights"
  out="${DATA_DIR}/${y}.xml"
  echo "→ ${y}: fetching ${url}"
  curl -fsSL -A "Mozilla/5.0 (JSON Builder cache)" "$url" -o "$out"
  size=$(wc -c < "$out" | tr -d ' ')
  count=$(grep -c '<news>' "$out" || true)
  echo "   saved ${out} (${size} bytes, ${count} <news> items)"
done

echo ""
echo "Done. Commit + push data/*.xml to update the github-pages build."
