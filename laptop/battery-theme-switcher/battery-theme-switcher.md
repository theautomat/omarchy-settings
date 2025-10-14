# Battery Theme Switcher

Automatically switches Omarchy theme to "matte-black" when battery drops to 5% or below.

## How It Works

- Monitors battery every 30 seconds via systemd timer
- When battery ≤5% and discharging: switches to matte-black theme
- When battery >5%: restores your original theme
- Saves your original theme so it can be restored later

## Installation

### Quick Install (Recommended)

Simply run the install script from the repo directory:

```bash
cd /path/to/omarchy/laptop/battery-theme-switcher
./install.sh
```

That's it! The script will copy all files and enable the timer.

### Manual Installation

If you prefer to install manually:

#### 1. Copy the script to your local bin

```bash
# Replace /path/to/omarchy with wherever you cloned this repo
cp /path/to/omarchy/laptop/battery-theme-switcher/scripts/battery-theme-switcher.sh ~/.local/bin/
chmod +x ~/.local/bin/battery-theme-switcher.sh
```

#### 2. Copy systemd files to user config

```bash
# Replace /path/to/omarchy with your actual repo path
cp /path/to/omarchy/laptop/battery-theme-switcher/systemd/battery-theme-switcher.service ~/.config/systemd/user/
cp /path/to/omarchy/laptop/battery-theme-switcher/systemd/battery-theme-switcher.timer ~/.config/systemd/user/
```

#### 3. Enable and start the timer

```bash
# Reload systemd to recognize new files
systemctl --user daemon-reload

# Enable: makes it start automatically on boot
systemctl --user enable battery-theme-switcher.timer

# Start: begins running it now
systemctl --user start battery-theme-switcher.timer
```

## Testing

### Test the script manually
```bash
# Run the script once to see if it works
~/.local/bin/battery-theme-switcher.sh

# Check your current battery level
upower -i $(upower -e | grep 'BAT') | grep percentage
```

### Check timer status
```bash
# See if timer is running
systemctl --user status battery-theme-switcher.timer

# List all your active timers
systemctl --user list-timers
```

### View logs
```bash
# View recent script executions
journalctl --user -u battery-theme-switcher.service -n 20

# Follow logs in real-time (Ctrl+C to exit)
journalctl --user -u battery-theme-switcher.service -f
```

## Customization

Edit the script to customize behavior:

```bash
# Open the installed script
nano ~/.local/bin/battery-theme-switcher.sh
```

**Settings you can change:**
- `BATTERY_THRESHOLD=5` - Change the percentage threshold
- `UGLY_THEME="matte-black"` - Choose a different "ugly" theme

**Available themes:**
- catppuccin
- catppuccin-latte
- everforest
- gruvbox
- kanagawa
- matte-black
- nord
- osaka-jade
- ristretto
- rose-pine
- tokyo-night

## Troubleshooting

### Script not running?
```bash
# Check if timer is enabled
systemctl --user is-enabled battery-theme-switcher.timer

# Check if timer is active
systemctl --user is-active battery-theme-switcher.timer

# Restart the timer
systemctl --user restart battery-theme-switcher.timer
```

### Theme not switching?
```bash
# Run script manually and check for errors
~/.local/bin/battery-theme-switcher.sh

# Check if omarchy-theme-set command exists
which omarchy-theme-set

# Check current theme
omarchy-theme-current
```

## Uninstall

```bash
# Stop and disable timer
systemctl --user stop battery-theme-switcher.timer
systemctl --user disable battery-theme-switcher.timer

# Remove files
rm ~/.local/bin/battery-theme-switcher.sh
rm ~/.config/systemd/user/battery-theme-switcher.service
rm ~/.config/systemd/user/battery-theme-switcher.timer

# Reload systemd
systemctl --user daemon-reload
```

## How It Works (Technical Details)

### Script Logic
1. Checks battery percentage using `upower`
2. Checks if battery is discharging (not charging)
3. If battery ≤5%: saves current theme to `/run/user/$UID/omarchy_theme_switched` and switches to matte-black
4. If battery >5%: reads saved theme and restores it

### Systemd Timer Flow
1. System boots → timer waits 1 minute
2. Timer triggers service → service runs script → script exits
3. Timer waits 30 seconds → repeat step 2

### Why `/run/user/$UID/`?
This directory is automatically created for your user session and cleared on reboot. Perfect for temporary state files.

## Future Enhancements

- [ ] Add notification when theme switches
- [ ] Restore theme when charger is plugged in (not just when battery >5%)
- [ ] Make theme choice configurable without editing script
