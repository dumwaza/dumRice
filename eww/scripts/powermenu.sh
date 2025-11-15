#!/bin/bash

# Opciones
option1=" Lock"
option2=" Logout"
option3=" Suspend"
option4=" Reboot"
option5=" Shutdown"

options="$option1\n$option2\n$option3\n$option4\n$option5"

# Usa tu tema de rofi
choice=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/powermenu.rasi)

case $choice in
    $option1)
        hyprlock ;;
    $option2)
        hyprctl dispatch exit ;;
    $option3)
        systemctl suspend ;;
    $option4)
        systemctl reboot ;;
    $option5)
        systemctl poweroff ;;
esac
