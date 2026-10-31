#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

self=$(dirname "$0")

apt-get update --yes
apt-get install --yes --no-install-recommends fontforge=* woff2=*
apt-get clean
rm -rf /var/lib/apt/lists/*

unzip "${self}/../_docker/woff.zip" -d /tmp/_sfnt2woff
cd /tmp/_sfnt2woff
make
cp sfnt2woff /usr/bin/

git clone --recursive https://github.com/google/woff2.git
cd woff2
make clean all
for f in woff2_compress woff2_decompress woff2_info; do
  cp "${f}" /usr/bin
done
