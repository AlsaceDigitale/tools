#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage $0 SRC DST"
  exit 1
fi

SRC=$1
DST=$2

echo "Start transfer from $SRC to $DST ($(date))"

for file in $(rsync --min-size=1 --list-only -r "$SRC" | tr -s ' ' | cut -d' ' -f5-) ; do
  if [ -f "$SRC/$file" ] ; then
    if [ -s "$SRC/$file" ] ; then
      echo "Transferring $file"
      cp "$SRC/$file" "$DST/$file"
      truncate -s 0 "$SRC/$file"
    fi
  else
    mkdir "$DST/$file" 2>/dev/null
  fi
done


