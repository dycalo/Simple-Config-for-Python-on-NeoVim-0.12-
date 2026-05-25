-- ~/.config/nvim/lua/plugins/init.lua
-- 插件配置入口，每个插件独立文件
-- 如果插件未安装（首次启动），pcall 保护不报错

local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Plugin config failed: " .. module .. "\n" .. result, vim.log.levels.WARN)
    return nil
  end
  return result
end

-- 按顺序加载各插件配置
safe_require("plugins.devicons")
safe_require("plugins.files")
safe_require("plugins.lualine")
safe_require("plugins.bufferline")
safe_require("plugins.gitsigns")
safe_require("plugins.autopairs")
