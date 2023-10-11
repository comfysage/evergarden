---@alias styleField 'search'
---@alias styleValue { reverse: boolean }

---@class EvergardenTheme
---@field none Color
---@field colors EvergardenColors
---@field base { fg: Color, bg: Color }
---@field bg Color
---@field fg Color
---@field bg0 Color
---@field bg1 Color
---@field bg2 Color
---@field bg3 Color
---@field fg0 Color
---@field fg1 Color
---@field fg2 Color
---@field sakura  Color
---@field sage    Color
---@field sukai   Color
---@field shinme  Color
---@field sakaeru Color
---@field taiyo Color
---@field seiun   Color
---@field ike     Color
---@field syntax EvergardenSyntax
---@field style { [styleField]: styleValue }
---@field comment Color

---@class EvergardenSyntax
---@field keyword Color
---@field object Color
---@field type Color
---@field context Color
---@field constant Color
---@field call Color
---@field string Color
---@field macro Color
---@field annotation Color

local M = {}

---@param colors EvergardenColors
---@param config EvergardenConfig
---@return EvergardenTheme
function M.setup(colors, config)
  local theme   = {}

  theme.none    = { 'NONE', 0 }
  theme.colors  = colors

  theme.bg      = theme.none
  if not config.transparent_background then
    theme.bg = colors.bg0
    if config.contrast_dark == 'hard' then
      theme.bg = colors.bg0_hard
    end
    if config.contrast_dark == 'soft' then
      theme.bg = colors.bg0_soft
    end
  end
  theme.base    = { fg = colors.bg0, bg = theme.bg }
  theme.fg      = colors.fg

  theme.bg0     = colors.bg0
  theme.bg1     = colors.bg1
  theme.bg2     = colors.bg2
  theme.bg3     = colors.bg3

  theme.fg0     = colors.grey0
  theme.fg1     = colors.fg
  theme.fg2     = colors.grey1

  theme.comment = theme.fg2

  theme.ike     = colors.aqua
  theme.shinme  = colors.green
  theme.sakura  = colors.red
  theme.taiyo   = colors.orange
  theme.sakaeru = colors.yellow
  theme.sukai   = colors.blue
  theme.sage    = colors.aqua
  theme.seiun   = colors.purple

  theme.syntax  = {
    keyword = theme.sakura,
    object = theme.fg1,
    type = theme.sakaeru,
    context = theme.fg0,
    constant = theme.seiun,
    call = theme.shinme,
    string = theme.shinme,
    macro = theme.sukai,
    annotation = theme.sakura,
  }

  theme.style = {
    search = { reverse = true }
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M
