#!/bin/bash

# Check if picom is already running
if ! pgrep -x "pipewire" > /dev/null; then
    # Start pipewire if it's not running
    pipewire &
fi
