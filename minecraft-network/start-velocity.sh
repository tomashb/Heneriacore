#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/velocity"

screen -dmS velocity java -Xms512M -Xmx1G \
    -XX:+UseG1GC \
    -XX:G1HeapRegionSize=4M \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+ParallelRefProcEnabled \
    -XX:+AlwaysPreTouch \
    -XX:MaxInlineLevel=15 \
    -jar velocity.jar

cat <<MSG
Velocity started in screen session 'velocity'
Use 'screen -r velocity' to attach
MSG
