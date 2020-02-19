#!/bin/bash

set -e

cd "$(dirname "$0")/.."

out="www/hls"
fps=25
seg=2
mbits=3

index="$out/index.m3u8"
segment="$out/seg-%Y%m%d-%H%M%S.ts"

rm -rf "$out"
mkdir -p "$out"

raspivid -o -                          \
  -w 1920 -h 1080                      \
  -fps $fps -g $[fps*seg]              \
  -b $[mbits*1000000] -t 0 |           \
  ffmpeg                               \
    -nostdin                           \
    -hide_banner -loglevel panic       \
    -f h264 -i -                       \
    -c copy                            \
    -f hls                             \
    -hls_time $seg                     \
    -hls_list_size 60                  \
    -hls_delete_threshold 1            \
    -hls_flags delete_segments         \
    -hls_start_number_source datetime  \
    -hls_allow_cache 1                 \
    -hls_playlist_type event           \
    -strftime 1                        \
    -hls_segment_filename "$segment"   \
    -start_number 10                   \
    -y "$index"


# vim:ts=2:sw=2:sts=2:et:ft=sh

