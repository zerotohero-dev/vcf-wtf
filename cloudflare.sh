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
    mv "$file" "${file}.html"
    echo "Renamed: $file → ${file}.html"
done

echo "Done!"