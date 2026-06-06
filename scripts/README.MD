scripts/ — machine bootstrap
System prerequisites for this Neovim config — the external binaries the config
assumes on PATH (compilers, toolchains, ripgrep, fd, python3-venv,
Node, Rust, Zig, zls). These can't live in the nvim config itself because
they're outside Neovim. lua/startup_check.lua detects what's missing; these
scripts install it.
Order on a new machine

Run the bootstrap for your OS (below).
Clone this repo to the config path:

Linux/macOS: git clone <repo> ~/.config/nvim
Windows: git clone <repo> $env:LOCALAPPDATA\nvim


Launch nvim — lazy.nvim installs plugins, Mason installs the language
servers. Then :Lazy restore to pin to the committed lazy-lock.json.
Per-user steps the scripts deliberately skip: :Copilot auth, git identity,
and a push credential (SSH key recommended on servers).

Ubuntu / Debian
bash./scripts/bootstrap.sh
# skip toolchains you don't want:
INSTALL_RUST=0 INSTALL_ZIG=0 ./scripts/bootstrap.sh
Windows (PowerShell)
powershell.\scripts\bootstrap.ps1
# toggles are $true/$false switches at the top of the script
Language toggles
Core (git, ripgrep, fd, compiler, python venv/pip, curl/unzip) always installs.
Node / Rust / Zig+zls are toggandle-able. Node is on by default because Copilot
needs it.
The zls / Mason interaction
If Zig is enabled, the script puts a version-matched zls on PATH. The config
(lua/plugins/lspconfig.lua) only asks Mason to install zls when there is no
system zls — so a bootstrapped machine uses the matched one, and a machine
without Zig lets Mason fill in. Same committed config, correct either way.
Maintenance

Bump ZIG_VERSION in bootstrap.sh (and the winget version pin in
bootstrap.ps1 if you pin Python) when you upgrade.
Keep zig and zls on the same tagged version (patch differences are fine).
