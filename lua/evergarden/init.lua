local evergarden = {}

---@class evergarden.types.config
---@field transparent_background boolean
---@field contrast_dark 'hard'|'medium'|'soft'
---@field override_terminal boolean
---@field style evergarden.types.styleconfig
---@field overrides evergarden.types.hlgroups

---@type evergarden.types.config
evergarden.default_config = {
  transparent_background = false,
  contrast_dark = 'medium',
  override_terminal = true,
  style = {
    tabline = { reverse = true, color = 'green' },
    search = { reverse = false, inc_reverse = true },
    types = { italic = true },
    keyword = { italic = true },
    comment = { italic = false },
    sign = { highlight = false },
  },
  overrides = {},
}

---@type evergarden.types.config
_G.evergarden_config = vim.tbl_deep_extend(
  'force',
  evergarden.default_config,
  _G.evergarden_config or {}
)

---@param config evergarden.types.config|table
function evergarden.setup(config)
  _G.evergarden_config =
    vim.tbl_deep_extend('force', _G.evergarden_config, config or {})
end

---@param group string
---@param colors evergarden.types.colorspec
local function set_hi(group, colors)
  if type(colors) ~= 'table' or vim.tbl_isempty(colors) then
    return
  end

  colors.fg = colors.fg or colors[1] or 'none'
  colors.bg = colors.bg or colors[2] or 'none'

  ---@type vim.api.keyset.highlight
  local color = vim.deepcopy(colors)

  color.fg = type(colors.fg) == 'table' and colors.fg[1] or colors.fg
  color.bg = type(colors.bg) == 'table' and colors.bg[1] or colors.bg
  color.ctermfg = type(colors.fg) == 'table' and colors.fg[2] or 'none'
  color.ctermbg = type(colors.bg) == 'table' and colors.bg[2] or 'none'
  color[1] = nil
  color[2] = nil
  color.name = nil

  vim.api.nvim_set_hl(0, group, color)
end

---@param hlgroups evergarden.types.hlgroups
local function set_highlights(hlgroups)
  ---@type evergarden.types.colorspec
  local color = hlgroups.Normal
  color.fg = color.fg or color[1] or 'none'
  color.bg = color.bg or color[2] or 'none'
  local normal = {}
  normal.fg = type(color.fg) == 'table' and color.fg[1] or color.fg
  normal.bg = type(color.bg) == 'table' and color.bg[1] or color.bg
  normal.ctermfg = type(color.fg) == 'table' and color.fg[2] or 'none'
  normal.ctermbg = type(color.bg) == 'table' and color.bg[2] or 'none'
  vim.api.nvim_set_hl(0, 'Normal', normal)
  hlgroups.Normal = nil
  for group, colors in pairs(hlgroups) do
    set_hi(group, colors)
  end
end

function evergarden.load(opts)
  if vim.g.colors_name then
    vim.cmd 'hi clear'
  end

  vim.g.colors_name = 'evergarden'
  vim.o.termguicolors = true

  -- if vim.o.background == 'light' then
  --     _G.evergarden_config.theme = 'light'
  -- elseif vim.o.background == 'dark' then
  --     _G.evergarden_config.theme = 'default'
  -- end
  local cfg = vim.tbl_deep_extend('force', _G.evergarden_config, opts)

  local theme = require('evergarden.colors').setup(cfg)
  local hlgroups = require('evergarden.hl.init').setup(theme, cfg)

  set_highlights(hlgroups)
end

function evergarden.colors()
  return require('evergarden.colors').colors()
end

return evergarden
