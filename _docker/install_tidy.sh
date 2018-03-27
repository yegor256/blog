#!/bin/bash
set -e

if [ -e _tidy-html5/build/cmake ]; then
  cd _tidy-html5/build/cmake
  echo "tidy-html5 already exists in cache, won't build again"
else
  git clone https://github.com/htacg/tidy-html5.git _tidy-html5
  cd _tidy-html5/build/cmake
  git checkout 5.1.25
  cmake ../..
  make
fi
make install
