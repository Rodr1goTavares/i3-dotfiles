#!/bin/bash

# Colors for clarity
GREEN='\033[0;32m'
NC='\033[0m'

# Kill existing Polybar instances
echo -e "${GREEN}Killing existing Polybar instances...${NC}"
killall -q polybar

# Wait until Polybar has been shut down
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Detect primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " primary" | cut -d" " -f1)

if [ -z "$PRIMARY_MONITOR" ]; then
    echo -e "${RED}❌ Could not detect the primary monitor.${NC}"
    exit 1
fi

echo -e "${GREEN}Launching Polybar on primary monitor: $PRIMARY_MONITOR${NC}"

# Launch Polybar with MONITOR env variable
MONITOR=$PRIMARY_MONITOR polybar example &

echo -e "${GREEN}✅ Polybar launched on $PRIMARY_MONITOR.${NC}"

