#!/bin/bash
set -e

# we need this in order to avoid conflicts with Gemfile
unset BUNDLE_GEMFILE
cd /tmp

dir=$(dirname $0)

mkdir -p "${dir}/../_temp/icons"
fontcustom compile "${dir}" \
  "--output=${dir}/../_temp/icons" \
  --font-name=icons --templates=css --no-hash --force --autowidth
sed -i "s|./icons|/css/icons|g" "${dir}/../_temp/icons/icons.css"
