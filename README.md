# Simple Config for Python on Neovim 0.12+

基于 Neovim 0.12+ 内置 `vim.pack` 插件系统的极简配置，面向 Python 开发。

## 设计理念

- **零外部插件管理器** — 使用 Neovim 0.12 内置的 `vim.pack.add()`，无需 lazy.nvim / packer
- **最大化使用内置功能** — 补全用 `vim.lsp.completion`，格式化用 `vim.lsp.buf.format()`，折叠用 `vim.treesitter.foldexpr()`
- **按需加载，优雅降级** — 所有 LSP 服务器启动前检查二进制是否存在，缺失时仅警告不报错
- **干净简洁** — 无色彩主题插件、无启动画面、无模糊查找器，专注核心编辑体验

## 前置要求

- Neovim 0.12+
- Git
- 系统剪贴板工具（`xclip` / `wl-copy`，可选）
- [Nerd Font](https://www.nerdfonts.com/)（图标显示）

### LSP 服务器（按需安装）

| 语言 | 服务器 | 安装命令 |
|------|--------|----------|
| Python | basedpyright | `pip install basedpyright` |
| Lua | lua-language-server | `pacman -S lua-language-server` |
| Bash | bash-language-server | `npm i -g bash-language-server` |
| Markdown | marksman | `pacman -S marksman` |

### 外部工具（可选，用于格式化/检查）

`ruff` `shfmt` `shellcheck` `prettier`

## 安装

```bash
git clone git@github.com:dycalo/Simple-Config-for-Python-on-NeoVim-0.12-.git ~/.config/nvim
```

首次启动时 Neovim 会自动安装插件。

## 插件列表

| 插件 | 用途 |
|------|------|
| nvim-tree.lua | 文件树侧边栏 |
| lualine.nvim | 状态栏 |
| bufferline.nvim | 标签栏缓冲管理 |
| gitsigns.nvim | Git 增删改符号 |
| nvim-autopairs | 自动配对括号/引号 |
| nvim-web-devicons | 文件图标（依赖） |

## 快捷键

Leader 键为 `<Space>`。

### 通用

| 按键 | 功能 |
|------|------|
| `<leader>w` | 保存 |
| `<leader>q` | 退出 |
| `<leader>y` / `<leader>Y` | 复制到系统剪贴板 |
| `<leader>p` | 从系统剪贴板粘贴 |
| `<Esc>` | 清除搜索高亮 |
| `<C-h/j/k/l>` | 窗口间移动 |
| `<C-方向键>` | 调整窗口大小 |

### 缓冲与文件

| 按键 | 功能 |
|------|------|
| `<leader>uf` | 切换文件树 |
| `<leader>bd` | 关闭当前缓冲 |
| `<leader>bn` / `<leader>bp` | 下一个/上一个缓冲 |
| `<leader>1` ~ `<leader>5` | 跳转到缓冲 1~5 |

### Git (Gitsigns)

| 按键 | 功能 |
|------|------|
| `]c` / `[c` | 下一个/上一个变更块 |
| `<leader>hs` | 暂存变更块 |
| `<leader>hr` | 重置变更块 |
| `<leader>hS` | 暂存整个缓冲 |
| `<leader>hR` | 重置整个缓冲 |
| `<leader>hp` | 预览变更块 |
| `<leader>hb` | 行 Blame |
| `<leader>tb` | 行内 Blame 开关 |
| `<leader>hd` | 差异对比 |

### Quickfix

| 按键 | 功能 |
|------|------|
| `<leader>co` / `<leader>cc` | 打开/关闭 Quickfix 列表 |
| `<leader>cn` / `<leader>cp` | 下一个/上一个 Quickfix 项 |

### LSP

| 按键 | 功能 |
|------|------|
| `gd` / `gD` | 跳转到定义 / 声明 |
| `gr` | 查找引用 |
| `gI` / `gy` | 跳转到实现 / 类型定义 |
| `K` | 悬停文档 |
| `<leader>k` | 签名帮助 |
| `<leader>rn` | 重命名 |
| `<leader>ca` | 代码操作 |
| `<leader>ds` / `<leader>ws` | 文档符号 / 工作区符号 |

### 终端

| 按键 | 功能 |
|------|------|
| `<leader>t` | 打开终端 |
| `<Esc><Esc>` | 退出终端模式 |

## 目录结构

```
~/.config/nvim/
├── init.lua                 # 入口（声明插件、加载配置）
├── lua/
│   ├── core/
│   │   ├── options.lua      # 编辑器选项
│   │   ├── keymaps.lua      # 全局快捷键
│   │   └── autocmds.lua     # 自动命令
│   ├── plugins/
│   │   ├── init.lua         # 插件加载器
│   │   ├── files.lua        # nvim-tree
│   │   ├── lualine.lua      # 状态栏
│   │   ├── bufferline.lua   # 标签栏
│   │   ├── gitsigns.lua     # Git 装饰
│   │   ├── autopairs.lua    # 自动配对
│   │   └── devicons.lua     # 图标
│   └── lsp/
│       ├── init.lua         # LSP 全局设置
│       ├── pyright.lua      # Python (basedpyright)
│       ├── lua_ls.lua       # Lua
│       ├── bashls.lua       # Bash
│       └── marksman.lua     # Markdown
└── nvim-pack-lock.json      # 插件版本锁
```

## 补全与格式化

- **补全**: 使用 Neovim 内置 `vim.lsp.completion`，无需 nvim-cmp
- **格式化**: 保存时通过 LSP `textDocument/formatting` 自动格式化，无需 conform/none-ls
- **折叠**: 基于 Treesitter 的语法折叠，默认展开所有折叠
