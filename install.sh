#!/usr/bin/env bash
# ============================================================
# Hermes Agent One-Line Installer for Termux + Ubuntu
# Source: https://github.com/vay-sys/hermes/tree/main
# ============================================================
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

banner() {
  echo -e "${CYAN}"
  echo "  ╔══════════════════════════════════════════╗"
  echo "  ║   🔥 Hermes Agent Termux Installer 🔥   ║"
  echo "  ╚══════════════════════════════════════════╝"
  echo -e "${NC}"
}

step()  { echo -e "\n${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
err()   { echo -e "${RED}[✗]${NC} $1"; }

# --- Pre-flight checks ---
preflight() {
  # Check if running inside Termux
  if [ -d "/data/data/com.termux" ] || [ -n "$TERMUX_VERSION" ] || command -v termux-setup-storage &>/dev/null; then
    IN_TERMUX=true
    step "Running inside Termux"
  elif [ -f /etc/os-release ] && grep -qi "ubuntu" /etc/os-release; then
    IN_TERMUX=false
    warn "Already inside Ubuntu — skipping Termux setup"
  else
    err "Not running in Termux. This script is for Termux + Ubuntu."
    exit 1
  fi

  # Check if proot-distro is available (Termux side)
  if [ "$IN_TERMUX" = true ] && ! command -v proot-distro &>/dev/null; then
    warn "proot-distro not found — will install it"
  fi
}

# --- Termux setup ---
setup_termux() {
  if [ "$IN_TERMUX" = false ]; then return; fi

  step "Updating Termux packages..."
  pkg update -y && pkg upgrade -y

  step "Installing base dependencies..."
  pkg install -y wget curl proot-distro git

  # Install Ubuntu if not present
  if ! proot-distro list 2>/dev/null | grep -qi ubuntu; then
    step "Installing Ubuntu distro (this may take a while)..."
    proot-distro install ubuntu
  else
    step "Ubuntu already installed"
  fi
}

# --- Ubuntu setup inside proot ---
setup_ubuntu() {
  if [ "$IN_TERMUX" = false ]; then
    # Already in Ubuntu, install directly
    do_install
    return
  fi

  step "Launching Ubuntu and installing Hermes..."

  # Write the inner installer script to a temp file
  INNER_SCRIPT=$(mktemp /tmp/hermes-inner-XXXXXX.sh)
  cat > "$INNER_SCRIPT" << 'INNER_EOF'
#!/usr/bin/env bash
set -e

# Disable ALL interactive prompts
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none
export APT_INSTALL_OPTIONS="-o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold"

echo "[✓] Inside Ubuntu — updating packages..."
apt-get update -y
apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt-get install -y curl wget git sudo

echo "[✓] Installing Hermes Agent..."
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

echo "[✓] Verifying installation..."
if command -v hermes &>/dev/null; then
  echo "  → hermes $(hermes version 2>/dev/null || echo 'installed')"
else
  echo "[!] Hermes binary not in PATH yet."
  echo "    Close and reopen Ubuntu, or run: source ~/.bashrc"
fi

echo ""
echo "============================================"
echo "  ✅ Hermes Agent installed successfully!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Run 'hermes' to start"
echo "  2. Run 'hermes setup' for initial config"
echo "     (You need an API key first!)"
echo "  3. Run 'hermes gateway' for platform mode"
echo ""
echo "Free API key sources:"
echo "  • https://ollama.com/"
echo "  • https://www.orcarouter.ai/playground"
echo "  • https://zyloo.io/dashboard/free-balance"
echo "  • https://aerolink.lat/dashboard"
INNER_EOF

  chmod +x "$INNER_SCRIPT"

  # Copy into proot and execute
  proot-distro login ubuntu -- bash "$INNER_SCRIPT"
  rm -f "$INNER_SCRIPT"
}

# --- Direct install (already in Ubuntu) ---
do_install() {
  export DEBIAN_FRONTEND=noninteractive
  export APT_LISTCHANGES_FRONTEND=none
  apt-get update -y
  apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
  apt-get install -y curl wget git sudo
  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
}

# --- Post install ---
post_install() {
  step "Installation complete!"
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}  ✅  Hermes Agent is ready!${NC}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  To enter Ubuntu:  proot-distro login ubuntu"
  echo "  To start Hermes:  hermes"
  echo "  First time setup: hermes setup"
  echo "  Run as gateway:  hermes gateway"
  echo ""
}

# --- Main ---
banner
preflight
setup_termux
setup_ubuntu
post_install
