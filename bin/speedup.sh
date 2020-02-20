#!/bin/bash

set -e
lib="$(dirname "$0")/../lib/bash"

source "$lib/fffeed.sh"

src="$1"

cd "$src"

get_session() {
  session="${1%-*}"
}

last=""
while sleep 1; do
  while read file; do
    if [[ $file > $last ]]; then
      echo "$file"
      last="$file"
    fi
  done < <( find . -iname '*.ts' | sort )
done | {
  last_session=
  while read file; do
    name="$(basename "$file")"
    session="${name%-*}"
    output="tmp/$session.ts"
    echo "$session $file"
    if [[ $session != $last_session ]]; then
      echo "New session $session"
      if [[ ! -z $last_session ]]; then
        concat_end
        wait $ffpid;
      fi
      last_session="$session"
      concat_init
      ffmpeg                          \
        -nostdin                      \
        -hide_banner -loglevel panic  \
        -f concat -i "$concat_pls"    \
        -c copy                       \
        -y "$output" &
      ffpid=$!
    fi
    concat_feed "$file"
  done
  if [[ ! -z $last_session ]]; then
    concat_end
    wait $ffpid;
  fi
}
