#!/bin/bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
    echo "Usage: $0 <server-name> <port> <ram-gb>" >&2
    exit 1
fi

SERVER_NAME=$1
PORT=$2
RAM=$3

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER_DIR="$SCRIPT_DIR/$SERVER_NAME"

if [[ ! -d "$SERVER_DIR" ]]; then
    echo "Server directory '$SERVER_DIR' does not exist" >&2
    exit 1
fi

cd "$SERVER_DIR"

screen -dmS "$SERVER_NAME" java -Xms${RAM}G -Xmx${RAM}G \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+DisableExplicitGC \
    -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 \
    -XX:G1MaxNewSizePercent=40 \
    -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 \
    -XX:G1HeapWastePercent=5 \
    -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 \
    -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 \
    -XX:SurvivorRatio=32 \
    -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 \
    -jar paper.jar --nogui

printf "%s started in screen session on port %s with %sGB RAM\n" "$SERVER_NAME" "$PORT" "$RAM"
