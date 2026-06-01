#!/usr/bin/env bash

fallback=$(~/.config/hypr/scripts/random_img_path.sh ~/Pictures/Pfps)

url=$(playerctl metadata mpris:artUrl 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "$fallback"
    exit 0
fi

if [[ "$url" == file://* ]]; then
    path="${url#file://}"
    [[ -f "$path" ]] && echo "$path" || echo "$fallback"
elif [[ "$url" == http* ]]; then
    cache="/tmp/hyprlock-cover.jpg"
    curl -sf "$url" -o "$cache" && echo "$cache" || echo "$fallback"
else
    echo "$fallback"
fi
