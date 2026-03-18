#!/bin/bash

# detectar player que esté reproduciendo
player=$(playerctl -l 2>/dev/null | while read p; do
  if [[ "$(playerctl -p "$p" status 2>/dev/null)" == "Playing" ]]; then
    echo "$p"
    break
  fi
done)

# fallback al primero
if [[ -z "$player" ]]; then
  player=$(playerctl -l 2>/dev/null | head -n 1)
fi

[[ -z "$player" ]] && exit 0

status=$(playerctl -p "$player" status 2>/dev/null)
artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
title=$(playerctl -p "$player" metadata title 2>/dev/null)

[[ -z "$artist" ]] && exit 0

# icono según player
case "$player" in
  spotify) icon="" ;;
  firefox|chromium) icon="" ;;
  *) icon="🎵" ;;
esac

max=35
text="$artist - $title"
[[ ${#text} -gt $max ]] && text="${text:0:$max}..."

current="$artist - $title"
last_file="/tmp/last_song"
anim_file="/tmp/last_anim"

classes=()

# detectar cambio
if [[ "$current" != "$(cat $last_file 2>/dev/null)" ]]; then
  echo "$current" > "$last_file"
  date +%s > "$anim_file"
fi

# animación (2s)
if [[ -f "$anim_file" ]]; then
  now=$(date +%s)
  last=$(cat "$anim_file")

  if (( now - last < 2 )); then
    classes+=("changed")
  fi
fi

# estado
if [[ "$status" == "Playing" ]]; then
  classes+=("playing")
elif [[ "$status" == "Paused" ]]; then
  classes+=("paused")
fi

# convertir array a string
class="${classes[*]}"

echo "{\"text\": \"$icon  $text\", \"class\": \"$class\"}"