-- ~/.config/nvim/lua/plugins/autopairs.lua
-- 自动括号配对

local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

npairs.setup({
  check_ts = true,              -- 使用 Treesitter 检查（内置）
  ts_config = {
    lua = { "string" },         -- 在 lua string 中不自动配对
    python = { "string" },
  },
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})

-- 与内置补全集成（如果有 LSP 补全）
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
