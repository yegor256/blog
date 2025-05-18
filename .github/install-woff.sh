#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

unzip _docker/woff.zip -d /tmp/_sfnt2woff
cd /tmp/_sfnt2woff
make
cp sfnt2woff /usr/local/bin/
sfnt2woff --version
