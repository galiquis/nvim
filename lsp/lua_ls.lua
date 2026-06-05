-- Lua language server. lazydev.nvim supplies Neovim runtime awareness,
-- so we don't hand-maintain library paths here.
return {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
