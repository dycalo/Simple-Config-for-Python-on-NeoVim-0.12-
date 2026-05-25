-- ~/.config/nvim/lsp/marksman.lua
-- Markdown LSP（链接、标题、引用等）

return {
  cmd = { "marksman" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", ".git" },
  settings = {},
}
