#!/bin/bash

for i in groundtruth-unchecked/*.png; do
  base=$(basename $i .png)
  echo $base
  $DOCKER_PREFIX ketos transcribe --prefill voulgaris_best_nfc.mlmodel -l lines/${base}.json -o groundtruth/${base}.html $i
done
