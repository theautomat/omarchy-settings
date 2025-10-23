# Bluetooth Keyboard Login Screen Fix

**Date**: 2025-10-22

## Issue
Bluetooth keyboard (NuPhy Air60 V2) requires USB cable to enter password at login screen after boot/reboot. Keyboard works fine once logged in, but is unavailable at the login prompt.

## Root Cause
Bluetooth adapter not initializing early enough in the boot process to be available at the login screen.

## Solution
Enable `AutoEnable` in `/etc/bluetooth/main.conf` to ensure the Bluetooth adapter starts automatically when the system boots.

## Changes Made
1. Edited `/etc/bluetooth/main.conf` line 362
2. Uncommented the line to explicitly enable: `AutoEnable=true`

## Configuration
```conf
# AutoEnable defines option to enable all controllers when they are found.
# This includes adapters present on start as well as adapters that are plugged
# in later on. Defaults to 'true'.
AutoEnable=true
```

## Device Information
- **Keyboard**: NuPhy Air60 V2-1
- **MAC Addresses**: C8:25:50:AC:9A:15 and C8:25:50:AC:9A:16 (dual entries)
- **Connection Type**: Bluetooth LE
- **Trusted**: Yes
- **Authentication Level**: 0 (Just Works pairing)

## Testing
After reboot, the Bluetooth keyboard should connect automatically and be available at the login screen without requiring USB connection.

## Additional Notes
- Bluetooth service (`bluetooth.service`) is already enabled and running
- The keyboard is already marked as trusted in `/var/lib/bluetooth/`
- This fix specifically addresses the timing of Bluetooth initialization during boot
