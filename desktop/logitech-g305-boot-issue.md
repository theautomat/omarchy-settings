# Logitech G305 Mouse Boot Issue - Investigation & Fix

**Date**: 2025-10-11
**System**: shade (AMD Ryzen 9 8945HS, Arch Linux 6.16.7-arch1-1, Hyprland/Wayland)

## Problem Description

Logitech G305 wireless mouse (USB receiver dongle) is not recognized/functional after system boot. Mouse works immediately after unplugging and re-plugging the USB dongle.

## Root Cause

The `hid_logitech_hidpp` kernel module is not loading automatically at boot. System falls back to generic `hid-generic` driver which doesn't properly support wireless Logitech gaming mice.

### Evidence from Logs

**At boot (01:22:41):**
```
hid-generic 0003:046D:C53F.0003: input,hiddev96,hidraw2: USB HID v1.11 Mouse
```
Only generic HID driver loaded.

**After re-plugging (01:26:06):**
```
logitech-djreceiver 0003:046D:C53F.000B: device of type eQUAD Lightspeed 1.1 (0x0d) connected
logitech-hidpp-device 0003:046D:4074.000C: input,hidraw8: USB HID v1.11 Keyboard [Logitech G305]
logitech-hidpp-device 0003:046D:4074.000C: HID++ 4.2 device connected.
```
Proper Logitech-specific drivers loaded.

## Required Kernel Modules

- `hid_logitech_dj` - Logitech DJ receiver driver
- `hid_logitech_hidpp` - Logitech HID++ protocol driver (this is the critical one)

## Solution Options

### Option 1: Add to initramfs (RECOMMENDED - Most Robust)

This is the preferred solution recommended by the Arch Linux community:

1. Edit `/etc/mkinitcpio.conf`
2. Add modules to the MODULES array:
   ```
   MODULES=(hid_logitech_dj hid_logitech_hidpp)
   ```
3. Regenerate initramfs:
   ```bash
   sudo mkinitcpio -P
   ```
4. Reboot and test

**Why this is better:**
- Loads modules early in boot process
- More reliable than modules-load.d
- The autodetect hook can miss modules if kernel is updated without device plugged in

### Option 2: Add to modules-load.d (Simpler but less reliable)

1. Create `/etc/modules-load.d/logitech-hid.conf`:
   ```bash
   echo "hid_logitech_hidpp" | sudo tee /etc/modules-load.d/logitech-hid.conf
   ```
2. Reboot and test

### Option 3: Manual module reload (Temporary workaround)

If you don't want to reboot after making changes:
```bash
sudo rmmod hid_logitech_dj
sudo modprobe hid_logitech_dj
```

## Community Research Findings

This is a **known issue** affecting multiple users:

1. **Arch Linux Forums**: Multiple threads about G305 and other Logitech wireless mice requiring dongle replug after boot
2. **Hyprland-specific**: Some users report similar USB input device issues on Hyprland/Wayland specifically
3. **Alternative theory**: Some users report that keeping mouse **physically closer to dongle during boot** helps (suggests wireless initialization timing issue)

### Related Links
- Arch Forums: "Logitech G305 USB Mouse fails to move cursor after login" (ID: 273114)
- Arch Forums: "Logitech wireless mouse not working before I unplug and plug dongle" (ID: 274334)
- GitHub systemd issue #27557: "Since kernel 6.3.1 logitech unify receiver not working properly"

## Next Steps

1. **Implement Option 1** (mkinitcpio method) - run these commands:
   ```bash
   sudo nano /etc/mkinitcpio.conf
   # Add: MODULES=(hid_logitech_dj hid_logitech_hidpp)
   sudo mkinitcpio -P
   sudo reboot
   ```

2. **After reboot, verify** mouse works immediately without replugging

3. **If still not working**, check these:
   - Try moving mouse closer to PC during boot
   - Check boot logs: `journalctl -b | grep -i logitech`
   - Verify modules loaded: `lsmod | grep logitech`

4. **If Option 1 doesn't work**, try Option 2 as fallback

## Status

- [x] Issue identified and root cause confirmed
- [x] Community research completed
- [ ] Fix implemented (waiting for user to run commands)
- [ ] Post-reboot verification pending

## Device Information

- **Mouse**: Logitech G305
- **USB Receiver**: 046d:c53f (Logitech Unifying Receiver)
- **Mouse Product ID**: 046d:4074
- **Protocol**: eQUAD Lightspeed 1.1
- **Device path**: `/dev/input/event15`, `/dev/input/mouse1`
