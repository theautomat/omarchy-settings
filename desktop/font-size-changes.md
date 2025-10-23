# System Font Size Configuration Changes

**Date**: 2025-10-22

## Current Settings
- **UI Font**: Adwaita Sans 11
- **Document Font**: Adwaita Sans 12
- **Monospace Font**: Adwaita Mono 11

## New Settings
- **UI Font**: Adwaita Sans 14 (+3 points)
- **Document Font**: Adwaita Sans 15 (+3 points)
- **Monospace Font**: Adwaita Mono 14 (+3 points)

## Changes Made
Font sizes were increased by 3 points across the system using gsettings to improve readability.

## Command/Method
Font settings are managed via gsettings in the `org.gnome.desktop.interface` schema:

```bash
# Apply new font sizes
gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 14'
gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 15'
gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono 14'
```

## Rationale
Default font sizes (11pt) were too small for comfortable reading. Increasing by 3 points provides better visibility without making the UI feel oversized.

## Rollback Instructions
To restore original font sizes:

```bash
gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 11'
gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono 11'
```

## Notes
- Changes apply to GTK applications and most GUI apps in Omarchy
- Takes effect immediately (no restart required)
- Hyprland/Wayland native apps will pick up these settings
- Terminal font sizes may need separate configuration in terminal emulator settings
- This does not affect Hyprland window manager UI elements (bars, notifications)

## Verification
Check current settings with:
```bash
gsettings get org.gnome.desktop.interface font-name
gsettings get org.gnome.desktop.interface document-font-name
gsettings get org.gnome.desktop.interface monospace-font-name
```
