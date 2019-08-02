#!/bin/bash

if [ ! -d images ]; then
  mkdir -p images
  for i in 1 2 3; do echo $i; pdfimages -png pdfs/voulgaris_${i}.pdf images/voulgaris_${i}; done
  # delete Google logos
  find images -type f -size -10k -print -delete
fi
if [ ! -d sequential_images ]; then
  mkdir -p sequential_images
  for i in 1 2 3; do j=0; find images -type f -name "voulgaris_${i}-*.png" | sort -t '-' -k 2 -n | while read png; do echo "$png"; mv -v "$png" sequential_images/voulgaris_${i}_page_$(printf "%05d" $j).png; j=$(( $j + 1 )); done; done
fi
