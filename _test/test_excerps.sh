#!/bin/bash
set -e

grep --recursive --include "*.md" --files-without-match '<\!--more-->' _posts
