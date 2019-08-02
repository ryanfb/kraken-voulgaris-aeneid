#!/bin/bash

for i in groundtruth/*.png; do
  base=$(basename $i .png)
  echo " * ❌ [${base}](${base}.html)"
done
