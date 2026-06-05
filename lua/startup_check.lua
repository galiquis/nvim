-- Lightweight startup check for external binaries this config relies on.
-- Warns ONCE after startup, and ONLY about what's actually missing. Because
-- this is a multi-machine config (Linux server + Windows + maybe macOS), the
-- missing set differs per box — this turns silent feature-degradation into a
-- visible, actionable notice instead of a "works on my server" mystery.

local function have(name)
  return vim.fn.executable(name) == 1
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('startup-dependency-check', { clear = true }),
  once = true,
  callback = function()
    vim.schedule(function()
      local missing = {}

      -- A C compiler is needed to build treesitter parsers; any one will do.
      local has_cc = false
      for _, c in ipairs({ 'cc', 'gcc', 'clang', 'zig' }) do
        if have(c) then
          has_cc = true
          break
        end
      end
      if not has_cc then
        table.insert(missing, '- C compiler (cc/gcc/clang/zig)  → treesitter parser builds')
      end

      local checks = {
        { cmd = 'git', why = 'plugin install/update, parser fetch' },
        { cmd = 'rg', why = 'telescope live_grep / grep_string', alias = 'ripgrep' },
        { cmd = 'node', why = 'Copilot' },
      }
      for _, c in ipairs(checks) do
        if not have(c.cmd) then
          local label = c.alias and (c.cmd .. ' (' .. c.alias .. ')') or c.cmd
          table.insert(missing, string.format('- %s  → %s', label, c.why))
        end
      end

      if #missing > 0 then
        vim.notify(
          'Missing external tools:\n'
            .. table.concat(missing, '\n')
            .. '\n\nRun :checkhealth for full diagnostics.',
          vim.log.levels.WARN,
          { title = 'nvim: dependency check' }
        )
      end
    end)
  end,
})
