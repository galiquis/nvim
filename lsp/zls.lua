-- Zig language server.
-- NOTE: zls is tightly version-coupled to the Zig compiler. The mason build
-- is usually current enough to get started, but if you hit "incompatible
-- version" errors after a Zig upgrade, remove zls from mason's
-- ensure_installed, install a matching zls from the zls releases page, and
-- add `vim.lsp.enable('zls')` to lua/plugins/lspconfig.lua's config function.
return {
  settings = {
    zls = {
      enable_build_on_save = false,
      -- zig_exe_path = '/usr/local/bin/zig', -- set if zig isn't on PATH
    },
  },
}
