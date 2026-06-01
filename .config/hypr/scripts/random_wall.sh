#!/usr/bin/env bash

DIR="${1:-$HOME/Pictures/Wallpapers}"

IMG=$(find "$DIR" -type f \( \
    -iname "*.jpg"  -o -iname "*.jpeg" -o \
    -iname "*.png"  -o -iname "*.webp" -o \
    -iname "*.gif"  -o -iname "*.avif" -o \
    -iname "*.jxl"  \
\) | shuf -n 1)

[[ -z "$IMG" ]] && exit 1
swaybg -i "$IMG" -m fill
