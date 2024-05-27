---@class evergarden.types.color { [1]: string, [2]: number }

---@alias evergarden.types.colors.enum 'bg0_hard'|'bg0_soft'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'purple'|'grey0'|'grey1'|'grey2'
---@alias evergarden.types.colors { [evergarden.types.colors.enum]: evergarden.types.color }

---@type evergarden.types.colors
_G.evergarden_colors = {
  bg0_hard    = { "#1A2024", 0 },
  bg0         = { "#242B2E", 0 },
  bg0_soft    = { "#2D363B", 0 },
  bg1         = { "#343E44", 8 },
  bg2         = { "#3D494F", 8 },
  bg3         = { "#46545B", 8 },
  bg4         = { "#5E6C70", 8 },
  bg5         = { "#6E8585", 8 },
  fg          = { "#D6CBB4", 7 },
  red         = { "#E67E80", 1 },
  orange      = { "#E69875", 11 },
  yellow      = { "#DBBC7F", 3 },
  green       = { "#B2C98F", 2 },
  aqua        = { "#88C096", 6 },
  blue        = { "#8DC3BC", 4 },
  purple      = { "#D699B6", 5 },
  grey0       = { "#7A8478", 8 },
  grey1       = { "#859289", 15 },
  grey2       = { "#9DA9A0", 8 },
}

local M = {}

function M.colors()
  return _G.evergarden_colors
end

---@param config evergarden.types.config?
---@return evergarden.types.theme
function M.setup(config)
  ---@type evergarden.types.config
  config = vim.tbl_extend("force", _G.evergarden_config, config or {})
  return require 'evergarden.theme'.setup(M.colors(), config)
end

return M
