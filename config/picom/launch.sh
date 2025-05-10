#!/bin/bash

# Check if picom is already running
if ! pgrep -x "picom" > /dev/null; then
    # Start picom if it's not running
    picom &
fi
