-- General options for NeoVim

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- hide tildes at the end of the file
vim.opt.fillchars = { eob = " " }
-- set tab stops
--vim.cmd("set expandtab=true")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
-- Enable mouse support
--vim.opt.mouse = "a"
-- Enable line wrapping
-- vim.opt.wrap = true
-- Enable smart indenting
vim.opt.smartindent = true
vim.opt.breakindent = true -- break indent
-- Enable incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true
-- Better split navigation
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Enavle sign column
vim.opt.signcolumn = "yes"
-- Enable cursorline
vim.opt.cursorline = true
-- Enable folding
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
-- Always keep 5 lines above and below the cursor
vim.opt.scrolloff = 5
-- place a line at 80 characters
vim.opt.colorcolumn = "80"

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ============================================================================
-- Remote clipboard via OSC 52  (ADDED for working over SSH)
-- ----------------------------------------------------------------------------
-- On a headless server there's no system clipboard, so yanks to the + register
-- normally go nowhere useful. OSC 52 tunnels the copy through your terminal to
-- YOUR LOCAL machine's clipboard. Neovim 0.11 has it built in; your local
-- terminal must also permit OSC 52 (most modern ones do, some need it enabled).
--
-- Only activated inside an SSH session, so the same config still uses the
-- native clipboard if you ever run it locally.
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  local osc52 = require('vim.ui.clipboard.osc52')
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
    paste = { ['+'] = osc52.paste('+'), ['*'] = osc52.paste('*') },
  }
end
