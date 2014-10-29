#!/bin/bash
set -e
set -x

grep --recursive --include "*.md" --files-without-match '<\!--more-->' _posts
