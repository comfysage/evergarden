---@class Color { [1]: string, [2]: number }

---@alias EvergardenColor 'bg_dim'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'purple'|'grey0'|'grey1'|'grey2'|'statusline1'|'statusline2'|'statusline3'
---@alias EvergardenColors { [EvergardenColor]: Color }

---@type EvergardenColors
_G.evergarden_colors = {
  bg0_hard    = { "#253137", 0 },
  bg0         = { "#141b1f", 0 },
  bg0_soft    = { "#1d262b", 0 },
  bg1         = { "#343E44", 0 },
  bg2         = { "#3D474D", 0 },
  bg3         = { "#475258", 0 },
  bg4         = { "#4F5A5E", 0 },
  bg5         = { "#566363", 0 },
  fg          = { "#D3C6AA", 0 },
  red         = { "#E67E80", 0 },
  orange      = { "#E69875", 0 },
  yellow      = { "#DBBC7F", 0 },
  green       = { "#B2C98F", 0 },
  aqua        = { "#83C092", 0 },
  blue        = { "#7FBBB3", 0 },
  purple      = { "#D699B6", 0 },
  grey0       = { "#7A8478", 0 },
  grey1       = { "#859289", 0 },
  grey2       = { "#9DA9A0", 0 },
  statusline1 = { "#A7C080", 0 },
  statusline2 = { "#D3C6AA", 0 },
  statusline3 = { "#E67E80", 0 },
}

local M = {}

function M.colors()
  return _G.evergarden_colors
end

---@param config EvergardenConfig?
---@return EvergardenTheme
function M.setup(config)
  ---@type EvergardenConfig
  config = vim.tbl_extend("force", _G.evergarden_config, config or {})
  return require 'evergarden.theme'.setup(M.colors(), config)
end

return M
