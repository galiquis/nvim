-- Rust support via rustaceanvim.
--
-- rustaceanvim configures and attaches rust_analyzer ITSELF — do not also
-- install/enable rust_analyzer through mason-lspconfig or you'll get two
-- clients fighting over the buffer. That's why rust_analyzer is absent from
-- lspconfig.lua's ensure_installed and there's no lsp/rust_analyzer.lua.
--
-- Install the server through rustup so it always matches your toolchain:
--     rustup component add rust-analyzer
--
-- It's a plugin/start spec, not a setup() call — rustaceanvim wires itself
-- up on load. Buffer-local keymaps from your LspAttach autocmd still apply.

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false, -- this plugin is already lazy on filetype internally
    -- Optional config example (uncomment to customise):
    -- init = function()
    --   vim.g.rustaceanvim = {
    --     server = {
    --       default_settings = {
    --         ['rust-analyzer'] = {
    --           cargo = { allFeatures = true },
    --           check = { command = 'clippy' },
    --         },
    --       },
    --     },
    --   }
    -- end,
  },
}
