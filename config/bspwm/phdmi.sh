#!/bin/bash

# Define variables
HDMI_MONITOR="HDMI-1"
PRIMARY_MONITOR="eDP-1"
HDMI_WORKSPACES=("I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")

# Function to move all workspaces to a monitor
move_all_workspaces_to_monitor() {
  local source_monitor=$1
  local target_monitor=$2

  # Get all desktops assigned to the source monitor
  desktops=$(bspc query -D -m "$source_monitor" --names)

  for desktop in $desktops; do
    bspc desktop "$desktop" --to-monitor "$target_monitor"
  done
}

# Function to clean up default desktops
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
  # Set HDMI as primary and disable the eDP monitor
  xrandr --output "$HDMI_MONITOR" --primary --mode 1920x1080 --output "$PRIMARY_MONITOR" --off
  
  # Move all workspaces to the HDMI monitor
  move_all_workspaces_to_monitor "$PRIMARY_MONITOR" "$HDMI_MONITOR"

  # Force BSPWM to forget about the eDP monitor
  bspc monitor "$PRIMARY_MONITOR" --remove

  # Ensure HDMI workspaces exist
  for ws in "${HDMI_WORKSPACES[@]}"; do
    if ! bspc query -D --names | grep -q "^$ws$"; then
      bspc monitor "$HDMI_MONITOR" -a "$ws"
    fi
  done

  # Clean up any wild desktops
  cleanup_default_desktops "$HDMI_MONITOR" HDMI_WORKSPACES[@]

else
  echo "No HDMI monitor detected."
fi
