#!/usr/bin/env bash

# Obtener sink por defecto
SINK=$(pactl get-default-sink)

# Obtener volumen
VOLUME=$(pactl get-sink-volume "$SINK" | grep -o '[0-9]\+%' | head -n1)

# Ver si está muteado
MUTED=$(pactl get-sink-mute "$SINK" | awk '{print $2}')

# Detectar tipo de salida por nombre
if echo "$SINK" | grep -qi "headphone"; then
  ICON=""
elif echo "$SINK" | grep -qi "usb"; then
  ICON=""
else
  ICON=""
fi

# Mute
if [ "$MUTED" = "yes" ]; then
  ICON=""
fi

echo "$ICON $VOLUME"
