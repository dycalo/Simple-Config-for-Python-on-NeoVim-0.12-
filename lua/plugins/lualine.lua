-- ~/.config/nvim/lua/plugins/lualine.lua
-- 状态栏配置，无外部工具依赖

local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

lualine.setup({
  options = {
    theme = "auto",           -- 自动检测 colorscheme
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,      -- 全局状态栏
    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },  -- 显示相对路径
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      -- 显示 LSP 状态（优雅降级：无 LSP 时不显示）
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return "[" .. table.concat(names, ", ") .. "]"
      end,
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "quickfix", "fugitive" },
})
