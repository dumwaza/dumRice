#!/bin/bash

# ===============================
#      Instalador definitivo
#          dumRice
# ===============================

# Cambiar al home
cd ~

# 1️⃣ Comprobar si git está instalado
if ! command -v git &>/dev/null; then
    echo "Git no está instalado. Instalando..."
    sudo pacman -S git --noconfirm
fi

# 2️⃣ Clonar el repo si no existe o actualizar si ya existe
if [ -d "dumRice" ]; then
    echo "dumRice ya existe, actualizando..."
    cd dumRice
    git pull
    cd ..
else
    echo "Clonando dumRice desde GitHub..."
    git clone https://github.com/dumwaza/dumRice.git
fi

# 3️⃣ Instalar dependencias necesarias
echo "Instalando dependencias necesarias..."
sudo pacman -S --needed --noconfirm hyprland waybar eww kitty rofi dunst

# 4️⃣ Respaldar configuraciones actuales
echo "Respaldando configuraciones existentes..."
for dir in hypr waybar eww kitty rofi dunst powerlevel10k rofi-blurry-powermenu wallpapers; do
    if [ -d "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$HOME/.config/${dir}.bak_$(date +%Y%m%d_%H%M%S)"
        echo "Respaldo de $dir creado."
    fi
done

# 5️⃣ Copiar la configuración del dumRice
echo "Copiando configuraciones de dumRice..."
for dir in hypr waybar eww kitty rofi dunst powerlevel10k rofi-blurry-powermenu wallpapers; do
    if [ -d "$HOME/dumRice/$dir" ]; then
        cp -r "$HOME/dumRice/$dir" "$HOME/.config/"
        echo "$dir copiado a ~/.config"
    fi
done

# 6️⃣ Mensaje final
echo ""
echo "✅ dumRice instalado correctamente."
echo "Si todo salió bien, reinicia Hyprland o tu sesión para ver tu rice activo."
