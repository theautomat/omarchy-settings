#!/bin/bash

# Battery-based theme switcher for Omarchy
# Switches to "ugly" theme at 10% battery

BATTERY_THRESHOLD=10
UGLY_THEME="matte-black"
STATE_DIR="$HOME/.local/state/omarchy"
STATE_FILE="$STATE_DIR/battery-theme-state"
LOG_FILE="$STATE_DIR/battery-theme-switcher.log"

# Ensure state directory exists
mkdir -p "$STATE_DIR"

# Logging function
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

get_battery_percentage() {
  upower -i "$(upower -e | grep 'battery')" \
  | awk -F: '/percentage/ {
      gsub(/[%[:space:]]/, "", $2);
      val=$2;
      printf("%d\n", (val+0.5))
      exit
    }'
}

get_battery_state() {
  upower -i $(upower -e | grep 'battery') | grep -E "state" | awk '{print $2}'
}

get_current_theme() {
  basename "$(realpath "$HOME/.config/omarchy/current/theme")"
}

BATTERY_LEVEL=$(get_battery_percentage)
BATTERY_STATE=$(get_battery_state)
CURRENT_THEME=$(get_current_theme)

log "Battery: ${BATTERY_LEVEL}% (${BATTERY_STATE}), Current theme: ${CURRENT_THEME}"

# Battery is low and discharging - switch to ugly theme
if [[ "$BATTERY_STATE" == "discharging" && "$BATTERY_LEVEL" -le "$BATTERY_THRESHOLD" ]]; then
  if [[ ! -f "$STATE_FILE" ]]; then
    # Save current theme and switch
    echo "$CURRENT_THEME" > "$STATE_FILE"
    log "Battery low (${BATTERY_LEVEL}%), saving theme '${CURRENT_THEME}' and switching to '${UGLY_THEME}'"
    omarchy-theme-set "$UGLY_THEME"
  else
    log "Battery still low (${BATTERY_LEVEL}%), already on low-battery theme"
  fi
# Battery is above threshold - restore original theme
elif [[ "$BATTERY_LEVEL" -gt "$BATTERY_THRESHOLD" ]]; then
  if [[ -f "$STATE_FILE" ]]; then
    ORIGINAL_THEME=$(cat "$STATE_FILE")
    log "Battery recovered (${BATTERY_LEVEL}%), restoring theme '${ORIGINAL_THEME}'"
    omarchy-theme-set "$ORIGINAL_THEME"
    rm -f "$STATE_FILE"
  else
    log "Battery at ${BATTERY_LEVEL}%, no theme restoration needed"
  fi
fi
