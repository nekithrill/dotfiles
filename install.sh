#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Dotfiles Package Installer
# ==============================================================================
# Installs all packages from the packages/ directory and enables system services.
# Requires: pacman (Arch Linux), an AUR helper (yay or paru)
# ==============================================================================

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/packages"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

log()     { echo -e "${BLUE}${BOLD}[•]${NC} $*"; }
success() { echo -e "${GREEN}${BOLD}[✓]${NC} $*"; }
warn()    { echo -e "${YELLOW}${BOLD}[!]${NC} $*"; }
error()   { echo -e "${RED}${BOLD}[✗]${NC} $*"; }
die()     { error "$*"; exit 1; }

# Read a package list file, stripping comments and blank lines
read_packages() {
    local file="$1"
    grep -v '^\s*#' "$file" | grep -v '^\s*$' || true
}

# ------------------------------------------------------------------------------
# Preflight checks
# ------------------------------------------------------------------------------

check_requirements() {
    log "Checking requirements..."

    [[ $EUID -ne 0 ]] || die "Do not run this script as root. It will use sudo when needed."
    command -v pacman &>/dev/null || die "pacman not found. This script is for Arch Linux only."

    if command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    else
        die "No AUR helper found. Please install yay or paru first."
    fi

    success "Using AUR helper: $AUR_HELPER"
}

# ------------------------------------------------------------------------------
# GPU driver detection
# ------------------------------------------------------------------------------

detect_gpu() {
    log "Detecting GPU..."

    local gpu
    gpu=$(lspci 2>/dev/null | grep -iE 'vga|3d|display' || true)

    if echo "$gpu" | grep -qi nvidia; then
        GPU_TYPE="nvidia"
    elif echo "$gpu" | grep -qi amd; then
        GPU_TYPE="amd"
    else
        warn "Could not detect GPU automatically."
        echo -e "  Select your GPU driver:"
        echo -e "  ${BOLD}1)${NC} AMD"
        echo -e "  ${BOLD}2)${NC} NVIDIA"
        echo -e "  ${BOLD}3)${NC} Skip GPU drivers"
        read -rp "  Enter choice [1-3]: " choice
        case "$choice" in
            1) GPU_TYPE="amd" ;;
            2) GPU_TYPE="nvidia" ;;
            3) GPU_TYPE="none" ;;
            *) die "Invalid choice." ;;
        esac
    fi

    success "GPU type: $GPU_TYPE"
}

# ------------------------------------------------------------------------------
# Installation
# ------------------------------------------------------------------------------

install_pacman_packages() {
    local label="$1"
    local file="$2"

    [[ -f "$file" ]] || { warn "File not found, skipping: $file"; return; }

    local packages
    mapfile -t packages < <(read_packages "$file")

    [[ ${#packages[@]} -eq 0 ]] && { warn "No packages in $file, skipping."; return; }

    log "Installing $label packages (${#packages[@]})..."
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    success "$label packages installed."
}

install_aur_packages() {
    local file="$PACKAGES_DIR/aur.txt"

    [[ -f "$file" ]] || { warn "aur.txt not found, skipping AUR packages."; return; }

    local packages
    mapfile -t packages < <(read_packages "$file")

    [[ ${#packages[@]} -eq 0 ]] && { warn "No AUR packages found, skipping."; return; }

    log "Installing AUR packages (${#packages[@]}) via $AUR_HELPER..."
    "$AUR_HELPER" -S --needed --noconfirm "${packages[@]}"
    success "AUR packages installed."
}

install_gpu_drivers() {
    [[ "$GPU_TYPE" == "none" ]] && { warn "Skipping GPU driver installation."; return; }

    local driver_file="$PACKAGES_DIR/drivers/${GPU_TYPE}.txt"

    [[ -f "$driver_file" ]] || { warn "Driver file not found: $driver_file"; return; }

    local packages
    mapfile -t packages < <(read_packages "$driver_file")

    [[ ${#packages[@]} -eq 0 ]] && { warn "No GPU packages found, skipping."; return; }

    log "Installing GPU (${GPU_TYPE}) packages (${#packages[@]})..."
    sudo pacman -S --needed --noconfirm "${packages[@]}" || \
        warn "Some GPU packages could not be installed (may not be available in this environment)."
    success "GPU driver step complete."
}

enable_services() {
    local file="$PACKAGES_DIR/services.txt"

    [[ -f "$file" ]] || { warn "services.txt not found, skipping."; return; }

    local services
    mapfile -t services < <(read_packages "$file")

    [[ ${#services[@]} -eq 0 ]] && { warn "No services found, skipping."; return; }

    log "Enabling system services..."
    for svc in "${services[@]}"; do
        if sudo systemctl enable --now "$svc" 2>/dev/null; then
            success "Enabled: $svc"
        else
            warn "Failed to enable: $svc (may need to be started manually)"
        fi
    done
}

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

main() {
    echo
    echo -e "${BOLD}==============================${NC}"
    echo -e "${BOLD}   Dotfiles Package Installer ${NC}"
    echo -e "${BOLD}==============================${NC}"
    echo

    check_requirements
    detect_gpu

    echo
    log "Starting installation..."
    echo

    # Official repos
    install_pacman_packages "system"  "$PACKAGES_DIR/system.txt"
    install_pacman_packages "desktop" "$PACKAGES_DIR/desktop.txt"
    install_pacman_packages "CLI"     "$PACKAGES_DIR/cli.txt"
    install_pacman_packages "dev"     "$PACKAGES_DIR/dev.txt"
    install_pacman_packages "apps"    "$PACKAGES_DIR/apps.txt"
    install_pacman_packages "fonts"   "$PACKAGES_DIR/fonts.txt"
    install_pacman_packages "themes"  "$PACKAGES_DIR/themes.txt"

    # GPU drivers
    install_gpu_drivers

    # AUR
    install_aur_packages

    # Services
    echo
    enable_services

    echo
    success "All done! You may want to reboot to apply all changes."
    echo
}

main "$@"
