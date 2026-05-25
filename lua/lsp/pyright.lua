-- ~/.config/nvim/lsp/pyright.lua
-- Python LSP：使用 basedpyright（更完整的类型检查）

return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoImportCompletions = true,
        inlayHints = {
          callArgumentNames = true,
          functionReturnTypes = true,
          variableTypes = true,
        },
      },
    },
  },
}
