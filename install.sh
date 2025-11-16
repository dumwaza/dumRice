#!/bin/bash

# dumRice Installation Script
# Instala los dotfiles de Hyprland con backups automáticos

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_message() {
    echo -e "${BLUE}[dumRice]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Verificar que estamos en el directorio correcto
if [ ! -d ".config" ]; then
    print_error "Error: No se encuentra la carpeta .config"
    print_error "Por favor ejecuta este script desde el directorio dumRice"
    exit 1
fi

# Crear directorio de backups
BACKUP_DIR="$HOME/.config/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
print_message "Creando directorio de backup en: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Función para hacer backup y crear symlink
install_config() {
    local source="$1"
    local target="$2"
    
    # Si el target existe, hacer backup
    if [ -e "$target" ] || [ -L "$target" ]; then
        print_warning "Respaldando: $target"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    # Crear directorio padre si no existe
    mkdir -p "$(dirname "$target")"
    
    # Crear symlink
    ln -sf "$source" "$target"
    print_success "Instalado: $target"
}

print_message "Iniciando instalación de dumRice..."
echo ""

# Obtener el directorio actual (donde está el repo clonado)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Instalar configuraciones
print_message "Instalando configuraciones..."

# Hyprland
if [ -d "$DOTFILES_DIR/.config/hypr" ]; then
    install_config "$DOTFILES_DIR/.config/hypr" "$HOME/.config/hypr"
fi

# Waybar (si existe)
if [ -d "$DOTFILES_DIR/.config/waybar" ]; then
    install_config "$DOTFILES_DIR/.config/waybar" "$HOME/.config/waybar"
fi

# Kitty (si existe)
if [ -d "$DOTFILES_DIR/.config/kitty" ]; then
    install_config "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
fi

# Rofi (si existe)
if [ -d "$DOTFILES_DIR/.config/rofi" ]; then
    install_config "$DOTFILES_DIR/.config/rofi" "$HOME/.config/rofi"
fi

# Wofi (si existe)
if [ -d "$DOTFILES_DIR/.config/wofi" ]; then
    install_config "$DOTFILES_DIR/.config/wofi" "$HOME/.config/wofi"
fi

# Dunst (si existe)
if [ -d "$DOTFILES_DIR/.config/dunst" ]; then
    install_config "$DOTFILES_DIR/.config/dunst" "$HOME/.config/dunst"
fi

# Mako (si existe)
if [ -d "$DOTFILES_DIR/.config/mako" ]; then
    install_config "$DOTFILES_DIR/.config/mako" "$HOME/.config/mako"
fi

# Alacritty (si existe)
if [ -d "$DOTFILES_DIR/.config/alacritty" ]; then
    install_config "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
fi

# Foot (si existe)
if [ -d "$DOTFILES_DIR/.config/foot" ]; then
    install_config "$DOTFILES_DIR/.config/foot" "$HOME/.config/foot"
fi

# Copiar otros archivos de configuración si existen
for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        config_name=$(basename "$config_dir")
        # Solo instalar si no está en la lista de arriba (evitar duplicados)
        if [[ ! "$config_name" =~ ^(hypr|waybar|kitty|rofi|wofi|dunst|mako|alacritty|foot)$ ]]; then
            install_config "$config_dir" "$HOME/.config/$config_name"
        fi
    fi
done

# Scripts (si existe la carpeta)
if [ -d "$DOTFILES_DIR/scripts" ]; then
    print_message "Instalando scripts..."
    install_config "$DOTFILES_DIR/scripts" "$HOME/.local/bin/dumrice-scripts"
    
    # Hacer ejecutables todos los scripts
    chmod +x "$HOME/.local/bin/dumrice-scripts"/*
    print_success "Scripts instalados y marcados como ejecutables"
fi

echo ""
print_success "¡Instalación completada!"
echo ""
print_message "Tus configuraciones antiguas están respaldadas en:"
print_message "$BACKUP_DIR"
echo ""
print_message "Para aplicar los cambios:"
echo "  - Cierra sesión y vuelve a entrar, o"
echo "  - Recarga Hyprland con: hyprctl reload"
echo ""
print_warning "Si algo sale mal, puedes restaurar tus configs desde el backup"
echo ""
print_message "¡Disfruta tu rice! 🍚"
