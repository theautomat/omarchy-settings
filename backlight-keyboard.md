# Mac Keyboard Backlight on Arch Linux (Omarchy)

## Quick Solution

Your Mac keyboard backlight device is `kbd_backlight` with a max brightness of 255.

### Control Commands

```bash
# Set to 50% brightness (128/255)
brightnessctl --device="kbd_backlight" set 128

# Set to 100% brightness
brightnessctl --device="kbd_backlight" set 100%

# Turn off
brightnessctl --device="kbd_backlight" set 0

# Set to specific percentage
brightnessctl --device="kbd_backlight" set 75%
```

## What We Did

1. **Listed available backlight devices:**
   ```bash
   brightnessctl --list
   ```

   Found the keyboard backlight device: `kbd_backlight` (0-255 range)

2. **Turned on the keyboard backlight:**
   ```bash
   brightnessctl --device="kbd_backlight" set 128
   ```

   Set it to 50% brightness (128 out of 255)

## Alternative Methods

### Manual Control via /sys/class/leds/

```bash
# Check current brightness
cat /sys/class/leds/kbd_backlight/brightness

# Set brightness (0-255)
echo 128 | sudo tee /sys/class/leds/kbd_backlight/brightness
```

## Troubleshooting

### Check if brightnessctl is installed
```bash
sudo pacman -S brightnessctl
```

### List all LED devices
```bash
ls /sys/class/leds/
```

### View all available backlight devices
```bash
brightnessctl --list
```

## Hardware Controls

Try these Fn key combinations:
- Fn + F5/F6
- Fn + Spacebar

These might work depending on your Mac keyboard model.
