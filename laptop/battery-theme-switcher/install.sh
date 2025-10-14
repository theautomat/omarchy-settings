#!/bin/bash

# Simple installer for battery theme switcher

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing battery theme switcher..."

# Step 1: Copy script
echo "1. Copying script to ~/.local/bin/..."
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/scripts/battery-theme-switcher.sh" ~/.local/bin/
chmod +x ~/.local/bin/battery-theme-switcher.sh

# Step 2: Copy systemd files
echo "2. Copying systemd files..."
mkdir -p ~/.config/systemd/user
cp "$SCRIPT_DIR/systemd/battery-theme-switcher.service" ~/.config/systemd/user/
cp "$SCRIPT_DIR/systemd/battery-theme-switcher.timer" ~/.config/systemd/user/

# Step 3: Enable and start
echo "3. Enabling and starting timer..."
systemctl --user daemon-reload
systemctl --user enable battery-theme-switcher.timer
systemctl --user start battery-theme-switcher.timer

echo ""
echo "✓ Installation complete!"
echo ""
echo "Check status with: systemctl --user status battery-theme-switcher.timer"
echo "View logs with: journalctl --user -u battery-theme-switcher.service -f"
