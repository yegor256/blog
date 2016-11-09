#!/bin/bash
set -e
set -o pipefail

wget --no-check-certificate https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz
tar xf cmake-3.5.1.tar.gz
cd cmake-3.5.1
./configure
make
make install
cd ..; rm -rf cmake-3.5.1
