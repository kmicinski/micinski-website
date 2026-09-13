#!/bin/sh
# Deploy a clean build to ../kmicinski.github.io.
# _site is wiped first so pages from `jekyll serve --unpublished` never leak.
set -e
cd "$(dirname "$0")"
rm -rf _site
jekyll build
# Safety net: no post marked `published: false` may appear in the build.
for f in $(grep -l '^published: *false' _posts/*.md); do
  slug=$(sed -n 's/^permalink: *"\{0,1\}\/\{0,1\}\([^"]*\)"\{0,1\}$/\1/p' "$f" | head -1)
  if [ -n "$slug" ] && [ -e "_site/$slug.html" -o -e "_site/$slug/index.html" ]; then
    echo "unpublished post $f leaked into _site as /$slug; aborting"; exit 1
  fi
done
cp -R _site/* ../kmicinski.github.io
cd ../kmicinski.github.io
git add .
git commit -m "update.."
git push origin master
