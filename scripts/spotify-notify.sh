#!/bin/bash

# Archivo temporal para carátula
art_path="/tmp/spotify-art.png"

# Escucha solo el evento de cambio de canción
playerctl -p spotify metadata --format '{{title}}|{{artist}}|{{mpris:artUrl}}' --follow | while IFS="|" read -r title artist art_url; do

    # Descarga la carátula solo si es URL HTTP
    if [[ $art_url == http* ]]; then
        wget -qO "$art_path" "$art_url"
    fi

    # Envía la notificación
    notify-send "🎵 $title" "$artist" -i "$art_path"

    # Espera un segundo para evitar múltiples notificaciones por un mismo cambio
    sleep 1
done
