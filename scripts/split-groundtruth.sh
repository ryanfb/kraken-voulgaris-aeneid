#!/bin/bash
# Splits groundtruth into "checked" and "unchecked" datasets.
# This way we can train a model on the "checked" dataset, and
# then use it to prefill the "unchecked" dataset.

fgrep ✅ groundtruth/groundtruth-index.md | sed -e 's/^.*\[\(.+\)\].*/\1'| while readchecked; do
  rm -rf groundtruth-checked
  mkdir -p groundtruth-checked
  cp -v groundtruth/${checked}.png groundtruth/${checked}.html groundtruth-checked/
done

fgrep ❌ groundtruth/groundtruth-index.md | sed -e 's/^.*\[\(.+\)\].*/\1'| while read unchecked; do
  rm -rf groundtruth-unchecked
  mkdir -p groundtruth-unchecked
  cp -v groundtruth/${unchecked}.png groundtruth/${unchecked}.html groundtruth-unchecked/
done
