# Omarchy Settings

Custom system settings and configurations for Omarchy desktop environment across multiple machines.

## Working with Claude

When using Claude Code on this repository:
- **Do not run commands without user confirmation first** - explain what you want to do and wait for approval
- Be cost-conscious - avoid running multiple exploratory commands in parallel
- Always explain the purpose of commands before executing them
- **Do not include Claude/AI attribution in git commit messages** - keep commits professional and focused on the technical changes

## Purpose

This repository contains **only customizations and modifications** made to the base system:
- Custom scripts and configurations
- Settings that have been changed from defaults
- Notes on system-specific tweaks and hardware compatibility
- Guidance for replicating this setup on other machines

**Note**: Do not document default settings or read-only system information. Only include what has been actively customized.

## Repository Structure

### `desktop/` - Desktop Workstation (shade)
- **System**: x86_64 Arch Linux + Hyprland
- **Hardware**: AMD Ryzen 9 8945HS, 32GB RAM
- **Peripherals**: NuPhy Air60 V2 keyboard, Logitech G305 mouse
- **Contents**: Application bindings, keyboard settings, hardware troubleshooting

### `laptop/` - Apple Silicon Laptop (Asahi)
- **System**: Arch Linux ARM on Asahi (Apple Silicon)
- **Hardware**: Apple Silicon (ARM64)
- **Contents**: Touchpad/keyboard/backlight settings, battery theme switcher

See each folder's README for detailed machine specifications and configuration files.
