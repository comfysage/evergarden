local M = {}

local name = 'evergarden'
local colors = require(('%s.colors'):format(name)).colors()

function M.palettte()
  local data = { paletteName = name, swatches = {} }
  for k, v in pairs(colors) do
    ---@type string
    local _color = v[1]
    local color = string.sub(_color, 2)
    data.swatches[#data.swatches + 1] = {
      name = k,
      color = color,
    }
  end

  return vim.json.encode(data)
end

function M.xresources()
  local str = [[! Evergarden
*.foreground: %s
*.background: %s
*.cursorColor: %s

*.color0:  %s
*.color8:  %s
*.color1:  %s
*.color9:  %s
*.color2:  %s
*.color10: %s
*.color3:  %s
*.color11: %s
*.color4:  %s
*.color12: %s
*.color5:  %s
*.color13: %s
*.color6:  %s
*.color14: %s
*.color7:  %s
*.color15: %s]]

  return str:format(
    colors.fg,
    colors.bg0,
    colors.orange,
    colors.bg0,
    colors.bg1,
    colors.red,
    colors.red,
    colors.green,
    colors.green,
    colors.yellow,
    colors.orange,
    colors.blue,
    colors.blue,
    colors.purple,
    colors.purple,
    colors.aqua,
    colors.aqua,
    colors.fg,
    colors.grey1
  )
end

return M
