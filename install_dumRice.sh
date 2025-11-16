#!/bin/bash
# =========================
# Instalador seguro de dumRice v4
# =========================

set -e

echo "🛡️  Instalador seguro de dumRice iniciado"

# 1️⃣ Respaldar ~/.config actual
BACKUP_DIR="$HOME/.config.backup_$(date +%s)"
if [ -d "$HOME/.config" ]; then
    echo "📦 Respaldando tu configuración actual en $BACKUP_DIR..."
    mv "$HOME/.config" "$BACKUP_DIR"
fi

# 2️⃣ Crear ~/.config si no existe
mkdir -p "$HOME/.config"

# 3️⃣ Copiar todas las configuraciones del dumRice
echo "📂 Copiando configuraciones del dumRice..."
for DIR in hypr waybar eww kitty rofi dunst powerlevel10k rofi-blurry-powermenu wallpapers; do
    if [ -d "./$DIR" ]; then
        cp -r "./$DIR" "$HOME/.config/"
        echo "✅ Copiado: $DIR"
    fi
done

# 4️⃣ Ajustar permisos de todos los scripts .sh
echo "🔧 Ajustando permisos de ejecución en scripts..."
find "$HOME/.config" -type f -name "*.sh" -exec chmod +x {} \;

# 5️⃣ Asegurar permisos de lectura/ejecución en carpetas importantes
echo "🔒 Ajustando permisos de carpetas..."
chmod -R 755 "$HOME/.config/hypr"
chmod -R 755 "$HOME/.config/waybar"
chmod -R 755 "$HOME/.config/eww"
chmod -R 755 "$HOME/.config/kitty"
chmod -R 755 "$HOME/.config/rofi"
chmod -R 755 "$HOME/.config/dunst"
chmod -R 755 "$HOME/.config/wallpapers"

# 6️⃣ Verificar y arreglar rutas de wallpapers
if [ -d "$HOME/.config/wallpapers" ]; then
    echo "🔄 Ajustando rutas de wallpapers a \$HOME..."
    find "$HOME/.config/wallpapers" -type f -exec sed -i "s|/home/rice|$HOME|g" {} \;
fi

# 7️⃣ Comprobar dependencias básicas
DEPENDENCIAS=(hyprland waybar eww kitty rofi dunst git feh)
echo "🔍 Comprobando dependencias..."
MISSING=()
for PKG in "${DEPENDENCIAS[@]}"; do
    if ! command -v $PKG &>/dev/null; then
        MISSING+=($PKG)
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "⚠️  Faltan las siguientes dependencias: ${MISSING[@]}"
    echo "Instálalas con: sudo pacman -S ${MISSING[@]}"
else
    echo "✅ Todas las dependencias están instaladas"
fi

echo "🎉 dumRice instalado correctamente!"
echo "Si quieres volver a tu configuración anterior, la encontrarás en: $BACKUP_DIR"
