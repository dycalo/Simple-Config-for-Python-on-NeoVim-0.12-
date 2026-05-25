-- ~/.config/nvim/lua/plugins/files.lua
-- nvim-tree.lua

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- nvim-tree 设置
nvim_tree.setup({
  view = {
    -- 其他视图选项可以保持默认
  },
  actions = {
    open_file = {
      quit_on_open = true, -- 打开文件后自动关闭文件树
      -- resize_window = true,  -- 可选：调整窗口大小
      -- window_picker = {      -- 可选：选择打开文件的窗口
      --   enable = true,
      -- }
    }
  }
})

-- 全局按键
vim.keymap.set("n", "<leader>uf", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
