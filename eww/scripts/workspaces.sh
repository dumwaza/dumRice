#!/bin/bash

# Mostrar workspaces iniciales
hyprctl workspaces -j | jq 'map(.id) | sort'

# Escuchar cambios de Hyprland
socat -u UNIX-CONNECT:${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock - | \
while read -r line; do
  hyprctl workspaces -j | jq 'map(.id) | sort'
done
