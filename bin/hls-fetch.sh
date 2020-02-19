#!/bin/bash

hosts=(
  avalanche1.pike
)

keep="/data/avalanche/hosts"

while ssleep 10; do
  for host in "${hosts[@]}"; do
    src="$host:/opt/avalanche/keep/"
    dst="$keep/$host/"
    mkdir -p "$dst"
    rsync -a --remove-source-files "$src" "$dst"
  done
done

# vim:ts=2:sw=2:sts=2:et:ft=sh

