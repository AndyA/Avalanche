#!/bin/bash

# From 
#  https://trac.ffmpeg.org/wiki/Concatenate

concat_init() {
  echo "concat_init"
  concat_pls=`mktemp -u -p . concat.XXXXXXXXXX.txt`
  concat_pls="${concat_pls#./}"
  echo "concat_pls=${concat_pls:?}"
  mkfifo "${concat_pls:?}"
}

concat_feed() {
  echo "concat_feed ${1:?}"
  {
    >&2 echo "removing ${concat_pls:?}"
    rm "${concat_pls:?}"
    concat_pls=
    >&2 concat_init
    echo 'ffconcat version 1.0'
    echo "file '${1:?}'"
    echo "file '${concat_pls:?}'"
  } >"${concat_pls:?}"
}

concat_end() {
  echo "concat_end"
  {
    >&2 echo "removing ${concat_pls:?}"
    rm "${concat_pls:?}"
  } >"${concat_pls:?}"
}

# vim:ts=2:sw=2:sts=2:et:ft=sh

