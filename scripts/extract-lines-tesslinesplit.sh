#!/bin/bash

if [ ! -d lines-tesslinesplit ]; then
  mkdir lines-tesslinesplit
fi

for i in sequential_images/*.png; do
  json="lines-tesslinesplit/$(basename $i .png).json"
  if [ ! -e "$json" ]; then
    echo $i
    tesslinesplit-kraken $i $json grc
  fi
done
