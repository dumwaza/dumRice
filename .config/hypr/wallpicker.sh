#!/bin/bash

# === CONFIGURACIÓN ===
WALLPAPER_DIR="$HOME/.config/wallpapers"
THUMB_DIR="$WALLPAPER_DIR/thumbs"
NAMESPACE="wayland-1"

# === CREAR MINIATURAS ===
mkdir -p "$THUMB_DIR"
for img in "$WALLPAPER_DIR"/*.{jpg,png,jpeg}; do
    [ -f "$img" ] || continue
    thumb="$THUMB_DIR/$(basename "$img")"
    [ -f "$thumb" ] || convert "$img" -resize 300x200^ -gravity center -extent 300x200 "$thumb"
done

# === GENERAR ENTRADAS PARA ROFI ===
mapfile -t entries < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) ! -iname "wallpaper.png")

rofi_input=""
for img in "${entries[@]}"; do
    base=$(basename "$img")
    thumb="$THUMB_DIR/$base"
    rofi_input+="${base}\x00icon\x1f${thumb}\n"
done

# === MOSTRAR ROFI CON MINIATURAS ===
selected=$(echo -en "$rofi_input" | rofi -dmenu -show-icons -theme-str '
window { width: 60%; }
listview { columns: 4; lines: 3; spacing: 10px; }
' -p "Elige tu wallpaper")

# === APLICAR WALLPAPER ===
[ -z "$selected" ] && exit 0

# Ruta completa del wallpaper seleccionado
selected_path="$WALLPAPER_DIR/$selected"

# Aplica el wallpaper
swww img "$selected_path" \
  --namespace "$NAMESPACE" \
  --transition-type any \
  --transition-duration 0.6 \
  --transition-fps 60 \
  --transition-bezier 0.4,0.0,0.2,1.0

# Copiar el wallpaper seleccionado a wallpaper.png para Hyprlock
cp "$selected_path" ~/.config/wallpapers/wallpaper.png


# Guarda el último wallpaper en un archivo
echo "$selected_path" > ~/.config/hypr/last_wallpaper.txt
