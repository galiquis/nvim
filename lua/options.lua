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

