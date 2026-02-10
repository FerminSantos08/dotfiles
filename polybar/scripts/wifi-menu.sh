#!/usr/bin/env bash

chosen=$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL device wifi list \
  | sed 's/^*://' \
  | rofi -dmenu -p "WiFi")

[ -z "$chosen" ] && exit

ssid=$(echo "$chosen" | cut -d: -f1)

nmcli device wifi connect "$ssid"
