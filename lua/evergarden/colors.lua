---@class Color { [1]: string, [2]: number }

---@alias EvergardenColor 'bg0_hard'|'bg0_soft'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'purple'|'grey0'|'grey1'|'grey2'
---@alias EvergardenColors { [EvergardenColor]: Color }

---@type EvergardenColors
_G.evergarden_colors = {
  bg0_hard    = { "#141b1f", 0 },
  bg0         = { "#272E32", 0 },
  bg0_soft    = { "#2D363B", 0 },
  bg1         = { "#343E44", 8 },
  bg2         = { "#3D494F", 8 },
  bg3         = { "#46545B", 8 },
  bg4         = { "#4F6066", 8 },
  bg5         = { "#6E8585", 8 },
  fg          = { "#D3C6AA", 7 },
  red         = { "#E67E80", 1 },
  orange      = { "#E69875", 11 },
  yellow      = { "#DBBC7F", 3 },
  green       = { "#B2C98F", 2 },
  aqua        = { "#83C092", 6 },
  blue        = { "#A2C8C3", 4 },
  purple      = { "#D699B6", 5 },
  grey0       = { "#7A8478", 8 },
  grey1       = { "#859289", 15 },
  grey2       = { "#9DA9A0", 8 },
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
