#!/bin/bash

# Renames all .html files to .html.html to prevent Cloudflare Pages 308 redirects
# Usage: ./rename-html.sh [directory]

set -euo pipefail

DIR="${1:-.}"

# Find all .html files (excluding already doubled ones)
find "$DIR" -type f -name "*.html" ! -name "*.html.html" | while read -r file; do
    mv "$file" "${file}.html"
    echo "Renamed: $file → ${file}.html"
done

echo "Done!"