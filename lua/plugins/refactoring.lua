return {
  "ThePrimeagen/refactoring.nvim",
  -- Pinned to dodge a regression introduced upstream (~April 2026): newer
  -- commits `require('async')` from a luarocks rock that lazy.nvim can't
  -- resolve, breaking config on Windows/Linux/macOS alike. See refactoring.nvim
  -- issues #521/#522/#523. This is the commit from your Dec-2025 lockfile that
  -- you were already running fine. Remove `commit = ...` once upstream fixes it.
  commit = "6784b54587e6d8a6b9ea199318512170ffb9e418",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()
  end,
}
