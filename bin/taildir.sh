#!/bin/bash

set -e

dir=${1:?}

last=""
delay=1
while sleep $delay; do
  delay=$[delay * 2]
  [[ $delay -gt 60 ]] && delay=60
  while read file; do
    if [[ $file > $last ]]; then
      echo "$file"
      last="$file"
      delay=1
    fi
  done < <( find "$dir" -iname '*.ts' | sort )
done

# vim:ts=2:sw=2:sts=2:et:ft=sh

