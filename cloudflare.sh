#!/bin/bash

# NOTES:
# 
# PURGE EVERYTHING (in CloudFlare console, changes apply in 5 seconds) 
# after deployment and test the website in an incognito window.
#
# Also, ensure you have custom redirect:
#   Full URI: https://vcf.wtf/
#   (http.request.full_uri eq "https://vcf.wtf/")
#   Rewrite to: index.html.html


# Renames all .html files to .html.html to prevent Cloudflare Pages
# 308 redirects—Usage: ./cloudflare.sh [directory]
#
# Procedure:
# 1. Delete everything except for LICENSE and cloudflare.md
# 2. On obsidian: clear cache, and sync.
# 3. run `cloudflare.sh`
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

## This did not work, keeping for historical purposes:
## #Fix metadata.json paths to match CloudFlare URLs
## sed -i 's/\.html"/"/' site-lib/metadata.json
##
## #Same for search index if needed
## sed -i 's/\.html"/"/' site-lib/search-index.json

## This also, breaks a billion things! Don't enable!
## cp index.html.html index.html

## This is another approach that did not work due to
## internal link resolution.
##
## # Find all .html files, restructure into directories
## find "$DIR" -type f -name "*.html" ! -name "index.html" | while read -r file; do
#    dir="${file%.html}"
#    mkdir -p "$dir"
#    mv "$file" "$dir/index.html"
#    echo "Restructured: $file → $dir/index.html"
#  done

echo "Done!"
