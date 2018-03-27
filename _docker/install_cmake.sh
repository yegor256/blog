#!/bin/bash
set -e
set -o pipefail

wget --no-check-certificate https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz
tar xf cmake-3.5.1.tar.gz
rm -rf _cmake-3.5.1
mv cmake-3.5.1 _cmake-3.5.1
cd _cmake-3.5.1
./configure
make
make install
