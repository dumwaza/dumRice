#!/bin/bash

sleep 0

# Iniciar swww-daemon si no está corriendo
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon --namespace wayland-1 &
    sleep 1
fi

# Leer el último wallpaper si existe, o usar uno por defecto
if [ -f ~/.config/hypr/last_wallpaper.txt ]; then
    WALLPAPER=$(cat ~/.config/hypr/last_wallpaper.txt)
else
    WALLPAPER="$HOME/Imágenes/wallpapers/wallpaper.png"
fi

# Aplicar el wallpaper
swww img "$WALLPAPER" --namespace wayland-1 --transition-type any
