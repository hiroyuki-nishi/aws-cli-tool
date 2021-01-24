#!/usr/bin/env bash

roop=$1
echo $roop

function show_progress() {
  for i in `seq $1`
  do
    sleep 0.5
    bar="$(yes '#' | head -n ${i} | tr -d '\n')"
    progress=`echo "scale=5; $i / $1 * 100" | bc`
    printf "\r%.0f%s %s" $progress \% ${bar}
  done
  printf "\n"
}

show_progress $roop
