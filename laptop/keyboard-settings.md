# Keyboard Settings

## Keyboard Repeat Rate Configuration

**Date**: 2025-10-23

### Previous Settings
- `repeat_rate = 40` (characters per second)
- `repeat_delay = 600` (milliseconds before repeat starts)

### Current Settings (as of 2025-10-23)
- `repeat_rate = 50` (characters per second - 25% faster)
- `repeat_delay = 300` (milliseconds - 50% faster to start repeating)

### Changes Made
1. Updated `~/.config/hypr/input.conf` lines 9-10
2. Increased repeat_rate from 40 to 50 (25% faster)
3. Reduced repeat_delay from 600ms to 300ms (50% faster)
4. Reloaded configuration with `hyprctl reload`

### Configuration Location
File: `~/.config/hypr/input.conf`

### Rationale
- 600ms delay was too slow for comfortable navigation/editing, especially when holding backspace
- 300ms provides much faster response without accidental triggers
- 50 cps gives noticeably faster key repeat for arrows, backspace, delete, etc.
- Settings are conservative enough to avoid accidental repeats while typing normally

### Rollback Instructions
If the new settings feel too fast, edit `~/.config/hypr/input.conf` and restore previous values:
```conf
repeat_rate = 40
repeat_delay = 600
```
Then reload: `hyprctl reload`

### Testing
Hold down arrow keys, backspace, or any character key to test the new repeat behavior.
