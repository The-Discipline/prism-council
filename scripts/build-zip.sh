#!/usr/bin/env bash
# Builds dist/prism-council.zip for upload in the Claude app (Customize > Skills).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/prism-council.zip
(cd plugins/prism/skills && zip -r ../../../dist/prism-council.zip prism-council)
echo "Built dist/prism-council.zip"
