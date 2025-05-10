#!/bin/bash

# Kill existing Polybar instances
if pgrep -u $UID -x polybar >/dev/null; then
    pkill polybar
    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done
fi

sleep 0.8
# Launch bars for eDP-1
if xrandr --query | grep -q "eDP-1 connected"; then
    MONITOR=eDP-1 polybar --reload --config="$HOME/.config/bspwm/polybar/config.ini" edp &
    sleep 0.1
fi

# Launch bar for HDMI-1
if xrandr --query | grep -q "HDMI-1 connected"; then
    MONITOR=HDMI-1 polybar --reload --config="$HOME/.config/bspwm/polybar/config.ini" hdmi &
    sleep 0.1
fi

