# Monitor Scaling Configuration for 27" 4K Display

**Date**: 2025-10-22

## Hardware
- **Monitor**: Dell S2725QS 27" 4K
- **Resolution**: 3840x2160 @ 60Hz
- **PPI**: ~163 (pixels per inch)

## Problem
Omarchy defaults are optimized for high-PPI retina-class displays (218+ PPI), such as 27" 5K or 32" 6K monitors. On standard 27" 4K displays (~163 PPI), this causes fonts and UI elements to appear too small.

## Original Settings
```bash
env = GDK_SCALE,2
monitor=,preferred,auto,auto
```
- Optimized for: 27" 5K, 32" 6K, 13" 2.8K displays
- Not ideal for: 27" or 32" 4K displays

## New Settings
```bash
env = GDK_SCALE,2
monitor=,preferred,auto,2
```
- Uses full 2x scaling (200% of native resolution)
- Larger than typical 27" 4K recommendations but provides better readability
- Integer scaling (no fractional scaling artifacts)

## Changes Made
**File**: `~/.config/hypr/monitors.conf`

1. **Line 7**: Commented out original `env = GDK_SCALE,2` with change date
2. **Line 8**: Commented out original `monitor=,preferred,auto,auto` with change date
3. **Lines 13-14**: Set to full 2x scaling for better readability
   - Initially tried 1.75/1.666667 (typical 27" 4K recommendation)
   - Increased to 2/2 for larger, more comfortable UI

**Method**: Direct edit of monitors.conf file

## Rationale
- GDK_SCALE affects GTK application scaling
- Monitor scale (2) affects Hyprland/Wayland compositor scaling
- Integer scaling (2x) provides crisp rendering without fractional artifacts
- Scales all UI elements proportionally (fonts, icons, buttons, etc.)
- Prioritizes readability over screen real estate

## Application Instructions
⚠️ **Important**: Changes to `env` variables require a Hyprland relaunch:

1. Press `Super + Esc` to open Omarchy power menu
2. Select **"Relaunch"** (not restart/logout)
3. Hyprland will restart with new scaling settings
4. All apps and windows will preserve their state

## Rollback Instructions

### To restore original auto-detect settings:
Edit `~/.config/hypr/monitors.conf`:

```bash
# Re-enable original auto-detect
env = GDK_SCALE,2
monitor=,preferred,auto,auto

# Comment out manual 2x scaling
# env = GDK_SCALE,2
# monitor=,preferred,auto,2
```

### For smaller UI (typical 27" 4K recommendation):
```bash
env = GDK_SCALE,1.75
monitor=,preferred,auto,1.666667
```

Then relaunch Hyprland (Super + Esc → Relaunch).

## Notes
- **Theme Independence**: Scaling settings persist across all theme switches
- **Integer Scaling**: Uses clean 2x scaling (same as retina displays)
- **Performance**: Integer scaling provides best performance and crispest rendering
- **Compatibility**: Works with all Wayland-native and GTK applications
- **Alternative**: For smaller UI with more screen space, try 1.75/1.666667 scaling
- **1080p/1440p displays**: Use `GDK_SCALE=1` and `monitor=,preferred,auto,1`

## Documentation Reference
- Omarchy Manual: https://learn.omacom.io/2/the-omarchy-manual (Monitor Resolution section)
- Hyprland Monitors: https://wiki.hyprland.org/Configuring/Monitors/
- Default config: `~/.local/share/omarchy/config/hypr/monitors.conf`

## Verification
Check current monitor configuration:
```bash
hyprctl monitors
# Look for "scale: 2.00" to confirm proper scaling

echo $GDK_SCALE
# Should output: 2
```
