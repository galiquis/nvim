-- Treesitter: highlighting, indentation, incremental parsing.
-- Pinned to the `master` branch (matches your lazy-lock). The `main`-branch
-- rewrite uses a different config API; don't switch branches without
-- rewriting this file.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash', 'c', 'cpp', 'lua', 'luadoc', 'markdown', 'markdown_inline',
        'vim', 'vimdoc', 'python', 'javascript',
        'rust', 'zig', 'toml', 'json', 'yaml', -- added for your stack
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- Compiler selection, cross-platform:
      -- Windows usually has no cc/gcc on PATH, so parser builds fail there.
      -- zig is the easiest fix (and you have it installed for Zig dev anyway).
      -- On Linux the system cc handles it, so we leave the default alone.
      if vim.fn.has('win32') == 1 and vim.fn.executable('zig') == 1 then
        require('nvim-treesitter.install').compilers = { 'zig' }
      end

      -- Prefer git over curl when fetching parsers — more reliable on
      -- locked-down / proxied networks (and on Windows without curl).
      require('nvim-treesitter.install').prefer_git = true

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
