#!/bin/bash

sleep 1

xrandr \
--output HDMI-1-0 --primary --auto \
--output eDP --auto --right-of HDMI-1-0
