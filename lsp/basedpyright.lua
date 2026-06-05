-- Python type checking. Pairs with ruff (lint/format).
-- venv-selector.nvim makes this pick up your selected virtualenv at runtime.
return {
  settings = {
    basedpyright = {
      analysis = {
        -- "standard" is a sane default; "strict" if you want everything,
        -- "basic" if basedpyright's stricter defaults are too noisy.
        typeCheckingMode = 'standard',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly', -- 'workspace' = whole project (slower)
      },
    },
  },
}
