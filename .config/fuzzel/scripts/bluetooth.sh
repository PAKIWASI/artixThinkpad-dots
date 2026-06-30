#!/usr/bin/bash

# make sure bluetooth is on
bluetoothctl power on &>/dev/null

# scan briefly
bluetoothctl scan on &
SCAN_PID=$!
sleep 3
kill $SCAN_PID

# get devices
SELECTION=$(bluetoothctl devices \
    | awk '{$1=""; $2=""; print $0}' \
    | sed 's/^ *//' \
    | fuzzel --dmenu --prompt "Bluetooth: " --width 40 --lines 10)

[ -z "$SELECTION" ] && exit 0

# get mac from device name
MAC=$(bluetoothctl devices | grep "$SELECTION" | awk '{print $2}')

# toggle connect/disconnect
if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$MAC"
    notify-send "Bluetooth" "Disconnected from $SELECTION"
else
    bluetoothctl connect "$MAC"
    notify-send "Bluetooth" "Connected to $SELECTION"
fi
