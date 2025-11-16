# 🍚 dumRice

Mi configuración personal de Hyprland - Un rice minimalista y funcional.

## 📸 Screenshots

![Screenshot 1](screenshots/desktop.png)
![Screenshot 2](screenshots/terminal.png)

> **Nota:** Agrega tus capturas de pantalla en la carpeta `screenshots/`

## ✨ Características

- **Window Manager:** Hyprland
- **Status Bar:** Waybar
- **Terminal:** [Tu terminal aquí]
- **Launcher:** [Rofi/Wofi]
- **Notifications:** [Dunst/Mako]
- **Theme:** [Tu tema]
- **Font:** [Tu fuente]

## 📦 Dependencias

### Arch Linux / Manjaro

```bash
# ESENCIAL - Sin esto no funcionará
sudo pacman -S swww

# Básicas
sudo pacman -S hyprland waybar kitty rofi dunst

# Multimedia y utilidades
sudo pacman -S playerctl imagemagick
```

### Dependencias opcionales

```bash
# Capturas de pantalla
sudo pacman -S grim slurp

# Wallpapers
sudo pacman -S swaybg hyprpaper

# Bloqueo de pantalla
sudo pacman -S swaylock-effects

# Gestión de energía
sudo pacman -S brightnessctl playerctl
```

## 🚀 Instalación

### Instalación rápida

```bash
git clone https://github.com/dumwaza/dumRice.git
cd dumRice
chmod +x install.sh
./install.sh
```

### Instalación manual

Si prefieres instalar manualmente:

```bash
# Hacer backup de tus configs actuales
mkdir -p ~/.config/backup
cp -r ~/.config/hypr ~/.config/backup/
cp -r ~/.config/waybar ~/.config/backup/

# Clonar el repositorio
git clone https://github.com/dumwaza/dumRice.git

# Crear symlinks
ln -sf ~/dumRice/.config/hypr ~/.config/hypr
ln -sf ~/dumRice/.config/waybar ~/.config/waybar
# Repite para otras configuraciones...
```

## ⌨️ Keybindings

### Básicos

| Keybinding | Acción |
|------------|--------|
| `SUPER + Q` | Cerrar ventana |
| `SUPER + M` | Salir de Hyprland |
| `SUPER + E` | Abrir gestor de archivos |
| `SUPER + V` | Toggle ventana flotante |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + Return` | Abrir terminal |
| `SUPER + D` | Abrir launcher (rofi) |

### Navegación

| Keybinding | Acción |
|------------|--------|
| `SUPER + ←/→/↑/↓` | Cambiar foco |
| `SUPER + 1-9` | Cambiar a workspace |
| `SUPER + SHIFT + 1-9` | Mover ventana a workspace |
| `SUPER + Mouse` | Mover/Redimensionar ventana |

### Multimedia

| Keybinding | Acción |
|------------|--------|
| `SUPER + SHIFT + S` | Screenshot (área) |
| `Print` | Screenshot (pantalla completa) |
| `XF86AudioRaiseVolume` | Subir volumen |
| `XF86AudioLowerVolume` | Bajar volumen |
| `XF86AudioMute` | Mutear audio |

> **Nota:** Revisa `~/.config/hypr/hyprland.conf` para ver todos los keybindings

## 🎨 Personalización

### Cambiar wallpaper

```bash
# Edita el archivo de Hyprland
nano ~/.config/hypr/hyprland.conf

# Busca la línea:
exec-once = swaybg -i ~/wallpaper.jpg

# Cambia la ruta a tu wallpaper
```

### Modificar Waybar

```bash
# Edita la configuración
nano ~/.config/waybar/config.json

# Edita los estilos
nano ~/.config/waybar/style.css
```

## 🔄 Actualizar

Para actualizar a la última versión:

```bash
cd dumRice
git pull
./install.sh
```

## 🐛 Troubleshooting

### Hyprland no inicia

```bash
# Verifica los logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

# O inicia desde TTY para ver errores
Hyprland
```

### Waybar no aparece

```bash
# Reinicia waybar
killall waybar
waybar &
```

### Problemas con el cursor

```bash
# Agrega a hyprland.conf
env = XCURSOR_SIZE,24
```

## 📁 Estructura del repositorio

```
dumRice/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   └── hyprpaper.conf
│   ├── waybar/
│   │   ├── config.json
│   │   └── style.css
│   └── ...
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

- Inspirado en [otros rices si aplica]
- Wallpapers de [fuente]
- Tema basado en [nombre del tema]

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de usar y modificar estas configuraciones.

## 💬 Contacto

- GitHub: [@dumwaza](https://github.com/dumwaza)

---

⭐ Si te gusta este rice, dale una estrella al repo!

**Hecho con ❤️ y muchas horas de configuración**
