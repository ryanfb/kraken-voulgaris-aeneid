#!/bin/bash

echo '---'
echo '---'

for i in groundtruth/*.png; do
  base=$(basename $i .png)
  echo " * ❌ [${base}](${base}.html)"
done
