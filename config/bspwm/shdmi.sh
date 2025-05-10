#!/bin/bash

# Define variables
HDMI_MONITOR="HDMI-1"
PRIMARY_MONITOR="eDP-1"
EDP_WORKSPACES=("I" "II" "III" "IV" "V" "VI")
HDMI_WORKSPACES=("VII" "VIII" "IX" "X")

# Function to create and move workspaces
create_and_move_workspaces() {
  local monitor=$1
  shift
  for ws in "$@"; do
    if ! bspc query -D --names | grep -q "^$ws$"; then
      bspc monitor "$monitor" -a "$ws"
    else
      bspc desktop "$ws" --to-monitor "$monitor"
    fi
  done
}

# Function to move all workspaces from a monitor to another
move_all_workspaces_to_monitor() {
  local source_monitor=$1
  local target_monitor=$2

  # Get all desktops assigned to the source monitor
  desktops=$(bspc query -D -m "$source_monitor" --names)

  for desktop in $desktops; do
    bspc desktop "$desktop" --to-monitor "$target_monitor"
  done
}

# Function to clean up any wild/default desktops
cleanup_default_desktops() {
  local monitor=$1
  local valid_workspaces=("${!2}")
  
  # Get all desktops on the monitor
  current_desktops=$(bspc query -D -m "$monitor" --names)

  for desktop in $current_desktops; do
    if [[ ! " ${valid_workspaces[*]} " =~ " $desktop " ]]; then
      # If the desktop is not in the valid workspaces list, remove it
      bspc desktop "$desktop" --remove
    fi
  done
}

# Detect HDMI connection status
if xrandr | grep -q "^$HDMI_MONITOR connected"; then
  # HDMI is connected
  xrandr --output "$HDMI_MONITOR" --mode 1920x1080 --right-of "$PRIMARY_MONITOR"
  
  # Ensure eDP-1 workspaces exist
  create_and_move_workspaces "$PRIMARY_MONITOR" "${EDP_WORKSPACES[@]}"
  
  # Create and move HDMI workspaces to HDMI-1
  create_and_move_workspaces "$HDMI_MONITOR" "${HDMI_WORKSPACES[@]}"
  
  # Clean up wild desktops on HDMI-1
  cleanup_default_desktops "$HDMI_MONITOR" HDMI_WORKSPACES[@]
else
  # HDMI is disconnected
  xrandr --output "$HDMI_MONITOR" --off
  
  # Move all workspaces from HDMI monitor to eDP-1
  move_all_workspaces_to_monitor "$HDMI_MONITOR" "$PRIMARY_MONITOR"
  
  # Force bspwm to forget about the HDMI monitor
  bspc monitor "$HDMI_MONITOR" --remove
  
  # Ensure eDP-1 workspaces exist
  create_and_move_workspaces "$PRIMARY_MONITOR" "${EDP_WORKSPACES[@]}"
  
  # Clean up any wild desktops on eDP-1
  cleanup_default_desktops "$PRIMARY_MONITOR" EDP_WORKSPACES[@]
fi

