#!/bin/bash
# Splits groundtruth into "checked" and "unchecked" datasets.
# This way we can train a model on the "checked" dataset, and
# then use it to prefill the "unchecked" dataset.

rm -rf groundtruth-checked
mkdir -p groundtruth-checked
fgrep ✅ groundtruth/groundtruth-index.md | sed -e 's/^.*\[\(.*\)\].*/\1/' | while read checked; do
  cp -v groundtruth/${checked}.png groundtruth/${checked}.html groundtruth-checked/
done

rm -rf groundtruth-unchecked
mkdir -p groundtruth-unchecked
fgrep ❌ groundtruth/groundtruth-index.md | sed -e 's/^.*\[\(.*\)\].*/\1/' | while read unchecked; do
  cp -v groundtruth/${unchecked}.png groundtruth/${unchecked}.html groundtruth-unchecked/
done
