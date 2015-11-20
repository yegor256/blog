#!/bin/bash
set -e

git clone https://github.com/htacg/tidy-html5.git
cd tidy-html5/build/cmake
git checkout 5.1.9
cmake ../..
make
sudo make install
cd ../../..; rm -rf tidy-html5
