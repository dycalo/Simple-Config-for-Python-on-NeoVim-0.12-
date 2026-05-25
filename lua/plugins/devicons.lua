-- ~/.config/nvim/lua/plugins/devicons.lua（新建文件）
-- nvim-web-devicons 配置（bufferline 的依赖）

local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then
  return
end

-- nvim-web-devicons 通常不需要配置，但可以自定义图标
devicons.setup({
  -- 默认配置就够用
  override = {
    -- 可选：自定义文件类型图标
    -- ["myfile"] = { icon = "📄", color = "#ff9900" },
  },
})
