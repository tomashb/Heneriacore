#!/bin/bash
set -euo pipefail

SERVERS=(velocity auth lobby-1 lobby-2 lobby-3 bedwars-1 bedwars-2 nexus-1 nexus-2 zombie-1 zombie-2)

echo "🛑 Arrêt de tous les serveurs..."

for SERVER in "${SERVERS[@]}"; do
    if screen -list | grep -q "$SERVER"; then
        echo "Arrêt de $SERVER..."
        screen -S "$SERVER" -X stuff "stop\n"
        sleep 2
    fi

done

echo "✅ Tous les serveurs arrêtés!"
