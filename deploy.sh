#!/bin/sh
# Deploy a clean build to ../kmicinski.github.io.
# _site is wiped first so pages from `jekyll serve --unpublished` never leak.
set -e
cd "$(dirname "$0")"
rm -rf _site
jekyll build
if ls _site | grep -q "^new-post"; then echo "unpublished post leaked into _site; aborting"; exit 1; fi
cp -R _site/* ../kmicinski.github.io
cd ../kmicinski.github.io
git add .
git commit -m "update.."
git push origin master
