#!/bin/bash

# Renames all .html files to .html.html to prevent Cloudflare Pages
# 308 redirects—Usage: ./cloudflare.sh [directory]
#
# Procedure:
# 1. Delete everything except for LICENSE and cloudflare.md
# 2. On obsidian: clear cache, and sync.
# 3. run `cloudflare.sh`
# 3.1 re-sync (to keep both files.
# 4. Wait for a while for the IDE/WSL to sync up.
# 5. commit and push.
# 6. Verify that the upstream site is in good shape.


set -euo pipefail

DIR="${1:-.}"

# Find all .html files (excluding already doubled ones)
find "$DIR" -type f -name "*.html" ! -name "*.html.html" | while read -r file; do
    cp "$file" "${file}.html"
    echo "Renamed: $file → ${file}.html"
done

## Fix metadata.json paths to match CloudFlare URLs
#sed -i 's/\.html"/"/' site-lib/metadata.json
#
## Same for search index if needed
#sed -i 's/\.html"/"/' site-lib/search-index.json

echo "Done!"

## Find all .html files, restructure into directories
# This will not work because of internal links.
#find "$DIR" -type f -name "*.html" ! -name "index.html" | while read -r file; do
#    dir="${file%.html}"
#    mkdir -p "$dir"
#    mv "$file" "$dir/index.html"
#    echo "Restructured: $file → $dir/index.html"
#done

echo "Done!"