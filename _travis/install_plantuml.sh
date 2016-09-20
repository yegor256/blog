#!/bin/bash
set -e

wget --retry-connrefused --no-check-certificate http://img.teamed.io/yegor256/plantuml_7707-1_all.deb
sudo dpkg -i plantuml_7707-1_all.deb
rm -rf plantuml_7707-1_all.deb
