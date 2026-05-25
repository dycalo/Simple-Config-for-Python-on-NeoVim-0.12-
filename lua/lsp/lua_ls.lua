-- ~/.config/nvim/lsp/lua_ls.lua
-- Lua 语言服务器配置（用于编辑 Neovim 配置本身）

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",           -- Neovim 使用 LuaJIT
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },            -- 识别 vim 全局变量
        disable = { "missing-fields" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,           -- Neovim 运行时
          "${3rd}/luv/library",         -- luv 库
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      hint = {
        enable = true,                  -- Inlay hints
        setType = true,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}
