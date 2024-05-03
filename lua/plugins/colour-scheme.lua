return {

    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { "tiagovla/tokyodark.nvim", priority = 1000, config = true, opt = ...},
    { "tiagovla/tokyodark.nvim", priority = 1000, config = true, opt = ...},
    { "folke/tokyonight.nvim", priority = 1000,},
    { "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require('onedark').setup{
                -- Main options --
                style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,  -- Show/hide background
                term_colors = false, -- Change terminal color as per the selected theme style
                cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

                -- toggle theme style ---
                toggle_style_key = "<leader>od", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
                toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'bold',
                    strings = 'none',
                    variables = 'none',
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },
                -- Custom Highlights --
                colors = {
                }, -- Override default colors
                highlights = {
                    TelescopeNormal = { bg = "$bg_d" },
                    TelescopeBorder = { bg = "$bg_d" },
                    TelescopePromptBorder = { bg = "$bg_d", fg = "$light_grey" },
                    TelescopeResultsBorder = { bg = "$bg_d", fg = "$light_grey"},
                    TelescopePreviewBorder = { bg = "$bg_d", fg = "$light_grey"},
                    FloatBorder = { bg = "$bg_d" },
                    NormalFloat = { bg = "$bg_d" },
                    -- ["@keyword"] = {fg = '$green'},
                    -- ["@string"] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
                    -- ["@function"] = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
                    -- ["@function.builtin"] = {fg = '#0059ff'}
                }, -- Override highlight groups

                -- Plugins Config --
                diagnostics = {
                    darker = true, -- darker colors for diagnostic
                    undercurl = true,   -- use undercurl instead of underline for diagnostics
                    background = true,    -- use background color for virtual text
                },
            }
            require('onedark').load()
        end,
    },
}
