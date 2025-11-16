#!/bin/bash

# ============================
#   Instalador seguro dumRice
# ============================

echo "🛡️  Instalador seguro de dumRice iniciado"

# --- Paso 1: Crear backup de la configuración actual ---
BACKUP_DIR="$HOME/.config.backup_$(date +%s)"
echo "📦 Respaldando configuración actual en $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"
cp -r "$HOME/.config"/* "$BACKUP_DIR"

# --- Paso 2: Copiar dumRice ---
echo "📂 Copiando configuraciones de dumRice..."
FOLDERS=("hypr" "waybar" "eww" "kitty" "rofi" "dunst" "powerlevel10k" "rofi-blurry-powermenu" "wallpapers")

for folder in "${FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        cp -r "$folder" "$HOME/.config/"
        echo "✅ Copiado: $folder"
    else
        echo "⚠️  Carpeta no encontrada: $folder"
    fi
done

# --- Paso 3: Ajustar permisos de scripts ---
echo "🔧 Ajustando permisos de scripts..."
find "$HOME/.config/kitty" -type f -name "*.sh" -exec chmod +x {} \;
find "$HOME/.config/rofi" -type f -name "*.sh" -exec chmod +x {} \;
find "$HOME/.config/eww" -type f -name "*.sh" -exec chmod +x {} \;

# --- Paso 4: Comprobar dependencias ---
echo "🔍 Comprobando dependencias..."
DEPENDENCIES=("hyprland" "kitty" "waybar" "eww" "rofi" "dunst")

for dep in "${DEPENDENCIES[@]}"; do
    if ! command -v $dep &> /dev/null; then
        echo "⚠️  $dep no está instalado"
    else
        echo "✅ $dep instalado"
    fi
done

# --- Paso 5: Mensaje final ---
echo "🎉 dumRice instalado correctamente!"
echo "Si quieres restaurar tu configuración anterior, está en: $BACKUP_DIR"
