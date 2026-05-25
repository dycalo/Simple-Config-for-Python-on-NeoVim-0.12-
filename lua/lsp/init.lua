-- ~/.config/nvim/lua/lsp/init.lua
-- LSP 全局设置：按键、自动命令、补全、格式化
-- 完全独立于插件配置

-- 1. 全局诊断配置
vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
})

-- 2. LSP 按键（在 LspAttach 时绑定）
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    if not client then
      return
    end

    local opts = { buffer = buf, silent = true }

    -- 导航
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Goto definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))

    -- 信息
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help,
      vim.tbl_extend("force", opts, { desc = "Signature help" }))

    -- 操作
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code action" }))

    -- 工作区
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

    -- 文档
    vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol,
      vim.tbl_extend("force", opts, { desc = "Document symbols" }))
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol,
      vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

    -- 内置补全（0.11+ 原生）
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

    -- Inlay hints（如果支持）
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    -- 格式化（内置 LSP 格式化，无需 conform.nvim）
    -- 仅在服务器支持时绑定
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("user_lsp_format_" .. buf, { clear = true }),
        buffer = buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- 3. 启用语言服务器
-- 配置文件放在 lsp/<name>.lua，Neovim 0.12 自动加载
local servers = { "lua_ls", "pyright", "bashls", "marksman" }

for _, server in ipairs(servers) do
  -- 检查服务器可执行文件是否存在（优雅降级）
  local config_ok, config = pcall(require, "lsp." .. server)
  if config_ok then
    local cmd = config.cmd and config.cmd[1] or server
    if vim.fn.executable(cmd) == 1 then
      vim.lsp.config[server] = config
      vim.lsp.enable(server)
    else
      vim.notify("LSP server not found: " .. cmd .. " (skipping " .. server .. ")", vim.log.levels.WARN)
    end
  else
    vim.notify("LSP config not found: " .. server, vim.log.levels.WARN)
  end
end
