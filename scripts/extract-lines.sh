#!/bin/bash

if [ ! -d lines ]; then
  mkdir lines
fi

for i in sequential_images/*.png; do
  json="lines/$(basename $i .png).json"
  if [ ! -e "$json" ]; then
    echo $i
    $DOCKER_PREFIX kraken -i $i $json binarize segment
  fi
done
