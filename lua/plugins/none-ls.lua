-- none-ls: formatters/linters exposed as an LSP source.
--
-- Trimmed vs old version: dropped black + isort (ruff's LSP now handles
-- Python formatting AND import sorting) and dropped mypy (basedpyright covers
-- types). Left stylua for Lua formatting and the spell completion source.
--
-- <leader>gf formats the buffer: ruff for Python, stylua for Lua.

return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
      },
    })
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, { desc = 'Format buffer' })
  end,
}
