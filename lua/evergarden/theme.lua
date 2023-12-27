---@class StyleConfig
---@field tabline { reverse: boolean, color: EvergardenColorField }
---@field search { reverse: boolean, inc_reverse: boolean }
---@field types { italic: boolean }
---@field keyword { italic: boolean }
---@field comment { italic: boolean }

---@class EvergardenTheme
---@field none EvergardenColor
---@field colors EvergardenColors
---@field base { fg: EvergardenColor, bg: EvergardenColor }
---@field bg EvergardenColor
---@field fg EvergardenColor
---@field bg0 EvergardenColor
---@field bg1 EvergardenColor
---@field bg2 EvergardenColor
---@field bg3 EvergardenColor
---@field fg0 EvergardenColor
---@field fg1 EvergardenColor
---@field fg2 EvergardenColor
---@field sakura  EvergardenColor
---@field sage    EvergardenColor
---@field sukai   EvergardenColor
---@field shinme  EvergardenColor
---@field sakaeru EvergardenColor
---@field taiyo EvergardenColor
---@field seiun   EvergardenColor
---@field ike     EvergardenColor
---@field syntax EvergardenSyntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: EvergardenColor }
---@field diff { ['add'|'delete'|'change']: EvergardenColor }
---@field style StyleConfig
---@field sign EvergardenColor
---@field comment EvergardenColor
---@field bg_accent EvergardenColor

---@class EvergardenSyntax
---@field keyword EvergardenColor
---@field object EvergardenColor
---@field type EvergardenColor
---@field context EvergardenColor
---@field constant EvergardenColor
---@field call EvergardenColor
---@field string EvergardenColor
---@field macro EvergardenColor
---@field annotation EvergardenColor

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

  local sign_colors = { soft = theme.bg3 }
  theme.sign      = sign_colors[config.contrast_dark] or theme.none
  theme.comment   = theme.fg2
  theme.bg_accent = theme.bg2

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
    macro = theme.taiyo,
    annotation = theme.sakura,
  }
  theme.diagnostic = {
    ok = theme.shinme,
    error = theme.sakura,
    warn = theme.sakaeru,
    info = theme.sage,
    hint = theme.sukai,
  }
  theme.diff = {
    add = theme.shinme,
    delete = theme.sakura,
    change = theme.sage,
  }

  theme.style = {
    search = { reverse = true }
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M
