#!/bin/bash
set -e

if [ -e tidy-html5 ]; then
  cd tidy-html5/build/cmake
else
  git clone https://github.com/htacg/tidy-html5.git
  cd tidy-html5/build/cmake
  git checkout 5.1.25
  cmake ../..
  make
fi
make install
