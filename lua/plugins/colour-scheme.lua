return {

    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { "tiagovla/tokyodark.nvim", priority = 1000, config = true, opt = ...},
    { "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require('onedark').setup{
                -- Main options --
                style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,  -- Show/hide background
                term_colors = false, -- Change terminal color as per the selected theme style
                ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
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
                    functions = 'none',
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
                    ["TelescopeNormal"] = { bg = "#272c35" },
                    ["TelescopeBorder"] = { bg = "#272c35" },
                    ["TelescopePromptBorder"] = { bg = "#272c35" },
                    ["TelescopeResultsBorder"] = { bg = "#272c35" },
                    ["TelescopePreviewBorder"] = { bg = "#272c35" },
                    ["FloatBorder"] = { bg = "#272c35" },
                    ["NormalFloat"] = { bg = "#272c35" },
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
    { -- You can easily change to a different colorscheme.
        'folke/tokyonight.nvim',
        priority = 1000,
        init = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                light_style = "day", -- The theme is used when the background is set to light
                transparent = false, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
                sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
                dim_inactive = false, -- dims inactive windows
                lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
            })
            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.

            -- vim.cmd.colorscheme 'tokyonight-night' -- enable here

            -- You can configure highlights by doing something like:
            -- vim.cmd.hi 'Comment gui=none'
        end,
    },
}
