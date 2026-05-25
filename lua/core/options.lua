-- ~/.config/nvim/lua/core/options.lua
-- 原生 vim.opt 配置

local opt = vim.opt

-- 编辑体验
opt.number = true         -- 行号
opt.relativenumber = true -- 相对行号
opt.cursorline = true     -- 当前行高亮
opt.wrap = false          -- 不换行
opt.scrolloff = 8         -- 上下保留行
opt.sidescrolloff = 8

-- 缩进
opt.expandtab = true -- 空格替代 tab
opt.shiftwidth = 2   -- 自动缩进宽度
opt.tabstop = 2      -- tab 显示宽度
opt.softtabstop = 2
opt.smartindent = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true -- 有大写字母时区分大小写
opt.hlsearch = true
opt.incsearch = true

-- 外观
opt.guifont = "Cascadia Mono:h14"
opt.termguicolors = true -- 真彩色
opt.signcolumn = "yes"   -- 始终显示符号列（诊断/Gitsigns）
opt.colorcolumn = "80"   -- 参考线
opt.laststatus = 3       -- 全局状态栏
opt.showmode = false     -- 不显示模式（lualine 替代）

-- 文件
opt.undofile = true  -- 持久化撤销
opt.swapfile = false -- 禁用 swap
opt.backup = false
opt.writebackup = false

-- 性能
opt.updatetime = 250 -- 触发事件延迟
opt.timeoutlen = 300 -- 按键序列超时

-- 补全
opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "preview" }

-- 折叠（Treesitter 内置）
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- 默认展开

-- 分割
opt.splitright = true
opt.splitbelow = true

-- 系统剪贴板（优雅降级：无 xclip/wl-copy 时静默失败）
local has_clipboard = vim.fn.has("clipboard") == 1
if has_clipboard then
  opt.clipboard:append("unnamedplus")
end

-- 添加命令补全相关配置
opt.wildmenu = true           -- 启用命令行补全菜单
opt.wildmode = "list:longest" -- 补全模式：列出全部选项

-- 禁用不需要的provider
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
