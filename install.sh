#!/usr/bin/env bash
# ============================================================
# Hermes Agent Installer for Termux + Ubuntu
# Source: https://github.com/vay-sys/hermes
# ============================================================
set -e

# --- Colors ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

# --- Output helpers ---
step() { echo -e "\n${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err()  { echo -e "${RED}[✗]${NC} $1"; }

# --- Detect environment ---
detect_env() {
  if [ -d "/data/data/com.termux" ] || [ -n "$TERMUX_VERSION" ] || command -v termux-setup-storage &>/dev/null; then
    IN_TERMUX=true
  else
    IN_TERMUX=false
  fi
}

# --- Install inside Ubuntu ---
install_in_ubuntu() {
  step "Updating Ubuntu packages..."
  apt-get update -y
  apt-get upgrade -y
  apt-get install -y curl wget git sudo

  step "Installing Hermes Agent..."
  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

  if command -v hermes &>/dev/null; then
    step "Hermes installed: $(hermes version 2>/dev/null || echo 'unknown version')"
  else
    warn "Hermes not in PATH yet. Try: source ~/.bashrc"
  fi
}

# --- Main ---
clear 2>/dev/null || true
echo -e "${CYAN}"
echo "  ===================================="
echo "   Hermes Agent Installer (Termux)   "
echo "  ===================================="
echo -e "${NC}"

detect_env

if [ "$IN_TERMUX" = true ]; then
  step "Detected: Termux"

  step "Installing dependencies..."
  pkg install -y wget curl proot-distro git

  if ! proot-distro list 2>/dev/null | grep -qi ubuntu; then
    step "Installing Ubuntu (this may take a while)..."
    proot-distro install ubuntu
  else
    step "Ubuntu already installed"
  fi

  step "Entering Ubuntu..."
  proot-distro login ubuntu -- bash -c "$(declare -f install_in_ubuntu step warn); install_in_ubuntu"
else
  warn "Not running in Termux. Assuming Ubuntu environment."
  install_in_ubuntu
fi

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN}  Installation complete!${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo "  Login Ubuntu:  proot-distro login ubuntu"
echo "  Start Hermes:  hermes"
echo "  Setup first:   hermes setup"
echo "  Gateway mode:  hermes gateway"
echo ""