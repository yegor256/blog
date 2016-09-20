#!/bin/bash
set -e

for i in $(ls js/*.js); do
  jslint $i
done
