#!/bin/bash
set -e

wget --retry-connrefused --no-check-certificate http://yar.fruct.org/attachments/download/362/plantuml_7707-1_all.deb
sudo dpkg -i plantuml_7707-1_all.deb
rm -rf plantuml_7707-1_all.deb
