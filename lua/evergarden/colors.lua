---@class evergarden.types.color { [1]: string, [2]: number }

---@alias evergarden.types.colors.enum 'bg0_hard'|'bg0_soft'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'skye'|'purple'|'pink'|'grey0'|'grey1'|'grey2'
---@alias evergarden.types.colors { [evergarden.types.colors.enum]: evergarden.types.color }

---@type evergarden.types.colors
_G.evergarden_colors = {
  bg0_hard    = { "#1C2225", 0 },
  bg0         = { "#232B2E", 0 },
  bg0_soft    = { "#2B3538", 0 },
  bg1         = { "#313C40", 8 },
  bg2         = { "#3F4D52", 8 },
  bg3         = { "#46565B", 8 },
  bg4         = { "#5E6C70", 8 },
  bg5         = { "#6E8585", 8 },
  fg          = { "#D5D6C8", 7 },
  red         = { "#E67E80", 1 },
  orange      = { "#E69875", 11 },
  yellow      = { "#DBBC7F", 3 },
  green       = { "#B2C98F", 2 },
  aqua        = { "#93C9A1", 6 },
  skye        = { "#97C9C3", 4 },
  blue        = { "#9BB5CF", 4 },
  purple      = { "#D6A0D1", 5 },
  pink        = { "#E3A8D1", 5 },
  grey0       = { "#7B8480", 8 },
  grey1       = { "#859289", 15 },
  grey2       = { "#94AAA0", 8 },
}

local M = {}

function M.colors()
  return _G.evergarden_colors
end

---@param config evergarden.types.config?
---@return evergarden.types.theme
function M.setup(config)
  ---@type evergarden.types.config
  config = vim.tbl_extend('force', _G.evergarden_config, config or {})
  return require('evergarden.theme').setup(M.colors(), config)
end

return M
