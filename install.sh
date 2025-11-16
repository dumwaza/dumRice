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

# Verificar que DOTFILES_DIR es válido
print_message "Directorio de dotfiles: $DOTFILES_DIR"
if [ ! -d "$DOTFILES_DIR/.config" ]; then
    print_error "Error: No se puede encontrar $DOTFILES_DIR/.config"
    exit 1
fi

# Instalar configuraciones
print_message "Instalando configuraciones..."

# Hyprland
if [ -d "$DOTFILES_DIR/.config/hypr" ]; then
    install_config "$DOTFILES_DIR/.config/hypr" "$HOME/.config/hypr"
    # Hacer ejecutables los scripts de Hyprland
    if [ -f "$HOME/.config/hypr/autostart.sh" ]; then
        chmod +x "$HOME/.config/hypr/autostart.sh"
        print_success "Permisos de ejecución aplicados a autostart.sh"
    fi
fi

# Waybar (si existe)
if [ -d "$DOTFILES_DIR/.config/waybar" ]; then
    install_config "$DOTFILES_DIR/.config/waybar" "$HOME/.config/waybar"
fi

# Kitty (si existe)
if [ -d "$DOTFILES_DIR/.config/kitty" ]; then
    install_config "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
    # Hacer ejecutable el startup.sh si existe
    if [ -f "$HOME/.config/kitty/startup.sh" ]; then
        chmod +x "$HOME/.config/kitty/startup.sh"
        print_success "Permisos de ejecución aplicados a startup.sh"
    fi
fi

# ===============================
#   GTK (Papirus Dark / Adwaita-dark)
# ===============================

print_message "Aplicando configuración GTK..."
mkdir -p "$HOME/.config/gtk-3.0"

# Instalar settings.ini si existe en el repo
if [ -f "$DOTFILES_DIR/.config/gtk-3.0/settings.ini" ]; then
    install_config "$DOTFILES_DIR/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
    print_success "GTK3 configurado correctamente"
else
    print_warning "No se encontró settings.ini en el repo"
fi

# Instalar .gtkrc-2.0 si existe
if [ -f "$DOTFILES_DIR/.gtkrc-2.0" ]; then
    install_config "$DOTFILES_DIR/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
    print_success "GTK2 configurado correctamente"
else
    print_warning "No se encontró .gtkrc-2.0 en el repo"
fi

# ===============================
#   Aplicar Papirus Dark automáticamente
# ===============================
if command -v gsettings &>/dev/null; then
    print_message "Aplicando Papirus Dark como tema GTK e íconos..."

    # Configura GTK3
    gsettings set org.gnome.desktop.interface gtk-theme "Papirus-Dark"
    gsettings set org.gnome.desktop.wm.preferences theme "Papirus-Dark"
    # Configura íconos
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

    print_success "Papirus Dark aplicado correctamente"
else
    print_warning "gsettings no encontrado, no se pudo aplicar Papirus Dark automáticamente"
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

# Scripts personales
if [ -d "$DOTFILES_DIR/scripts" ]; then
    print_message "Instalando scripts personales..."
    mkdir -p "$HOME/.local/bin"
    
    for script in "$DOTFILES_DIR/scripts"/*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            # Hacer backup si existe
            if [ -f "$HOME/.local/bin/$script_name" ]; then
                print_warning "Respaldando: $HOME/.local/bin/$script_name"
                mv "$HOME/.local/bin/$script_name" "$BACKUP_DIR/"
            fi
            # Copiar script
            cp "$script" "$HOME/.local/bin/$script_name"
            chmod +x "$HOME/.local/bin/$script_name"
            print_success "Script instalado: $script_name"
        fi
    done
fi

# ===============================
#         Wallpapers
# ===============================
if [ -d "$DOTFILES_DIR/.config/wallpapers" ]; then
    print_message "Instalando wallpapers..."

    # Crear directorio de destino
    mkdir -p "$HOME/.config/wallpapers"

    # Copiar solo archivos de imagen, ignorando el directorio thumbs
    find "$DOTFILES_DIR/.config/wallpapers" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) \
        -exec cp {} "$HOME/.config/wallpapers/" \;

    # Ajustar permisos
    chmod -R u+rwX,go+rX "$HOME/.config/wallpapers"

    print_success "Wallpapers instalados correctamente en ~/.config/wallpapers"
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
