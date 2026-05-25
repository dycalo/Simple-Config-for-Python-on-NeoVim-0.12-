-- ~/.config/nvim/init.lua
-- Neovim 0.12+ 配置入口
-- 原则：只声明插件，不做具体配置

-- 1. 插件声明（vim.pack 自动下载）
-- 这些插件会被 clone 到 pack/plugins/start/
vim.pack.add({
  -- 依赖
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  -- 状态栏
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  -- Bufferline
  { src = "https://github.com/akinsho/bufferline.nvim" },
  -- Git 集成
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  -- 自动括号
  { src = "https://github.com/windwp/nvim-autopairs" },
  -- 文件树
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

-- 2. 加载核心配置
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- 3. 加载插件配置
require("plugins")

-- 4. 加载 LSP 配置
require("lsp")
