#!/bin/bash

set -x

out="hls"
mkdir -p "$out"

raspivid -o -                        \
  -w 1920 -h 1080                    \
  -fps 25 -g 250                     \
  -b 10000000 -t 0 |                 \
  ffmpeg                             \
    -nostdin -f h264 -i - -c copy    \
    -f segment                       \
    -segment_list "$out/index.m3u8"  \
    -segment_time 10                 \
    -segment_format mpegts           \
    -segment_list_type m3u8          \
    -segment_list_flags +live        \
    -y "$out/seg%08d.ts"



# vim:ts=2:sw=2:sts=2:et:ft=sh

