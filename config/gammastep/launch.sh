#!/bin/bash

# Check if gammastep-indicator is already running
if ! pgrep -x "gammastep" > /dev/null; then
    # Start gammastep-indicator if it's not running
    gammastep &
fi
