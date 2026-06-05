-- LSP configuration (Neovim 0.11+ native mechanism)
--
-- What changed vs the old version:
--   * The mason-lspconfig `handlers = {...}` API was REMOVED in mason-lspconfig
--     v2.0. Server setup now happens through Neovim's native `vim.lsp.config()`
--     and `vim.lsp.enable()`. mason-lspconfig's `automatic_enable` (on by
--     default) calls `vim.lsp.enable()` for every server it installs.
--   * Per-server settings now live in `~/.config/nvim/lsp/<name>.lua` files,
--     which Neovim reads automatically off the runtimepath. See that folder.
--   * Tools that are NOT language servers (debugpy, stylua, etc.) are installed
--     via mason-tool-installer, not registered as LSPs.
--   * neodev.nvim (deprecated/archived) replaced with lazydev.nvim.
--   * Rust is intentionally absent here — rustaceanvim owns rust_analyzer.
--     See lua/plugins/rust.lua.

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', config = true }, -- must load before dependants
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      -- lazydev: Lua LS awareness of the Neovim runtime + your config
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      -- Runs every time an LSP attaches to a buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('group-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require('telescope.builtin')
          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<F2>', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>rf', vim.lsp.buf.references, '[R]eferences')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- ruff: defer hover/definitions to basedpyright to avoid duplicate,
          -- lower-quality popups. ruff stays responsible for lint + format.
          if client and client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
          end

          -- Highlight references of the symbol under the cursor on CursorHold.
          if client and client.server_capabilities.documentHighlightProvider then
            local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Toggle inlay hints if the server supports them.
          if client and client:supports_method('textDocument/inlayHint') then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Broadcast nvim-cmp's extra completion capabilities to every server.
      -- Setting it on the '*' pseudo-config makes it the default for all
      -- servers configured via vim.lsp.config / the lsp/ folder.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })

      require('mason').setup()

      -- Language servers to auto-install AND auto-enable. Their per-server
      -- settings live in lsp/<name>.lua. Note: NO rust_analyzer here — that is
      -- handled by rustaceanvim (lua/plugins/rust.lua).
      -- Servers to auto-install AND auto-enable. Their per-server settings live
      -- in lsp/<name>.lua. NO rust_analyzer here — rustaceanvim owns that.
      local ensure_lsp = {
        'basedpyright', -- Python types
        'ruff',         -- Python lint + format
        'lua_ls',       -- Lua
      }

      -- zls is special: it must match your Zig compiler version. If a zls is
      -- already on PATH (a hand-installed, version-matched one — e.g. on the
      -- Linux server), DON'T let Mason fetch a second copy that could drift.
      -- If there's no system zls (e.g. on Windows), let Mason manage it.
      if vim.fn.executable('zls') == 0 then
        table.insert(ensure_lsp, 'zls')
      end

      require('mason-lspconfig').setup({
        ensure_installed = ensure_lsp,
      })

      -- Non-LSP tooling (formatters, debuggers) installed by mason but used
      -- through none-ls / nvim-dap rather than as language servers.
      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',  -- Lua formatter (none-ls)
          'debugpy', -- Python debugger (nvim-dap-python)
        },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
