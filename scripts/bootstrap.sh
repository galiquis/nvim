#!/usr/bin/env bash
#
# bootstrap.sh — install the SYSTEM prerequisites this Neovim config needs.
# Target: Ubuntu / Debian (apt). x86_64.
#
# This installs the external binaries the config assumes exist on PATH — the
# things that can't live in the nvim repo because they're outside Neovim. After
# running this, clone the config to ~/.config/nvim and launch nvim.
#
# What it does NOT do (these are per-user / per-machine and intentionally manual):
#   - Copilot auth        -> in nvim: :Copilot auth
#   - git identity + auth -> git config user.name/email; SSH key for pushing
#   - cloning the config  -> git clone <repo> ~/.config/nvim
#
# Usage:
#   ./bootstrap.sh
# Toggle language toolchains off with env vars, e.g.:
#   INSTALL_RUST=0 INSTALL_ZIG=0 ./bootstrap.sh
 
set -euo pipefail
 
# ---- toggles (1 = install, 0 = skip). Override via environment. -------------
INSTALL_NODE="${INSTALL_NODE:-1}"   # Node LTS — needed by Copilot. Recommended on.
INSTALL_RUST="${INSTALL_RUST:-1}"   # rustup + rust-analyzer (for rustaceanvim)
INSTALL_ZIG="${INSTALL_ZIG:-1}"     # Zig compiler + version-matched zls
ZIG_VERSION="${ZIG_VERSION:-0.16.0}" # bump this when you upgrade Zig
 
log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
 
# ---- core packages ----------------------------------------------------------
log "Core packages (apt)"
sudo apt update
sudo apt install -y \
  git ripgrep fd-find build-essential \
  python3-venv python3-pip unzip curl
 
# Debian/Ubuntu ship fd as 'fdfind' to avoid a name clash; expose it as 'fd'
# so telescope / venv-selector find it under the expected name.
if ! have fd && have fdfind; then
  log "Symlinking fdfind -> /usr/local/bin/fd"
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi
 
# ---- Node (Copilot) ---------------------------------------------------------
if [ "$INSTALL_NODE" = "1" ]; then
  if have node; then
    log "Node already present ($(node --version)) — skipping"
  else
    log "Node LTS (NodeSource)"
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
    sudo apt install -y nodejs
  fi
fi
 
# ---- Rust (rustup + rust-analyzer) ------------------------------------------
if [ "$INSTALL_RUST" = "1" ]; then
  if [ -x "$HOME/.cargo/bin/cargo" ] || have cargo; then
    log "Rust already present — ensuring rust-analyzer component"
  else
    log "Rust (rustup, non-interactive)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  fi
  # shellcheck disable=SC1091
  . "$HOME/.cargo/env"
  rustup component add rust-analyzer
fi
 
# ---- Zig + zls (version-matched pair) ---------------------------------------
if [ "$INSTALL_ZIG" = "1" ]; then
  if have zig; then
    log "Zig already present ($(zig version)) — skipping compiler install"
  else
    log "Zig ${ZIG_VERSION}"
    tmp="$(mktemp -d)"
    curl -L "https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz" \
      -o "$tmp/zig.tar.xz"
    sudo rm -rf /opt/zig && sudo mkdir -p /opt/zig
    sudo tar xf "$tmp/zig.tar.xz" -C /opt/zig --strip-components=1
    sudo ln -sf /opt/zig/zig /usr/local/bin/zig
    rm -rf "$tmp"
  fi
 
  if have zls; then
    log "zls already present ($(zls --version)) — skipping"
  else
    log "zls matching Zig ${ZIG_VERSION}"
    tmp="$(mktemp -d)"
    # Resolve the matching zls release asset from GitHub.
    url="$(curl -s "https://api.github.com/repos/zigtools/zls/releases/tags/${ZIG_VERSION}" \
      | grep -o '"browser_download_url": "[^"]*x86_64-linux[^"]*\.tar\.xz"' \
      | cut -d'"' -f4 | head -1)"
    if [ -n "$url" ]; then
      curl -L "$url" -o "$tmp/zls.tar.xz"
      mkdir -p "$tmp/zls" && tar xf "$tmp/zls.tar.xz" -C "$tmp/zls"
      sudo mkdir -p /opt/zls
      sudo cp "$tmp/zls/zls" /opt/zls/zls
      sudo ln -sf /opt/zls/zls /usr/local/bin/zls
    else
      echo "WARN: couldn't resolve a zls release for ${ZIG_VERSION}." >&2
      echo "      Check https://github.com/zigtools/zls/releases and install by hand," >&2
      echo "      or let Mason handle zls (the config falls back to that automatically)." >&2
    fi
    rm -rf "$tmp"
  fi
fi
 
# ---- verification -----------------------------------------------------------
log "Verification (toolchains you toggled off will show 'absent' — that's fine)"
for c in git rg fd cc python3 node cargo rust-analyzer zig zls; do
  if have "$c"; then printf '  \033[32mok\033[0m    %s\n' "$c"
  else               printf '  \033[33mabsent\033[0m %s\n' "$c"; fi
done
 
cat <<'NOTE'
 
Done. Remaining manual steps (not handled by this script):
  1. Clone the config:   git clone <your-repo> ~/.config/nvim
  2. Launch nvim — Lazy installs plugins; Mason installs basedpyright/ruff/lua_ls
     (and zls IF no system zls is on PATH).
  3. In nvim:            :Copilot auth
  4. git identity:       git config --global user.name "..."; ...user.email "..."
     and an SSH key for pushing (recommended on servers).
NOTE
