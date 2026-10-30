#!/usr/bin/env bash
# Builds dist/prismatize.zip for upload in the Claude app (Customize > Skills).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/prismatize.zip
(cd plugins/prism/skills && zip -r ../../../dist/prismatize.zip prismatize)
echo "Built dist/prismatize.zip"
