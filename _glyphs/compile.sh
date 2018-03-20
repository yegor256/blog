#!/bin/bash
set -e
set -x

# we need this in order to avoid conflicts with Gemfile
unset BUNDLE_GEMFILE
cd /tmp

x=$(readlink --canonicalize-existing "$0")
dir=$(dirname "$x")

target=$1

mkdir -p "${target}"
fontcustom compile "${dir}" \
  "--output=${target}" \
  --font-name=icons --templates=css --no-hash --force --autowidth
sed -i -E "s|\"./icons([^\"]+)\"|\"http://www.yegor256.com/css/icons\1%3F$(date +%s)\"|g" "${target}/icons.css"
