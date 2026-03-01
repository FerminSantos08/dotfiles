#!/usr/bin/env bash

# Cambiar layout segun dock/mobile
autorandr --change

# Esperar estabilidad
sleep 2

# Reiniciar polybar
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Detectar monitor primario
PRIMARY=$(xrandr | awk '/ primary/{print $1}')

# Lanzar polybar en el primario
MONITOR=$PRIMARY polybar main &