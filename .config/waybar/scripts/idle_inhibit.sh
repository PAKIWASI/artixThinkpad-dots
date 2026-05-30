#!/usr/bin/env bash

COOKIE_FILE="/tmp/idle-inhibit-cookie"

case "$1" in
    toggle)
        if [ -f "$COOKIE_FILE" ]; then
            COOKIE=$(cat "$COOKIE_FILE")
            dbus-send --session --dest=org.freedesktop.ScreenSaver \
                --type=method_call \
                /org/freedesktop/ScreenSaver \
                org.freedesktop.ScreenSaver.UnInhibit \
                uint32:"$COOKIE"
            rm "$COOKIE_FILE"
        else
            COOKIE=$(dbus-send --session --dest=org.freedesktop.ScreenSaver \
                --type=method_call --print-reply \
                /org/freedesktop/ScreenSaver \
                org.freedesktop.ScreenSaver.Inhibit \
                string:"waybar" string:"user requested" \
                | awk '/uint32/ {print $2}')
            echo "$COOKIE" > "$COOKIE_FILE"
        fi
        pkill -RTMIN+8 waybar
        ;;
    status)
        if [ -f "$COOKIE_FILE" ]; then
            echo '{"text":" ","class":"active","tooltip":"Idle inhibit enabled"}'
        else
            echo '{"text":"󰛊 ","class":"inactive","tooltip":"Idle inhibit disabled"}'
        fi
        ;;
esac
