local utils = require 'evergarden.utils'

---@param theme evergarden.types.theme
---@param config evergarden.types.config
return function(theme, config)
  local pmenu_sel_bg = theme.colors[config.editor.completion.selected.color]
    or theme.surface1

  return {
    Normal = {
      theme.text,
      config.editor.transparent_background and theme.none or theme.base,
    },

    Cursor = { bg = theme.cursor, fg = theme.crust },
    lCursor = { link = 'Cursor' },
    CursorIM = { link = 'Cursor' },

    MCursor = { bg = theme.subtext1, fg = theme.crust },
    MCursorVisual = {
      bg = utils.blend(theme.surface1, theme.base, 0.40),
    },
    CursorLine = { theme.none, theme.surface0 },

    Visual = { theme.none, theme.surface1 },

    LineNr = { theme.surface2 },
    CursorLineNr = { theme.overlay2 },
    SignColumn = { theme.overlay1, theme.sign },

    WinSeparator = {
      config.editor.transparent_background and theme.surface0 or theme.surface1,
    },
    VertSplit = { link = 'WinSeparator' },

    TabLine = { theme.overlay1, theme.surface0 },
    TabLineSel = utils.vary_reverse(
      { theme.subtext1, theme.surface0, style = config.style.tabline },
      { fg = theme.crust, bg = theme.accent }
    ),
    TabLineFill = { theme.overlay1 },

    Title = { theme.cherry },
    Dimmed = { theme.overlay1 },
    Conceal = { theme.overlay1 },
    NonText = { theme.overlay0 },
    Folded = { bg = theme.surface2 },
    FoldColumn = { link = 'SignColumn' },

    QuickFixLine = { theme.none, theme.surface0 },

    NormalFloat = {
      theme.text,
      theme.editor.float,
    },
    FloatBorder = utils.vary_reverse({
      theme.overlay0,
      theme.editor.float,
      style = config.editor.float.solid_border and { 'reverse' } or {},
    }, { fg = theme.editor.float, bg = theme.editor.float }),
    FloatTitle = utils.vary_reverse({
      theme.overlay2,
      theme.editor.float,
      style = config.editor.float.solid_border and { 'reverse' } or {},
    }, { fg = theme.crust, bg = theme.accent }),
    StatusLine = {
      theme.colors[config.editor.statusline.active.fg] or theme.subtext0,
      config.editor.transparent_background and theme.none
        or theme.colors[config.editor.statusline.active.bg]
        or theme.mantle,
    },
    StatusLineNC = {
      theme.colors[config.editor.statusline.inactive.fg] or theme.overlay1,
      config.editor.transparent_background and theme.none
        or theme.colors[config.editor.statusline.inactive.bg]
        or theme.mantle,
    },
    FloatShadow = { bg = theme.crust, blend = 80 },
    FloatShadowThrough = { bg = theme.crust, blend = 100 },
    Panel = {
      bg = config.editor.transparent_background and theme.none or theme.mantle,
    },

    OkText = { theme.diagnostic.ok },
    ErrorText = { theme.diagnostic.error },
    WarningText = { theme.diagnostic.warn },
    InfoText = { theme.diagnostic.info },
    HintText = { theme.diagnostic.hint },
    OkFloat = { theme.diagnostic.ok, theme.editor.float },
    ErrorFloat = { theme.diagnostic.error, theme.editor.float },
    WarningFloat = { theme.diagnostic.warn, theme.editor.float },
    InfoFloat = { theme.diagnostic.info, theme.editor.float },
    HintFloat = { theme.diagnostic.hint, theme.editor.float },

    Question = { theme.subtext0 },

    Search = utils.vary_reverse(
      { theme.surface1, theme.none, style = config.style.search },
      { fg = theme.subtext1, bg = theme.surface1 }
    ),
    CurSearch = utils.vary_reverse(
      { theme.editor.search, style = config.style.search },
      {
        fg = utils.vary_color(config, { summer = theme.text }, theme.crust),
        bg = theme.editor.search,
      }
    ),
    IncSearch = utils.vary_reverse(
      { theme.editor.incsearch, style = config.style.incsearch },
      {
        fg = utils.vary_color(config, { summer = theme.text }, theme.crust),
        bg = theme.editor.incsearch,
      }
    ),
    Substitute = { link = 'IncSearch' },

    MsgArea = {
      theme.subtext1,
      config.editor.transparent_background and theme.none or theme.mantle,
    },
    OkMsg = { theme.diagnostic.ok },
    Error = { theme.diagnostic.error },
    ErrorMsg = { link = 'Error' },
    WarningMsg = { theme.diagnostic.warn },
    MoreMsg = { theme.subtext0 },
    ModeMsg = { theme.subtext1 },

    ColorColumn = { theme.none, theme.surface0 },
    CursorColumn = { theme.none, theme.surface0 },

    Directory = { theme.overlay2 },

    Underlined = { style = { 'undercurl' } },

    Ignore = { link = 'Conceal' },

    -- Completion Menu
    Pmenu = { theme.text, theme.editor.completion },
    PmenuBorder = utils.vary_reverse({
      theme.surface0,
      theme.editor.completion,
      style = config.editor.float.solid_border and { 'reverse' } or {},
    }, { fg = theme.editor.completion, bg = theme.editor.completion }),
    PmenuKind = { theme.subtext0 },
    PmenuKindSel = { theme.subtext0, pmenu_sel_bg },
    PmenuExtra = { theme.syntax.annotation },
    PmenuExtraSel = { theme.syntax.annotation, pmenu_sel_bg },
    PmenuSel = {
      bg = pmenu_sel_bg,
      style = config.editor.completion.selected.style or { 'bold' },
    },
    PmenuMatch = { theme.editor.incsearch },

    ComplMatchIns = { link = 'NonText' },
    PreInsert = { link = 'NonText' },
    ComplHint = { link = 'NonText' },
    ComplHintMore = { link = 'MoreMsg' },

    PmenuSbar = { theme.none, theme.surface1 },
    PmenuThumb = { theme.none, theme.overlay0 },

    -- Picker
    PickNormal = { link = 'NormalFloat' },
    PickBorder = { link = 'FloatBorder' },
    PickTitle = { link = 'FloatTitle' },
    PickSel = { theme.accent, theme.surface0, style = { 'bold' } },
    PickMatch = { link = 'PmenuMatch' },
    PickPointer = { theme.accent },
    PickMarker = { theme.yellow },
    PickPrompt = { theme.cherry },

    -- Diffs
    DiffAdd = {
      bg = utils.blend(theme.diff.add, theme.base, 0.16),
    },
    DiffDelete = {
      bg = utils.blend(theme.diff.delete, theme.base, 0.16),
    },
    DiffChange = {
      bg = utils.blend(theme.diff.change, theme.base, 0.08),
    },
    DiffText = {
      bg = utils.blend(theme.diff.change, theme.base, 0.16),
    },
    diffAdded = { link = '@diff.add' },
    diffRemoved = { link = '@diff.delete' },
    diffChanged = { link = '@diff.change' },
    diffFile = { theme.syntax.identifier },
    diffNewFile = { theme.syntax.identifier },
    diffLine = { theme.text },
    Added = { link = '@diff.add' },
    Removed = { link = '@diff.delete' },
    Changed = { link = '@diff.change' },

    -- Spell
    SpellBad = { sp = theme.red, style = config.style.spell },
    SpellCap = { sp = theme.aqua, style = config.style.spell },
    SpellLocal = { sp = theme.aqua, style = config.style.spell },
    SpellRare = { sp = theme.aqua, style = config.style.spell },

    -- WinBar
    WinBar = { theme.subtext0 },
    WinBarNC = { theme.overlay2 },
  }
end
