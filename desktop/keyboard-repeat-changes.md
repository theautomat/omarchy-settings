# Keyboard Repeat Rate Configuration Changes

**Date**: 2025-09-29

## Current Settings
- `repeat_rate = 40` (characters per second)
- `repeat_delay = 600` (milliseconds before repeat starts)

## New Settings
- `repeat_rate = 50` (characters per second - faster typing)
- `repeat_delay = 250` (milliseconds - quicker to start repeating)

## Changes Made
1. Updated `~/.config/hypr/input.conf` lines 10-11
2. Added comments with old values for easy rollback
3. Hyprland will auto-reload the configuration

## Rationale
- 600ms delay is too slow for comfortable navigation/editing
- 250ms provides near-instant repeat without accidental triggers
- 50 cps gives noticeably faster key repeat for arrows, backspace, etc.

## Rollback Instructions
If the new settings feel too fast, edit `~/.config/hypr/input.conf` and restore:
```conf
repeat_rate = 40
repeat_delay = 600
```

## Testing
Hold down arrow keys, backspace, or any character key to test the new repeat behavior.