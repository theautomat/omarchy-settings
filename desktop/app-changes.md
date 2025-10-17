# Omarchy Application Changes Log

This file tracks all modifications made to the Omarchy setup for easy replication on new installations.

## Format
Each entry should include:
- **Date**: When the change was made
- **Component**: What was modified (bindings, theme, etc.)
- **Change**: What was changed
- **File(s)**: Which files were modified
- **Command/Method**: How to replicate the change
- **Notes**: Any additional context or gotchas

---

## Change Log

### 2025-09-28 - Browser Change from Chromium to Google Chrome

**Component**: Application Installation + Bindings
**Change**: Installed Google Chrome and changed default browser from Chromium (via omarchy-launch-browser) to Google Chrome
**File(s)**: `~/.config/hypr/bindings.conf`

**Installation Step**:
1. Open Omarchy Menu (`Super + Alt + Space`)
2. Go to Install → AUR
3. Type `google-chrome` and press Enter
4. Wait for installation to complete

**Changes Made**:
1. Line 3: `$browser = omarchy-launch-browser` → `$browser = uwsm app -- google-chrome-stable`
2. Line 9-10: `--private` → `--incognito` for private browsing

**Original Settings** (commented out with date):
```bash
# $browser = omarchy-launch-browser  # original chromium setting - changed 2025-09-28
# bindd = SUPER SHIFT, B, Browser (private), exec, $browser --private  # original chromium setting - changed 2025-09-28
```

**Method**: Direct edit of bindings.conf file
**Key Bindings Affected**:
- `Super + B` - Opens Google Chrome
- `Super + Shift + B` - Opens Google Chrome in incognito mode

**Notes**:
- Avoided system-wide changes by using Hyprland bindings directly
- Preserved original settings as comments for easy rollback
- Uses `uwsm app --` prefix for proper session management
- Chrome uses `--incognito` flag vs Firefox/Chromium's `--private`

---

## Quick Reference for New Installs

### Essential Files to Backup/Replicate
- `~/.config/hypr/bindings.conf` - Application shortcuts
- `~/.config/hypr/input.conf` - Input device settings
- `~/.config/hypr/monitors.conf` - Display configuration
- `~/.config/hypr/looknfeel.conf` - Visual customizations

### Standard Workflow for Changes
1. Edit files in `~/.config/hypr/` (never system defaults)
2. Comment original settings with change date
3. Document change in this file
4. Test that keybindings work as expected
5. No restart needed - Hyprland reloads automatically