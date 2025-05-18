#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

self=$(dirname "$0")

gem install ffi -v 1.16.3
gem install fontcustom -v 2.0.0

fontcustom --version

tmp=${self}/../temp
"${self}/../_glyphs/compile.sh" "${tmp}"

for e in svg ttf woff eot css; do
  cp "${tmp}/icons.${e}" "${self}/../css"
done
