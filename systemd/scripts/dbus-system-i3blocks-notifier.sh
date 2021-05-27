#!/usr/bin/env sh

dbus-monitor --system --profile | while read -r line; do
    parts=($line)
    type=${parts[0]}
    timestamp=${parts[1]}
    serial=${parts[2]}
    sender=${parts[3]}
    destination=${parts[4]}
    path=${parts[5]}
    interface=${parts[6]}
    member=${parts[7]}
    case $path in
    *NetworkManager*)
        pkill -SIGRTMIN+3 i3blocks
        ;;
    *UPower*)
        pkill -SIGRTMIN+2 i3blocks
        ;;
    *org/bluez*)
        pkill -SIGRTMIN+4 i3blocks
        ;;
    esac
done
