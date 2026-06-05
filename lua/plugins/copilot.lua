-- GitHub Copilot — inline suggestions (ghost text), Lua-native.
--
-- This replaces github/copilot.vim (removed from completions.lua) so there is
-- ONE Copilot engine instead of two fighting over inline suggestions.
-- CopilotChat already uses this same backend as a dependency; lazy.nvim merges
-- the two specs, so the opts below apply to both.
--
-- Auth (run once PER ACCOUNT, needs Node.js on PATH):  :Copilot auth
-- Check state any time:                                :Copilot status
--
-- Keys (Insert mode): Alt-l accept · Alt-] next · Alt-[ prev · Ctrl-] dismiss
-- Tab is deliberately left alone so it keeps serving nvim-cmp / indentation.

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        gitcommit = false,
        help = false,
      },
    },
  },
}
