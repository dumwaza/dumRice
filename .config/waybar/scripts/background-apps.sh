#!/bin/bash

# icono:proceso
apps=(
    ":Discord"
    ":steam"
    ":telegram-desktop"
)

icons=""
tooltip=""

for entry in "${apps[@]}"; do
    icon="${entry%%:*}"
    process="${entry##*:}"

    if pgrep -f "$process" > /dev/null; then
        icons+=" $icon"
        tooltip+=" - $process\n"
    fi
done

if [ -z "$icons" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"No hay apps en segundo plano\"}"
else
    echo "{\"text\": \"$icons\", \"tooltip\": \"Apps abiertas:\n$tooltip\"}"
fi
