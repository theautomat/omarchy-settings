# Laptop Configuration (Asahi)

Omarchy customizations for Apple Silicon laptop running Asahi Linux.

## Machine Specifications

- **Base**: Arch Linux ARM on Apple Silicon (Asahi Linux kernel)
- **Custom layer**: Omarchy installed on top of base Arch
- **Hardware**: Apple Silicon (ARM64)
- **Display Server**: Wayland (Hyprland)

## Configuration Files

- **keyboard-settings.md** - Keyboard repeat rate customizations
- **touchpad-settings.md** - Touchpad behavior settings
- **backlight-keyboard.md** - Keyboard backlight configuration notes
- **backlight-effects.sh** - Script for keyboard backlight effects
- **battery-theme-switcher/** - Auto-switch to power-saving theme at low battery
- **mullvad-vpn.md** - Mullvad VPN installation and security settings

## Hardware-Specific Notes

This configuration is tailored for Apple Silicon hardware running Asahi Linux, which has specific requirements for:
- Keyboard backlight control
- Touchpad gestures and palm rejection
- Battery management and power optimization

## Quick Reference

### Keyboard Backlight
Apply custom backlight effects:
```bash
./backlight-effects.sh
```

### Battery Theme Switcher
Automatically switches to matte-black theme when battery drops to 5% or below. See [battery-theme-switcher/battery-theme-switcher.md](battery-theme-switcher/battery-theme-switcher.md) for installation and configuration.

### Mullvad VPN
Check VPN status and connection:
```bash
mullvad status
mullvad connect
```
See [mullvad-vpn.md](mullvad-vpn.md) for full configuration details.
