# bootstrap.ps1 — install the SYSTEM prerequisites this Neovim config needs.
# Target: Windows (winget).
#
# Installs the external binaries the config assumes on PATH. After running this,
# clone the config to $env:LOCALAPPDATA\nvim and launch nvim.
#
# NOT handled here (per-user / per-machine, do manually):
#   - Copilot auth        -> in nvim: :Copilot auth
#   - git identity + auth -> git config user.name/email; PAT or SSH key
#   - cloning the config  -> git clone <repo> $env:LOCALAPPDATA\nvim
#
# Usage (in PowerShell):
#   .\bootstrap.ps1
# Toggle language toolchains with the switches just below.
 
# ---- toggles ----------------------------------------------------------------
$InstallNode = $true   # Node LTS — needed by Copilot. Recommended on.
$InstallRust = $true   # rustup + rust-analyzer (for rustaceanvim)
$InstallZig  = $true   # Zig + zls via winget. See note re: treesitter compiler.
 
$ErrorActionPreference = 'Stop'
function Log($m) { Write-Host "`n==> $m" -ForegroundColor Cyan }
function Install($id) { winget install -e --id $id --accept-source-agreements --accept-package-agreements }
 
# ---- core -------------------------------------------------------------------
Log "Core packages (winget)"
Install 'Git.Git'
Install 'BurntSushi.ripgrep.MSVC'
Install 'sharkdp.fd'
Install 'Python.Python.3.12'   # includes pip + venv on Windows; bump version as you like
 
# Treesitter needs a C compiler to build parsers. On Windows the config uses
# Zig as that compiler IF Zig is present (see lua/plugins/treesitter.lua). So:
#   - InstallZig = $true  -> you're covered (zig doubles as the compiler)
#   - InstallZig = $false -> install a compiler, e.g.:  winget install -e --id LLVM.LLVM
 
# ---- Node (Copilot) ---------------------------------------------------------
if ($InstallNode) {
  Log "Node LTS"
  Install 'OpenJS.NodeJS.LTS'
}
 
# ---- Rust -------------------------------------------------------------------
if ($InstallRust) {
  Log "Rust (rustup) + rust-analyzer"
  Install 'Rustlang.Rustup'
  # rustup is on PATH after install; component add is idempotent.
  rustup component add rust-analyzer
}
 
# ---- Zig + zls --------------------------------------------------------------
if ($InstallZig) {
  Log "Zig + zls (winget)"
  Install 'zig.zig'
  Install 'zigtools.zls'
  # NOTE: this puts zls on PATH, so your config's runtime check skips Mason's
  # zls here too — same single-zls outcome as the Linux box. If you'd rather
  # let Mason manage zls on Windows, set $InstallZig = $false and install a
  # separate compiler (see the LLVM line above).
}
 
# ---- verification -----------------------------------------------------------
Log "Verification (toggled-off tools will show 'absent' — that's fine)"
foreach ($c in 'git','rg','fd','python','node','cargo','rust-analyzer','zig','zls') {
  if (Get-Command $c -ErrorAction SilentlyContinue) {
    Write-Host "  ok     $c" -ForegroundColor Green
  } else {
    Write-Host "  absent $c" -ForegroundColor Yellow
  }
}
 
Write-Host @'
 
Done. You may need to open a NEW terminal so PATH changes take effect.
Remaining manual steps (not handled by this script):
  1. Clone the config:   git clone <your-repo> $env:LOCALAPPDATA\nvim
  2. Launch nvim — Lazy + Mason install the rest.
  3. In nvim:            :Copilot auth
  4. git identity + a PAT or SSH key for pushing.
'@
