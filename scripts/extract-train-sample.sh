#!/bin/bash

NUM_PAGES=70
PAGES_START[1]=48
PAGES_END[1]=374
PAGES_START[2]=14
PAGES_END[2]=350
PAGES_START[3]=10
PAGES_END[3]=734

if [ ! -d groundtruth ]; then
  mkdir -p groundtruth
  for i in 1 2 3; do
    VOLUME_PAGES[$i]=`seq ${PAGES_START[$i]} 2 ${PAGES_END[$i]} | cat`
    NUM_PAGES[$i]=$(echo ${VOLUME_PAGES[$i]} | wc -w)
  done
  TOTAL_PAGES=$(expr ${NUM_PAGES[1]} + ${NUM_PAGES[2]} + ${NUM_PAGES[3]})
  echo $TOTAL_PAGES
  for i in 1 2 3; do
    PROPORTIONAL_PAGES[$i]=$(printf '%.0f' $(echo "( ${NUM_PAGES[$i]} / $TOTAL_PAGES ) * $NUM_PAGES" | bc -l))
    RANDOM_PAGES[$i]=$(echo ${VOLUME_PAGES[$i]} | tr ' ' '\n' | shuf | head -${PROPORTIONAL_PAGES[$i]})
    echo ${RANDOM_PAGES[$i]}
    for j in ${RANDOM_PAGES[$i]}; do
      cp -v sequential_images/voulgaris_${i}_page_$(printf '%05d' $j).png groundtruth/
    done
  done
fi
