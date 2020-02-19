#!/bin/bash

src="www/hls"
dst="keep"

last=""
while sleep 5; do
  while read file; do
    if [[ $file > $last ]]; then
      echo "$file"
      last="$file"
    fi
  done < <( find "$src" -mmin +1 | sort )
done | cpio -pld "$dst"

# vim:ts=2:sw=2:sts=2:et:ft=sh

