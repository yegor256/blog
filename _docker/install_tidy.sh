#!/bin/bash
set -e
set -o pipefail

git clone https://github.com/htacg/tidy-html5.git _tidy-html5
cd _tidy-html5/build/cmake
git checkout 5.1.25
cmake ../..
make
make install
