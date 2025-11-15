#!/bin/bash

# Lista de procesos (nombre del proceso : nombre legible)
apps=(
    "Discord:discord"
    "steam:steam"
    "telegram-desktop:telegram"
)

output=""
tooltip=""

for entry in "${apps[@]}"; do
    pname="${entry%%:*}"   # Process name (para pgrep)
    label="${entry##*:}"   # Label visible en la barra

    if pgrep -f "$pname" > /dev/null; then
        output+="$label "
        tooltip+=" - $label\n"
    fi
done

if [ -z "$output" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"No hay apps en segundo plano\"}"
else
    echo "{\"text\": \" $output\", \"tooltip\": \"Apps abiertas:\n$tooltip\"}"
fi
