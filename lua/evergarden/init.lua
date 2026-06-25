--- *evergarden*
--- cozy evergarden theme for neovim
---
--- for configuration see |evergarden.config|
---@module 'evergarden'

local config = require 'evergarden.config'

local evergarden = {}

--- override the global config with custom options.
--- for configuration see |evergarden.config|
---@param cfg? evergarden.types.config|table
function evergarden.setup(cfg)
  cfg = cfg or {}
  config.set(cfg)
end

--- setup highlights using `cfg`.
--- can be used to temporarily override the global config.
---@param cfg? evergarden.types.config|table
function evergarden.load(cfg)
  if vim.g.colors_name then
    vim.cmd 'hi clear'
  end

  if cfg then
    cfg = config.override(cfg or {})
  else
    cfg = config.get()
  end

  vim.g.colors_name = 'evergarden'

  if cfg.theme.variant == 'summer' then
    vim.go.background = 'light'
  else
    vim.go.background = 'dark'
  end

  cfg.theme.ansi =
    require('evergarden.utils').nonnil(cfg.theme.ansi, not vim.o.termguicolors)

  local cache = cfg.cache or false
  if cache then
    local needs_compile = require('evergarden.cache').needs_compile(cfg)
    if not needs_compile then
      return require('evergarden.cache').load()
    end
    require('evergarden.cache').clear()
  end

  local theme = require('evergarden.theme').setup(cfg)
  local hlgroups = require('evergarden.hl').setup(theme, cfg)
  require('evergarden.utils').set_highlights(hlgroups)

  if cache then
    require('evergarden.cache').write(cfg)
  end
end

--- returns a table of colors based on the global config.
--- alias for |evergarden.colors.get()|.
function evergarden.colors()
  return require('evergarden.colors').get()
end

return evergarden
