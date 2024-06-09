#!/bin/bash
# Copyright (c) 2014-2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e
set -x

dir=$(dirname "$0")

target=$1

mkdir -p "${target}"

fontcustom compile "${dir}" \
  "--output=${target}" \
  --font-name=icons --templates=css --no-hash --force --autowidth --debug

sed -E "s|\"./icons([^\"]+)\"|\"https://www.yegor256.com/css/icons\1?$(date +%s)\"|g" < "${target}/icons.css" > "${target}/icons.css"

