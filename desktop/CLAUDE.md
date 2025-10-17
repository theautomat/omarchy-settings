# Claude Configuration for Omarchy

## About Omarchy
Omarchy is an Arch Linux-based desktop environment built on Hyprland (Wayland compositor). It provides a complete desktop experience with pre-configured applications and workflows.

## System Specifications
- **Hostname**: shade
- **CPU**: AMD Ryzen 9 8945HS w/ Radeon 780M Graphics (16 cores)
- **RAM**: 32GB (30Gi total, 4GB swap)
- **Architecture**: x86_64
- **Kernel**: Linux 6.16.7-arch1-1
- **OS**: Arch Linux
- **Display Server**: Wayland (Hyprland)

### Hardware Peripherals
- **Keyboard**: NuPhy Air60 V2 (USB)
- **Mouse**: Logitech G305 (wireless, USB receiver)

## Documentation
- **Main Manual**: https://learn.omacom.io/2/the-omarchy-manual
- **Configuration Philosophy**: Layer-based override system

## Key Configuration Locations

### Configuration Hierarchy (Order of precedence)
1. **System Defaults** (DO NOT EDIT): `~/.local/share/omarchy/default/hypr/`
2. **Theme Overrides**: `~/.config/omarchy/current/theme/hyprland.conf`
3. **User Customizations** (EDIT HERE): `~/.config/hypr/`

### Important User Config Files
- `~/.config/hypr/hyprland.conf` - Main config that sources all others
- `~/.config/hypr/bindings.conf` - Keyboard shortcuts and application bindings
- `~/.config/hypr/input.conf` - Mouse/keyboard behavior
- `~/.config/hypr/monitors.conf` - Display settings
- `~/.config/hypr/looknfeel.conf` - Visual appearance
- `~/.config/hypr/envs.conf` - Environment variables
- `~/.config/hypr/autostart.conf` - Apps that start automatically

### Omarchy Scripts Location
- `~/.local/share/omarchy/bin/` - Contains omarchy-* utility scripts

## Configuration Best Practices
1. **Always edit in `~/.config/hypr/`**, never in system defaults
2. **Comment your changes** with dates for documentation
3. **Keep original settings commented** for easy rollback
4. **Use the override system** - later configs override earlier ones
5. **Test changes** - Hyprland reloads configs automatically

## Common Tasks

### Application Bindings
- Edit `~/.config/hypr/bindings.conf`
- Use format: `bindd = KEY_COMBO, Description, exec, command`
- Variables can be defined at top: `$browser = uwsm app -- google-chrome-stable`

### Changing Default Apps
- Browser: Modify `$browser` variable in `bindings.conf`
- Terminal: Modify `$terminal` variable in `bindings.conf`
- Editor: Use `omarchy-launch-editor` or modify directly

### Key Binding Format
```
bindd = MODIFIER KEY, Description, exec, command
# Examples:
bindd = SUPER, B, Browser, exec, $browser
bindd = SUPER SHIFT, B, Browser (private), exec, $browser --incognito
```

### Available Modifiers
- `SUPER` - Windows/Cmd key
- `SHIFT` - Shift key
- `CTRL` - Control key
- `ALT` - Alt key

## Useful Commands
- `hyprctl reload` - Reload Hyprland config
- `omarchy-menu` - Open Omarchy menu
- `walker -p "Start…"` - App launcher
- `uwsm app -- <command>` - Launch apps through session manager

## Theme and Appearance
- Themes located in: `~/.config/omarchy/themes/`
- Current theme: `~/.config/omarchy/current/`
- Custom backgrounds: `~/.config/omarchy/[theme]/backgrounds/`

## Session Management
- Uses `uwsm` (Universal Wayland Session Manager)
- Launch apps with: `uwsm app -- <application>`
- This ensures proper session integration

## Debugging
- Hyprland logs: `journalctl -u uwsm@hyprland -f`
- Config validation: Check `hyprctl reload` output
- Test keybinds: Use `hyprctl dispatch` manually

## Notes for New Installations
- Omarchy comes pre-configured with sensible defaults
- Most customization should happen in `~/.config/hypr/` files
- The system is designed to be override-friendly
- Keep this file updated with your specific customizations