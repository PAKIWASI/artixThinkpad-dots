#!/usr/bin/bash

# ensure wifi is on
nmcli radio wifi on

# get available wifi networks
SELECTION=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list \
    | awk -F: '{printf "%s  %s%% %s\n", $1, $2, $3}' \
    | fuzzel --dmenu --prompt "Network: " --width 40 --lines 10)

[ -z "$SELECTION" ] && exit 0

SSID=$(echo "$SELECTION" | awk '{print $1}')

# check if already connected to this network
CURRENT=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
if [ "$CURRENT" = "$SSID" ]; then
    notify-send "Network" "Already connected to $SSID"
    exit 0
fi

# check if already have saved connection
if nmcli connection show "$SSID" &>/dev/null; then
    nmcli connection up "$SSID"
    notify-send "Network" "Connected to $SSID"
else
    # ask for password
    PASS=$(echo "" | fuzzel --dmenu --prompt "Password for $SSID: " --width 40 --lines 1)
    [ -z "$PASS" ] && exit 0

    # connect without disconnecting first — nmcli handles this
    if nmcli device wifi connect "$SSID" password "$PASS"; then
        notify-send "Network" "Connected to $SSID"
    else
        notify-send -u critical "Network" "Wrong password for $SSID"
    fi
fi
