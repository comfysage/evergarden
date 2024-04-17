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
    },
    overrides = {},
}

---@type evergarden.types.config
_G.evergarden_config = vim.tbl_deep_extend("force", evergarden.default_config, _G.evergarden_config or {})

---@param config evergarden.types.config|table
function evergarden.setup(config)
    _G.evergarden_config = vim.tbl_deep_extend("force", _G.evergarden_config, config or {})
end

---@param group string
---@param colors evergarden.types.colorspec
local function set_hi(group, colors)
    if not vim.tbl_isempty(colors) then
        ---@type vim.api.keyset.highlight
        local color = colors
        color.fg = colors[1] and colors[1][1] or 'NONE'
        color.bg = colors[2] and colors[2][1] or 'NONE'
        color.ctermfg = colors[1] and colors[1][2] or 'NONE'
        color.ctermbg = colors[2] and colors[2][2] or 'NONE'
        color[1] = nil
        color[2] = nil
        vim.api.nvim_set_hl(0, group, color)
    end
end

---@param hlgroups evergarden.types.hlgroups
local function set_highlights(hlgroups)
    vim.cmd("highlight Normal guifg=" .. hlgroups.Normal[1][1] .. " guibg=" .. hlgroups.Normal[2][1].. " ctermfg=" .. hlgroups.Normal[1][2] .. " ctermbg=" .. hlgroups.Normal[2][2])
    hlgroups.Normal = nil
    for group, colors in pairs(hlgroups) do
        set_hi(group, colors)
    end
end

function evergarden.load(opts)
    if vim.g.colors_name then
        vim.cmd('hi clear')
    end

    vim.g.colors_name = 'evergarden'
    vim.o.termguicolors = true

    -- if vim.o.background == 'light' then
    --     _G.evergarden_config.theme = 'light'
    -- elseif vim.o.background == 'dark' then
    --     _G.evergarden_config.theme = 'default'
    -- end
    local cfg = vim.tbl_deep_extend('force', _G.evergarden_config, opts)

    local theme = require 'evergarden.colors'.setup(cfg)
    local hlgroups = require 'evergarden.hl.init'.setup(theme, cfg)

    set_highlights(hlgroups)
end

function evergarden.colors()
    return require 'evergarden.colors'.colors()
end

return evergarden
