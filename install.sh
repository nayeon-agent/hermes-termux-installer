1|#!/usr/bin/env bash
2|# ============================================================
3|# Hermes Agent One-Line Installer for Termux + Ubuntu
4|# Source: https://github.com/vay-sys/hermes/tree/main
5|# ============================================================
6|set -e
7|
8|RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
9|
10|banner() {
11|  echo -e "${CYAN}"
12|  echo "  ╔══════════════════════════════════════════╗"
13|  echo "  ║   🔥 Hermes Agent Termux Installer 🔥   ║"
14|  echo "  ╚══════════════════════════════════════════╝"
15|  echo -e "${NC}"
16|}
17|
18|step()  { echo -e "\n${GREEN}[✓]${NC} $1"; }
19|warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
20|err()   { echo -e "${RED}[✗]${NC} $1"; }
21|
22|# --- Pre-flight checks ---
23|preflight() {
24|  # Check if running inside Termux
25|  if [ -d "/data/data/com.termux" ] || [ -n "$TERMUX_VERSION" ] || command -v termux-setup-storage &>/dev/null; then
26|    IN_TERMUX=true
27|    step "Running inside Termux"
28|  elif [ -f /etc/os-release ] && grep -qi "ubuntu" /etc/os-release; then
29|    IN_TERMUX=false
30|    warn "Already inside Ubuntu — skipping Termux setup"
31|  else
32|    err "Not running in Termux. This script is for Termux + Ubuntu."
33|    exit 1
34|  fi
35|
36|  # Check if proot-distro is available (Termux side)
37|  if [ "$IN_TERMUX" = true ] && ! command -v proot-distro &>/dev/null; then
38|    warn "proot-distro not found — will install it"
39|  fi
40|}
41|
42|# --- Termux setup ---
43|setup_termux() {
44|  if [ "$IN_TERMUX" = false ]; then return; fi
45|
46|  step "Installing base dependencies..."
47|  pkg install -y wget curl proot-distro git
48|
49|  # Install Ubuntu if not present
50|  if ! proot-distro list 2>/dev/null | grep -qi ubuntu; then
51|    step "Installing Ubuntu distro (this may take a while)..."
52|    proot-distro install ubuntu
53|  else
54|    step "Ubuntu already installed"
55|  fi
56|}
57|
58|# --- Ubuntu setup inside proot ---
59|setup_ubuntu() {
60|  if [ "$IN_TERMUX" = false ]; then
61|    # Already in Ubuntu, install directly
62|    do_install
63|    return
64|  fi
65|
66|  step "Launching Ubuntu and installing Hermes..."
67|
68|  # Write the inner installer script to a temp file
69|  INNER_SCRIPT=$(mktemp /tmp/hermes-inner-XXXXXX.sh)
70|  cat > "$INNER_SCRIPT" << 'INNER_EOF'
71|#!/usr/bin/env bash
72|set -e
73|
74|echo "[✓] Inside Ubuntu — updating packages..."
75|apt-get update -y && apt-get upgrade -y
76|apt-get install -y curl wget git sudo
77|
78|echo "[✓] Installing Hermes Agent..."
79|curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
80|
81|echo "[✓] Verifying installation..."
82|if command -v hermes &>/dev/null; then
83|  echo "  → hermes $(hermes version 2>/dev/null || echo 'installed')"
84|else
85|  echo "[!] Hermes binary not in PATH yet."
86|  echo "    Close and reopen Ubuntu, or run: source ~/.bashrc"
87|fi
88|
89|echo ""
90|echo "============================================"
91|echo "  ✅ Hermes Agent installed successfully!"
92|echo "============================================"
93|echo ""
94|echo "Next steps:"
95|echo "  1. Run 'hermes' to start"
96|echo "  2. Run 'hermes setup' for initial config"
97|echo "     (You need an API key first!)"
98|echo "  3. Run 'hermes gateway' for platform mode"
99|echo ""
100|echo "Free API key sources:"
101|echo "  • https://ollama.com/"
102|echo "  • https://www.orcarouter.ai/playground"
103|echo "  • https://zyloo.io/dashboard/free-balance"
104|echo "  • https://aerolink.lat/dashboard"
105|INNER_EOF
106|
107|  chmod +x "$INNER_SCRIPT"
108|
109|  # Copy into proot and execute
110|  proot-distro login ubuntu -- bash "$INNER_SCRIPT"
111|  rm -f "$INNER_SCRIPT"
112|}
113|
114|# --- Direct install (already in Ubuntu) ---
115|do_install() {
116|  apt-get update -y && apt-get upgrade -y
117|  apt-get install -y curl wget git sudo
118|  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
119|}
120|
121|# --- Post install ---
122|post_install() {
123|  step "Installation complete!"
124|  echo ""
125|  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
126|  echo -e "${GREEN}  ✅  Hermes Agent is ready!${NC}"
127|  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
128|  echo ""
129|  echo "  To enter Ubuntu:  proot-distro login ubuntu"
130|  echo "  To start Hermes:  hermes"
131|  echo "  First time setup: hermes setup"
132|  echo "  Run as gateway:  hermes gateway"
133|  echo ""
134|}
135|
136|# --- Main ---
137|banner
138|preflight
139|setup_termux
140|setup_ubuntu
141|post_install
142|