#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

curl -fsSL https://deb.nodesource.com/setup_26.x | bash
apt-get install --yes --no-install-recommends 'nodejs=26.*'
apt-get clean
rm -rf /var/lib/apt/lists/*

node --version
npm --version
