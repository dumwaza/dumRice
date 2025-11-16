#!/bin/bash

# === CONFIGURACIÓN ===
WALLPAPER_DIR="$HOME/.config/wallpapers"
THUMB_DIR="$WALLPAPER_DIR/thumbs"

# === CREAR MINIATURAS ===
mkdir -p "$THUMB_DIR"

for img in "$WALLPAPER_DIR"/*.{jpg,png,jpeg,JPG,PNG,JPEG}; do
    [ -f "$img" ] || continue
    thumb="$THUMB_DIR/$(basename "$img")"
    [ -f "$thumb" ] || convert "$img" -resize 300x200^ -gravity center -extent 300x200 "$thumb" 2>/dev/null
done

# === GENERAR LISTA DE WALLPAPERS ===
cd "$WALLPAPER_DIR" || exit 1

# Crear array con los wallpapers (excluyendo wallpaper.png)
wallpapers=()
for f in *.{jpg,png,jpeg,JPG,PNG,JPEG}; do
    [ -f "$f" ] || continue
    [ "$f" = "wallpaper.png" ] && continue
    wallpapers+=("$f")
done

# Verificar que hay wallpapers
if [ ${#wallpapers[@]} -eq 0 ]; then
    notify-send "Error" "No se encontraron wallpapers"
    exit 1
fi

# === MOSTRAR ROFI CON MINIATURAS ===
selected=$(
    for wallpaper in "${wallpapers[@]}"; do
        thumb="$THUMB_DIR/$wallpaper"
        printf '%s\x00icon\x1f%s\n' "$wallpaper" "$thumb"
    done | rofi -dmenu -show-icons -theme-str '
window { width: 60%; }
listview { columns: 4; lines: 3; spacing: 10px; }
' -p "Elige tu wallpaper"
)

# === APLICAR WALLPAPER ===
[ -z "$selected" ] && exit 0

selected_path="$WALLPAPER_DIR/$selected"

# Verificar que swww está corriendo
if ! pgrep swww > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Aplicar wallpaper
swww img "$selected_path" \
  --transition-type any \
  --transition-duration 0.6 \
  --transition-fps 60 \
  --transition-bezier 0.4,0.0,0.2,1.0

# Copiar para Hyprlock
cp "$selected_path" "$WALLPAPER_DIR/wallpaper.png"

# Guardar último wallpaper
echo "$selected_path" > ~/.config/hypr/last_wallpaper.txt
