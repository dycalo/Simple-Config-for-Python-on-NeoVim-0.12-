-- ~/.config/nvim/lsp/bashls.lua
-- Bash/Shell 语言服务器

return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh", "zsh" },
  root_markers = { ".git", ".bashrc", ".zshrc" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      shellcheckPath = vim.fn.executable("shellcheck") == 1 and "shellcheck" or "",
      shellcheckArguments = { "--severity=warning" },
      explainshellEndpoint = "",        -- 禁用 explainshell（需外部服务）
      includeAllWorkspaceSymbols = true,
    },
  },
}
