#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
    printf "%s\n" "$1"
}

log "🚀 Démarrage du réseau Minecraft..."

log "📡 Démarrage Velocity Proxy..."
"$SCRIPT_DIR/start-velocity.sh"
sleep 5

log "🔐 Démarrage Auth Server..."
"$SCRIPT_DIR/start-server.sh" auth 25566 1
sleep 3

log "🏠 Démarrage Lobbies..."
"$SCRIPT_DIR/start-server.sh" lobby-1 25567 2
"$SCRIPT_DIR/start-server.sh" lobby-2 25568 2
"$SCRIPT_DIR/start-server.sh" lobby-3 25569 2
sleep 3

log "🎮 Démarrage serveurs Bedwars..."
"$SCRIPT_DIR/start-server.sh" bedwars-1 25570 3
"$SCRIPT_DIR/start-server.sh" bedwars-2 25571 3

log "🎮 Démarrage serveurs Nexus..."
"$SCRIPT_DIR/start-server.sh" nexus-1 25572 3
"$SCRIPT_DIR/start-server.sh" nexus-2 25573 3

log "🎮 Démarrage serveurs Zombie..."
"$SCRIPT_DIR/start-server.sh" zombie-1 25574 3
"$SCRIPT_DIR/start-server.sh" zombie-2 25575 3

log ""
log "✅ Tous les serveurs démarrés!"
log "📋 Liste des sessions screen:"
screen -ls || true
log ""
log "💡 Pour accéder à un serveur: screen -r <nom>"
log "💡 Pour se détacher: CTRL+A puis D"
