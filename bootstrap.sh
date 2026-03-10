#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Dotfiles Bootstrap Script
# ==============================================================================
# Run this on a fresh Arch Linux install (no DE) to set everything up.
# Usage: bash bootstrap.sh
# ==============================================================================

DOTFILES_REPO="https://github.com/nekithrill/dotfiles"
DOTFILES_DIR="$HOME/dotfiles"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log()     { echo -e "${BLUE}${BOLD}[•]${NC} $*"; }
success() { echo -e "${GREEN}${BOLD}[✓]${NC} $*"; }
warn()    { echo -e "${YELLOW}${BOLD}[!]${NC} $*"; }
die()     { echo -e "${RED}${BOLD}[✗]${NC} $*"; exit 1; }

# ------------------------------------------------------------------------------

[[ $EUID -ne 0 ]] || die "Do not run as root. sudo is used internally."
command -v pacman &>/dev/null || die "pacman not found. Arch Linux only."

echo
echo -e "${BOLD}================================${NC}"
echo -e "${BOLD}   Dotfiles Bootstrap Installer  ${NC}"
echo -e "${BOLD}================================${NC}"
echo

# ------------------------------------------------------------------------------
# Step 1: System update
# ------------------------------------------------------------------------------

log "Updating system..."
sudo pacman -Syu --noconfirm
success "System updated."

# ------------------------------------------------------------------------------
# Step 2: Install git
# ------------------------------------------------------------------------------

log "Installing git..."
sudo pacman -S --needed --noconfirm git
success "git installed."

# ------------------------------------------------------------------------------
# Step 3: Install yay
# ------------------------------------------------------------------------------

if command -v yay &>/dev/null; then
    warn "yay is already installed, skipping."
else
    log "Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    (cd "$tmp_dir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmp_dir"
    success "yay installed."
fi

# ------------------------------------------------------------------------------
# Step 4: Clone dotfiles
# ------------------------------------------------------------------------------

if [[ -d "$DOTFILES_DIR" ]]; then
    warn "Dotfiles directory already exists at $DOTFILES_DIR, pulling latest..."
    git -C "$DOTFILES_DIR" pull
else
    log "Cloning dotfiles from $DOTFILES_REPO..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi
success "Dotfiles ready at $DOTFILES_DIR."

# ------------------------------------------------------------------------------
# Step 5: Run install.sh
# ------------------------------------------------------------------------------

INSTALL_SCRIPT="$DOTFILES_DIR/install.sh"

if [[ ! -f "$INSTALL_SCRIPT" ]]; then
    die "install.sh not found at $INSTALL_SCRIPT. Check your repo structure."
fi

chmod +x "$INSTALL_SCRIPT"
log "Running install.sh..."
echo
bash "$INSTALL_SCRIPT"

# ------------------------------------------------------------------------------

echo
success "Bootstrap complete! Reboot to start Hyprland."
echo -e "  After reboot, start Hyprland with: ${BOLD}Hyprland${NC}"
echo