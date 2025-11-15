#!/bin/bash
hyprctl activewindow -j | jq -r '.class' | head -c 30

socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  stdbuf -o0 grep '^activewindow>>' |
  stdbuf -o0 awk -F '>>|,' '{print $2}' |
  while read -r line; do
    echo "$line" | head -c 30
  done
