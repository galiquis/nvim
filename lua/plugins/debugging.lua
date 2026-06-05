-- Debugging (nvim-dap) configuration.
--
-- Cross-platform debugpy path: mason installs the debugpy venv with a `bin/`
-- (Linux/macOS) or `Scripts/...exe` (Windows) layout. We branch on the OS so
-- the SAME config works on the server and on a Windows box.

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Path to the python inside mason's debugpy venv, per platform.
      local function debugpy_python()
        local venv = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv'
        if vim.fn.has('win32') == 1 then
          return venv .. '/Scripts/python.exe'
        end
        return venv .. '/bin/python'
      end
      require('dap-python').setup(debugpy_python())

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, { desc = 'DAP: toggle breakpoint' })
      vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = 'DAP: continue' })
    end,
  },
}
