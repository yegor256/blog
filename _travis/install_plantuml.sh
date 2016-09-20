#!/bin/bash
set -e

wget --retry-connrefused --no-check-certificate http://img.teamed.io/yegor256/plantuml_7707-1_all.deb
dpkg -i plantuml_7707-1_all.deb
rm -rf plantuml_7707-1_all.deb
