-- Keymaps and autocommands configuration
--
-- Define the options for the keymaps
local opts = { noremap = true, silent = true }

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- My additions
vim.keymap.set('n', '<leader><tab>', vim.cmd.Ex)
-- move highlighted code blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- set half page jumps and keep cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- keep cursor in the middle when searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- replace words in file
vim.keymap.set('n', '<leader>se', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Undotree toggle
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:CFloatTerm<CR>', opts)

-- in visual mode, ctrl-c and ctrl-v copy and paste 
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', opts)
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', opts)
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', opts)

-- tab navigation
vim.api.nvim_set_keymap('n', '<TAB>', ':tabnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':tabprevious<CR>', opts)
vim.api.nvim_set_keymap('n', '<Tab>n', ':tabnew<CR>', opts)
vim.api.nvim_set_keymap('n', '<Tab>q', ':tabclose<CR>', opts)


-- rename items in the buffer <leader>rn to <f2>
vim.keymap.set({'n', 'i', 'v'}, '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
