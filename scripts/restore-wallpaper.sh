#!/bin/bash

LAST_WALLPAPER_FILE="$HOME/.config/hypr/last_wallpaper.txt"

# Verificar que swww está corriendo
if ! pgrep swww > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Si existe el archivo con el último wallpaper, cargarlo
if [ -f "$LAST_WALLPAPER_FILE" ]; then
    last_wallpaper=$(cat "$LAST_WALLPAPER_FILE")
    if [ -f "$last_wallpaper" ]; then
        swww img "$last_wallpaper" \
          --transition-type fade \
          --transition-duration 1 \
          --transition-fps 60
    fi
fi
