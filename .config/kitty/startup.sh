#           __                ____  _         
#      ____/ /_  ______ ___  / __ \(_)_______ 
#     / __  / / / / __ `__ \/ /_/ / / ___/ _ \
#    / /_/ / /_/ / / / / / / _, _/ / /__/  __/
#    \__,_/\__,_/_/ /_/ /_/_/ |_/_/\___/\___/ 
#                                             

#!/bin/bash

# Cuenta cuántas instancias de Kitty hay abiertas
kitty_count=$(pgrep -u "$USER" kitty | wc -l)

# Si solo existe este proceso (la primera ventana)
if [ "$kitty_count" -eq 1 ]; then
    clear
    sleep 0.2
    fastfetch
fi

# Inicia el shell normalmente
exec zsh   # o bash, según uses
