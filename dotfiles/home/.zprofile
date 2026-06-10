# =============================================================================
# base/home/.zprofile
# Session initialization profile executed at login
# =============================================================================

# --- Window Manager Autostart ------------------------------------------------
# If we are logging into the first virtual console (TTY1) and Hyprland is available, start it automatically
if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
    if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
    fi
fi