#!/usr/bin/env bash

ssid=$(iwgetid -r)

if [ -z "$ssid" ]; then
  echo "󰤭 Offline"
else
  echo "󰤨 $ssid"
fi
