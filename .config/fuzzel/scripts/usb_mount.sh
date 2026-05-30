#!/usr/bin/env bash

usb_disks=$(lsblk -rpo "NAME,TRAN" | awk '$2=="usb" {print $1}')

if [ -z "$usb_disks" ]; then
    notify-send "USB" "No USB devices found"
    exit 1
fi

unmounted=""
mounted=""

while IFS= read -r disk; do
    # get partitions of this disk (lines starting with disk name + digit)
    parts=$(lsblk -rno "NAME" "$disk" | grep -v "^$(basename $disk)$")
    
    while IFS= read -r part; do
        device="/dev/$part"
        mount=$(lsblk -rno "MOUNTPOINT" "$device")
        label=$(lsblk -rno "LABEL" "$device")
        size=$(lsblk -rno "SIZE" "$device")

        if [ -z "$mount" ]; then
            unmounted+="MOUNT: $device $size $label\n"
        else
            mounted+="UMOUNT: $device $size $mount\n"
        fi
    done <<< "$parts"
done <<< "$usb_disks"

menu="${unmounted}${mounted}"
[ -z "$menu" ] && notify-send "USB" "No partitions found" && exit 1

selected=$(echo -e "$menu" | fuzzel --dmenu)
[ -z "$selected" ] && exit

action=$(echo "$selected" | awk '{print $1}')
device=$(echo "$selected" | awk '{print $2}')

if [ "$action" = "MOUNT:" ]; then
    pmount "$device" && \
        notify-send "USB" "Mounted $device at /media/$(basename $device)"
else
    pumount "$device" && \
        notify-send "USB" "Unmounted $device"
fi
