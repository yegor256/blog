#!/bin/bash
set -e
set -x

# we need this in order to avoid conflicts with Gemfile
unset BUNDLE_GEMFILE
cd /tmp

dir=$(dirname "$0")

target=$1

mkdir -p "${target}"
fontcustom compile "${dir}" \
  "--output=${target}" \
  --font-name=icons --templates=css --no-hash --force --autowidth --debug
cat "${target}/icons.css" | sed -E "s|\"./icons([^\"]+)\"|\"https://www.yegor256.com/css/icons\1?$(date +%s)\"|g" > "${target}/icons.css"
