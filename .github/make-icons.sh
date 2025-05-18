#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

self=$(dirname "$0")

fontcustom --version

tmp=${self}/../_temp
mkdir -p "${tmp}"
"${self}/compile-glyphs.sh" "${tmp}"

for e in svg ttf woff eot css; do
  cp "${tmp}/icons.${e}" "${self}/../css"
done
