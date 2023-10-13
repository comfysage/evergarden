local evergarden = {}

---@class EvergardenConfig
---@field transparent_background boolean
---@field contrast_dark 'hard'|'medium'|'soft'
---@field override_terminal boolean
---@field style StyleConfig
---@field overrides HLGroups

---@type EvergardenConfig
evergarden.default_config = {
    transparent_background = false,
    contrast_dark = 'medium',
    override_terminal = true,
    style = {
        tabline = { reverse = true, color = 'green' },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
    },
    overrides = {},
}

_G.evergarden_config = vim.tbl_deep_extend("force", evergarden.default_config, _G.evergarden_config or {})

function evergarden.setup(config)
    _G.evergarden_config = vim.tbl_deep_extend("force", _G.evergarden_config, config or {})
end

---@param group string
---@param colors ColorSpec
local function set_hi(group, colors)
    if not vim.tbl_isempty(colors) then
        colors.fg = colors[1] and colors[1][1] or 'NONE'
        colors.bg = colors[2] and colors[2][1] or 'NONE'
        colors.ctermfg = colors[1] and colors[1][2] or 'NONE'
        colors.ctermbg = colors[2] and colors[2][2] or 'NONE'
        colors[1] = nil
        colors[2] = nil
        vim.api.nvim_set_hl(0, group, colors)
    end
end

---@param hlgroups HLGroups
local function set_highlights(hlgroups)
    vim.cmd("highlight Normal guifg=" .. hlgroups.Normal[1][1] .. " guibg=" .. hlgroups.Normal[2][1].. " ctermfg=" .. hlgroups.Normal[1][2] .. " ctermbg=" .. hlgroups.Normal[2][2])
    hlgroups.Normal = nil
    for group, colors in pairs(hlgroups) do
        set_hi(group, colors)
    end
end

function evergarden.load(_)
    if vim.g.colors_name then
        vim.cmd('hi clear')
    end

    vim.g.colors_name = 'evergarden'
    vim.o.termguicolors = true

    if vim.o.background == 'light' then
        _G.evergarden_config.theme = 'light'
    elseif vim.o.background == 'dark' then
        _G.evergarden_config.theme = 'default'
    end

    local theme = require 'evergarden.colors'.setup()
    local hlgroups = require 'evergarden.hl.init'.setup(theme, _G.evergarden_config)

    set_highlights(hlgroups)
end

function evergarden.colors()
    require 'evergarden.colors'
    return _G.evergarden_colors
end

return evergarden
