-- Lualine configuration
-- Lualine is a plugin that provides a statusline for Neovim. i

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = { theme  = 'dracula' }
})
    end
}
