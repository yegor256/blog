#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

self=$(dirname "$0")

tmp=${self}/../_temp

cd "${tmp}"

git clone https://github.com/htacg/tidy-html5.git _tidy-html5
cd _tidy-html5/build/cmake
git checkout 5.8.0
cmake ../..
make
make install

tidy --version
