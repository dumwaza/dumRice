#!/usr/bin/env bash

## Rofi Power Menu Script

# Opciones del menú
shutdown='⏻' 
reboot=''
lock=''
suspend=''
logout=''

# Mostrar el menú con rofi
chosen=$(echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$logout" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/powermenu.rasi)

# Ejecutar la acción seleccionada
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        # Cambia esto según tu lock screen (hyprlock, swaylock, etc.)
        hyprlock
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac

# Version con texto
# Opciones del menú
#shutdown='⏻  Apagar' 
#reboot='  Reiniciar'
#lock='  Bloquear'
#suspend='  Suspender'
#logout='  Cerrar sesion'
