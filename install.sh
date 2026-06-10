#!/usr/bin/env bash
# Hyprland ecosystem + dotfiles symlinks

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/scripts/main.sh"

banner "$ORANGE" << 'EOF'
   ___       __  ____ __      
  / _ \___  / /_/ _(_) /__ ___
 / // / _ \/ __/ _/ / / -_|_-<
/____/\___/\__/_//_/_/\__/___/
EOF

# --- Packages ----------------------------------------------------------------

install_packages "$ROOT_DIR/packages/hyprland.txt"
install_packages "$ROOT_DIR/packages/extras.txt"

# --- Services ----------------------------------------------------------------

enable_services geoclue

# --- Symlinks ----------------------------------------------------------------

link_config_dir "$ROOT_DIR/dotfiles/config"
link_home_files "$ROOT_DIR/dotfiles/home"

success "Dotfiles installation completed!"