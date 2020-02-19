#!/bin/bash

set -x

out="www/hls"
fps=25
seg=2

rm -rf "$out"
mkdir -p "$out"

raspivid -o -                          \
  -w 1920 -h 1080                      \
  -fps $fps -g $[fps*seg]              \
  -b 10000000 -t 0 |                   \
  ffmpeg                               \
    -nostdin                           \
    -f h264 -i -                       \
    -c copy                            \
    -f hls                             \
    -hls_time $seg                     \
    -hls_list_size 60                  \
    -hls_wrap 120                      \
    -hls_delete_threshold 1            \
    -hls_flags delete_segments         \
    -hls_start_number_source datetime  \
    -start_number 10                   \
    -y "$out/index.m3u8"


# vim:ts=2:sw=2:sts=2:et:ft=sh

