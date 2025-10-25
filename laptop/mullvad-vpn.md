# Mullvad VPN Configuration

## Installation and Setup

**Date**: 2025-10-25

### Installation
Mullvad VPN installed via AUR package `mullvad-vpn-bin` version 2025.10-1:
```bash
yay -S mullvad-vpn-bin
# or
paru -S mullvad-vpn-bin
```

### Account Configuration
```bash
mullvad account login <account-number>
```

Account: 6828856573072097
Device: "Rested Ghost" (auto-assigned)

### Current Settings (as of 2025-10-25)

**VPN Protocol**: WireGuard (default and recommended)
- Faster and more efficient than OpenVPN
- Better battery life on laptop
- More secure with simpler codebase

**Security & Connection Settings**:
```bash
# Auto-connect on boot
mullvad auto-connect set on

# Kill switch (blocks internet if VPN disconnects)
mullvad lockdown-mode set on

# Allow local network access (printers, local devices)
mullvad lan set allow

# Set location to Los Angeles (important for banking and financial services)
mullvad relay set location us lax
```

**Active Features**:
- Auto-connect: VPN connects automatically on system boot
- Lockdown Mode: Prevents internet access when VPN is disconnected (no IP leaks)
- LAN Sharing: Can access local network devices
- Quantum Resistance: Future-proof encryption enabled by default

### System Service
The Mullvad daemon runs as a systemd service:
```bash
systemctl status mullvad-daemon.service
```

The daemon is always running in the background. The GUI app (`mullvad-gui`) is optional and only provides a visual interface to control the daemon.

### Basic Commands
```bash
mullvad status              # Check connection status
mullvad connect             # Connect to VPN
mullvad disconnect          # Disconnect from VPN
mullvad account get         # View account info
mullvad relay list          # List available servers
mullvad relay set location  # Change server location
```

### Server Location

**Current location**: Los Angeles, CA
```bash
mullvad relay set location us lax  # Los Angeles (closest to home)
```

**Important**: Use US servers to avoid issues with:
- Banking services (Mercury.com, Wells Fargo, etc.)
- Payment processors (PayPal, Stripe)
- Streaming services (Netflix, Hulu)

Many services block or flag foreign IPs as suspicious activity.

**Other US city options**:
```bash
mullvad relay set location us lax  # Los Angeles
mullvad relay set location us nyc  # New York City
mullvad relay set location us chi  # Chicago
mullvad relay set location us atl  # Atlanta
mullvad relay set location us sea  # Seattle
mullvad relay set location us     # Any US city (automatic)
```

### Rationale
- **Auto-connect**: Ensures VPN protection starts immediately on boot without manual intervention
- **Lockdown mode**: Critical for preventing accidental IP leaks if VPN drops
- **LAN access**: Necessary for accessing local printers, NAS, and other home network devices
- **WireGuard over OpenVPN**: Better performance and battery efficiency for mobile use
- **US location**: Prevents banking/financial service lockouts from foreign IP detection

### Notes
- The GUI and CLI both control the same daemon, so settings apply system-wide
- GUI may need daemon restart to reflect CLI changes (cosmetic issue only)
- Current relay location set to Sweden (se-sto-wg-011)
- IPv6 is disabled by default in tunnel settings
