#!/usr/bin/env bash


url=$(playerctl metadata mpris:artUrl 2>/dev/null)
fallback="$HOME/Pictures/pfps/ok/11.png"

[ -z "$url" ] && echo "$fallback" && exit

if [[ "$url" == file://* ]]; then
    echo "${url#file://}"
elif [[ "$url" == http* ]]; then
    cache="/tmp/hyprlock-cover.jpg"
    curl -sf "$url" -o "$cache" && echo "$cache" || echo "$fallback"
else
    echo "$fallback"
fi
