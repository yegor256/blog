#!/bin/bash -e

SRC=$(pwd)
rm -rf _site
jekyll build

CLONE=$(mktemp -d -t blog)
cp -R ${SRC}/ ${CLONE}
cd ${CLONE}
git checkout gh-pages
git pull
rm -rf *
cp -R $SRC/_site/* .
rm README.md
rm deploy.sh

git add .
git commit -am "new site version"
git push origin gh-pages

rm -rf ${CLONE}
