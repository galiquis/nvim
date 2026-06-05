-- Python linting + formatting (replaces black + isort + mypy-as-linter).
-- Hover is disabled in the LspAttach handler so basedpyright owns it.
return {
  init_options = {
    settings = {
      -- Add ruff args here if you don't keep them in pyproject.toml, e.g.:
      -- lineLength = 88,
    },
  },
}
