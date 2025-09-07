#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

apt-get update --yes --fix-missing

apt-get install --yes --no-install-recommends \
    aspell=* aspell-en=* \
    graphviz=* gnuplot=* \
    s3cmd=* \
    liblapack-dev=* \
    cmake=* \
    libxml2-utils=* \
    shellcheck=* \
    plantuml=*
apt-get clean
rm -rf /var/lib/apt/lists/*

plantuml -version
aspell --version
gnuplot --version
cmake --version
shellcheck --version
