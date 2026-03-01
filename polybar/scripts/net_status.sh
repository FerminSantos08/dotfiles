#!/bin/bash

EXT="eno1"
WIFI="wlo1"

if [[ "$(cat /sys/class/net/$EXT/operstate 2>/dev/null)" == "up" ]]; then
    echo "LAN"
elif [[ "$(cat /sys/class/net/$WIFI/operstate 2>/dev/null)" == "up" ]]; then
    echo "Wi-Fi"
else
    echo "Offline"
fi