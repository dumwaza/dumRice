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
CONFIG_DIRS=(hypr waybar eww kitty rofi dunst powerlevel10k rofi-blurry-powermenu wallpapers)
for DIR in "${CONFIG_DIRS[@]}"; do
    if [ -d "./$DIR" ]; then
        cp -r "./$DIR" "$HOME/.config/"
        echo "✅ Copiado: $DIR"
    fi
done

# 4️⃣ Ajustar permisos de ejecución a scripts .sh
echo "🔧 Ajustando permisos de ejecución..."
find "$HOME/.config" -type f -name "*.sh" -exec chmod +x {} \;

# 5️⃣ Ajustar permisos de carpetas importantes
echo "🔒 Ajustando permisos de carpetas..."
for DIR in "${CONFIG_DIRS[@]}"; do
    if [ -d "$HOME/.config/$DIR" ]; then
        chmod -R 755 "$HOME/.config/$DIR"
    fi
done

# 6️⃣ Asegurar que Kitty tenga permisos correctos
if [ -f "$HOME/.config/kitty/startup.sh" ]; then
    chmod +x "$HOME/.config/kitty/startup.sh"
fi

# 7️⃣ Comprobar dependencias básicas
DEPENDENCIAS=(hyprland waybar eww kitty rofi dunst git)
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

# 8️⃣ Mensaje final
echo "🎉 dumRice instalado correctamente!"
echo "Si quieres volver a tu configuración anterior, la encontrarás en: $BACKUP_DIR"
