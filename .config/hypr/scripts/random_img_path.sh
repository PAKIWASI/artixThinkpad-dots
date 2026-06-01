#!/usr/bin/env bash

DIR="${1:-.}"

find "$DIR" -type f \( \
    -iname "*.jpg"  -o -iname "*.jpeg" -o \
    -iname "*.png"  -o -iname "*.webp" -o \
    -iname "*.gif"  -o -iname "*.avif" -o \
    -iname "*.jxl"  -o -iname "*.bmp"  \
\) | shuf -n 1
