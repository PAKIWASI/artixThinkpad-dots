#!/usr/bin/env bash

MODE=$1
SAVEPATH="$HOME/Pictures/Screenshots"
TMPDIR="/tmp"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FILENAME="screenshot-$TIMESTAMP.png"
TMP="$TMPDIR/$FILENAME"
SAVE="$SAVEPATH/$FILENAME"

hyprshot -m "$MODE" -o "$TMPDIR" -f "$FILENAME" --silent
wl-copy < "$TMP"

CHOICE=$(printf 'Save\nDiscard' | fuzzel --dmenu --prompt "Screenshot: " --width=20 --lines=2 --anchor=top-right)

if [ "$CHOICE" = "Save" ]; then
    mv "$TMP" "$SAVE"
    notify-send 'Screenshot' 'Saved to ~/Pictures/Screenshots'
else
    rm -f "$TMP"
    notify-send 'Screenshot' 'Discarded'
fi
