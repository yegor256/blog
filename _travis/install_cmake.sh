#!/bin/bash
set -e
set -o pipefail

wget --no-check-certificate http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz
tar xf cmake-3.2.2.tar.gz
cd cmake-3.2.2
./configure
make
sudo make install
cd ..; rm -rf cmake-3.2.2
