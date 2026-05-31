#!/usr/bin/env bash

LOCK_FILE="/tmp/idle-inhibit.lock"
FD_FILE="/tmp/idle-inhibit.fd"

case "$1" in
    toggle)
        if [ -f "$LOCK_FILE" ]; then
            # Release the lock by killing the sleep holding the fd
            PID=$(cat "$LOCK_FILE")
            kill "$PID" 2>/dev/null
            rm -f "$LOCK_FILE" "$FD_FILE"
        else
            # Acquire an inhibit lock via elogind-inhibit
            elogind-inhibit --what=idle \
                            --who="waybar" \
                            --why="user requested" \
                            --mode=block \
                            sleep infinity &
            echo $! > "$LOCK_FILE"
        fi
        pkill -RTMIN+8 waybar
        ;;
    status)
        if [ -f "$LOCK_FILE" ] && kill -0 "$(cat "$LOCK_FILE")" 2>/dev/null; then
            echo '{"text":" ","class":"active","tooltip":"Idle inhibit enabled"}'
        else
            # Clean up stale lock file if process is dead
            rm -f "$LOCK_FILE"
            echo '{"text":"󰛊 ","class":"inactive","tooltip":"Idle inhibit disabled"}'
        fi
        ;;
esac
