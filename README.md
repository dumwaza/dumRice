# dumRice

Mi configuración personal de Hyprland - Un rice minimalista y funcional.

![Screenshot](screenshots/desktop.png)

## 📋 Características

- **Window Manager:** Hyprland
- **Status Bar:** Waybar
- **Terminal:** Kitty
- **Launcher:** Rofi
- **Wallpaper Manager:** swww
- **Notifications:** Dunst
- **Wallpaper Picker:** Script personalizado con miniaturas en Rofi

## 📦 Dependencias

### Obligatorias

```bash
sudo pacman -S hyprland waybar kitty rofi dunst \
               swww imagemagick \
               polkit-kde-agent qt5-wayland qt6-wayland \
               pipewire wireplumber xdg-desktop-portal-hyprland
```

### Utilidades adicionales

```bash
# Capturas de pantalla
sudo pacman -S grim slurp

# Bloqueo de pantalla
sudo pacman -S swaylock-effects

# Gestión de energía
sudo pacman -S brightnessctl playerctl
```

### Para otras distribuciones

**Fedora:**
```bash
sudo dnf install hyprland waybar kitty rofi dunst \
                 swww ImageMagick \
                 polkit-gnome pipewire wireplumber \
                 xdg-desktop-portal-hyprland
```

## 🚀 Instalación

### Actualizar el sistema

**IMPORTANTE:** Antes de instalar, actualiza tu sistema:

```bash
sudo pacman -Syu
```

### Instalación automática

```bash
git clone https://github.com/dumwaza/dumRice.git
cd dumRice
chmod +x install.sh
./install.sh
```

### Instalación manual

Si prefieres instalar manualmente:

```bash
# 1. Hacer backup de tus configs actuales
mkdir -p ~/.config/backup
cp -r ~/.config/hypr ~/.config/backup/ 2>/dev/null
cp -r ~/.config/waybar ~/.config/backup/ 2>/dev/null

# 2. Clonar el repositorio
git clone https://github.com/dumwaza/dumRice.git
cd dumRice

# 3. Copiar configuraciones
cp -r .config/hypr ~/.config/
cp -r .config/waybar ~/.config/
cp -r .config/wallpapers ~/.config/

# 4. Crear directorio de scripts y dar permisos
mkdir -p ~/.config/hypr/scripts
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x scripts/*.sh

# 5. Recargar Hyprland o reiniciar sesión
```

## ⌨️ Keybindings principales

### Ventanas

| Keybinding | Acción |
|------------|--------|
| `SUPER + Q` | Cerrar ventana |
| `SUPER + M` | Salir de Hyprland |
| `SUPER + E` | Abrir gestor de archivos |
| `SUPER + V` | Toggle ventana flotante |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + Return` | Abrir terminal |
| `SUPER + D` | Abrir launcher (rofi) |
| `SUPER + W` | 🎨 Selector de wallpapers |

### Navegación

| Keybinding | Acción |
|------------|--------|
| `SUPER + ←/→/↑/↓` | Cambiar foco |
| `SUPER + 1-9` | Cambiar a workspace |
| `SUPER + SHIFT + 1-9` | Mover ventana a workspace |
| `SUPER + Mouse` | Mover/Redimensionar ventana |

### Utilidades

| Keybinding | Acción |
|------------|--------|
| `SUPER + SHIFT + S` | Screenshot (área) |
| `Print` | Screenshot (pantalla completa) |
| `XF86AudioRaiseVolume` | Subir volumen |
| `XF86AudioLowerVolume` | Bajar volumen |
| `XF86AudioMute` | Mutear audio |

## 🎨 Wallpaper Picker

El wallpaper picker (`SUPER + W`) incluye:
- ✨ Vista previa con miniaturas en Rofi
- 💾 Persistencia del último wallpaper usado
- 🔄 Transiciones suaves con swww
- 🖼️ Generación automática de miniaturas con ImageMagick

### Agregar tus propios wallpapers

Simplemente copia tus imágenes a:
```bash
~/.config/wallpapers/
```

Los formatos soportados son: `.jpg`, `.png`, `.jpeg`

## 🔧 Personalización

### Cambiar wallpaper predeterminado

El último wallpaper seleccionado se guarda automáticamente y se restaura al iniciar sesión.

### Configurar Waybar

```bash
nano ~/.config/waybar/config.json  # Configuración
nano ~/.config/waybar/style.css     # Estilos
```

### Modificar keybindings

```bash
nano ~/.config/hypr/hyprland.conf
```

## 🔄 Actualizar

Para actualizar a la última versión:

```bash
cd dumRice
git pull
./install.sh
```

## 🐛 Solución de problemas

### El wallpaper picker no muestra imágenes

Asegúrate de tener ImageMagick instalado:
```bash
sudo pacman -S imagemagick
```

### El wallpaper no se aplica

Verifica que swww-daemon esté corriendo:
```bash
pgrep swww
```

Si no está corriendo, inicia manualmente:
```bash
swww-daemon &
```

### Verificar logs de Hyprland

```bash
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log
```

### Reiniciar waybar

```bash
killall waybar
waybar &
```

## 📁 Estructura del proyecto

```
dumRice/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   ├── hyprpaper.conf
│   │   └── scripts/
│   │       ├── wallpicker.sh
│   │       └── restore-wallpaper.sh
│   ├── waybar/
│   │   ├── config.json
│   │   └── style.css
│   └── wallpapers/
├── scripts/
│   ├── wallpicker.sh
│   └── restore-wallpaper.sh
├── screenshots/
├── install.sh
└── README.md
```

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si encuentras algún bug o tienes sugerencias:

1. Haz fork del proyecto
2. Crea una rama (`git checkout -b feature/mejora`)
3. Commit tus cambios (`git commit -am 'Agrega nueva característica'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

## 📝 Créditos

- Inspirado por la comunidad de r/unixporn
- Wallpapers de [wallhaven.cc](https://wallhaven.cc)

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de usar y modificar estas configuraciones.

## 📧 Contacto

- GitHub: [@dumwaza](https://github.com/dumwaza)

---

⭐ Si te gusta este rice, ¡dale una estrella al repo!

**Hecho con ❤️ y muchas horas de configuración**
