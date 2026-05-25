-- ~/.config/nvim/lua/core/autocmds.lua
-- 自动命令，优雅处理外部工具缺失

local augroup = function(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- 1. 返回上次编辑位置
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_position"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 2. 高亮复制区域
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- 3. 自动切换目录到项目根（基于 .git）
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("auto_root"),
  callback = function()
    local root = vim.fs.root(0, ".git")
    if root then
      vim.fn.chdir(root)
    end
  end,
})

-- 4. 终端模式自动进入插入模式
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("term_insert"),
  command = "startinsert",
})

-- 5. 文件类型特定设置
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_settings"),
  pattern = { "lua", "python", "sh", "markdown" },
  callback = function(args)
    -- 这些语言使用内置格式化（LSP），无需额外设置
    -- 如果 LSP 未启动，这里不做任何事（优雅降级）
  end,
})

-- 6. 外部工具检查（用于健康检查）
-- 不阻塞启动，仅在 :checkhealth 时报告
vim.g.has_ruff = vim.fn.executable("ruff") == 1
vim.g.has_shfmt = vim.fn.executable("shfmt") == 1
vim.g.has_shellcheck = vim.fn.executable("shellcheck") == 1
vim.g.has_prettier = vim.fn.executable("prettier") == 1
