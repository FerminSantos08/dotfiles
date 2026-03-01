#!/bin/bash

# Nombre de tu monitor externo según xrandr
EXT_MONITOR="HDMI-1-0"
LAPTOP_SCREEN="eDP-1"

# Verifica si el monitor externo está conectado
if xrandr | grep "$EXT_MONITOR connected" > /dev/null; then
    # Monitor externo conectado: a la izquierda de la laptop
    xrandr --output "$EXT_MONITOR" --auto --left-of "$LAPTOP_SCREEN"
else
    # Solo pantalla de laptop
    xrandr --output "$LAPTOP_SCREEN" --auto
fi

