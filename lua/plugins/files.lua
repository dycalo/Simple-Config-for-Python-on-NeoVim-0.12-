-- ~/.config/nvim/lua/plugins/files.lua
-- nvim-tree.lua

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- 使用 nvim-tree 的所有默认设置，只添加启动快捷键
nvim_tree.setup({})

-- 全局按键
vim.keymap.set("n", "<leader>uf", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>uF", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file tree (find current file)" })
