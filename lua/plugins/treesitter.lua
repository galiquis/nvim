return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Treesitter config
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {"lua", "python", "javascript"},
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            modules = {},
        })
    end
}
