#!/bin/bash
# Keyboard backlight effects for Mac on Arch Linux (Omarchy)

DEVICE="kbd_backlight"

# Fade in effect
fade_in() {
    local duration_ms=${1:-2000}  # milliseconds
    local steps=50
    local delay_ms=$((duration_ms / steps))

    for i in $(seq 0 $steps); do
        local brightness=$((255 * i / steps))
        brightnessctl --device="$DEVICE" set "$brightness" > /dev/null 2>&1
        sleep "0.$(printf '%03d' $delay_ms)"
    done
}

# Fade out effect
fade_out() {
    local duration_ms=${1:-2000}  # milliseconds
    local steps=50
    local delay_ms=$((duration_ms / steps))

    for i in $(seq $steps -1 0); do
        local brightness=$((255 * i / steps))
        brightnessctl --device="$DEVICE" set "$brightness" > /dev/null 2>&1
        sleep "0.$(printf '%03d' $delay_ms)"
    done
}

# Pulse effect (breathing)
pulse() {
    local cycles=${1:-3}
    local duration_ms=${2:-2000}  # milliseconds per cycle
    local half=$((duration_ms / 2))

    for ((c=1; c<=cycles; c++)); do
        fade_in $half
        fade_out $half
    done
}

# Blink effect
blink() {
    local cycles=${1:-5}
    local on_time=${2:-0.2}
    local off_time=${3:-0.2}

    for ((i=1; i<=cycles; i++)); do
        brightnessctl --device="$DEVICE" set 255 > /dev/null 2>&1
        sleep "$on_time"
        brightnessctl --device="$DEVICE" set 0 > /dev/null 2>&1
        sleep "$off_time"
    done
}

# Notification effect (quick pulse)
notify() {
    local original=$(brightnessctl --device="$DEVICE" get)
    pulse 2 0.5
    brightnessctl --device="$DEVICE" set "$original" > /dev/null 2>&1
}

# Smooth transition to target brightness
transition_to() {
    local target=${1:-128}
    local duration_ms=${2:-1000}
    local current=$(brightnessctl --device="$DEVICE" get)
    local steps=30
    local delay_ms=$((duration_ms / steps))

    for i in $(seq 1 $steps); do
        local brightness=$((current + (target - current) * i / steps))
        brightnessctl --device="$DEVICE" set "$brightness" > /dev/null 2>&1
        sleep "0.$(printf '%03d' $delay_ms)"
    done
}

# Show usage
show_usage() {
    echo "Keyboard Backlight Effects"
    echo "Usage: $0 <effect> [parameters]"
    echo ""
    echo "Effects:"
    echo "  fade-in [duration_ms]          - Fade from 0 to max (default: 2000ms)"
    echo "  fade-out [duration_ms]         - Fade from max to 0 (default: 2000ms)"
    echo "  pulse [cycles] [duration_ms]   - Breathing effect (default: 3 cycles, 2000ms)"
    echo "  blink [cycles] [on] [off]      - Blink on/off (default: 5 cycles, 0.2s)"
    echo "  notify                         - Quick notification pulse"
    echo "  transition [target] [dur_ms]   - Smooth transition to brightness (default: 128, 1000ms)"
    echo ""
    echo "Examples:"
    echo "  $0 fade-in 3000"
    echo "  $0 pulse 5 1500"
    echo "  $0 transition 200 2000"
}

# Main
case "$1" in
    fade-in)
        fade_in "$2"
        ;;
    fade-out)
        fade_out "$2"
        ;;
    pulse)
        pulse "$2" "$3"
        ;;
    blink)
        blink "$2" "$3" "$4"
        ;;
    notify)
        notify
        ;;
    transition)
        transition_to "$2" "$3"
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
