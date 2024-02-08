local M = {}

---@alias evergarden.types.colorspec { [1]: Color, [2]: Color, link: string, reverse: boolean }
---@alias evergarden.types.hlgroups { [string]: evergarden.types.colorspec }

---@param theme evergarden.types.theme
---@param config evergarden.types.config
function M.setup(theme, config)
  ---@type evergarden.types.hlgroups
  local hl_groups = {
    Normal = { theme.fg, theme.bg },
    Statement = { theme.syntax.keyword },
    Keyword = { theme.syntax.keyword, italic = config.style.keyword.italic },
    Identifier = { theme.syntax.object },
    Type = { theme.syntax.type, italic = config.style.types.italic },
    Function = { theme.syntax.call },
    Structure = { theme.syntax.type },

    Comment = { theme.comment, italic = config.style.comment.italic },

    Special = { theme.syntax.context },
    Delimiter = { theme.syntax.context },
    Operator = { theme.syntax.context },
    MatchParen = { theme.taiyo },

    Constant = { theme.syntax.constant },
    String = { theme.syntax.string },

    Cursor = { theme.sakaeru },
    CursorLine   = { theme.none, theme.bg1 },
    CursorColumn = { theme.none, theme.bg1 },
    QuickFixLine = { theme.none, theme.bg1 },

    Visual = { theme.none, theme.bg3 },

    LineNr = { theme.bg2 },
    CursorLineNr = { theme.comment },
    SignColumn = { theme.none, theme.sign },
    WinSeparator = { theme.bg2 },
    VertSplit    = { link = "WinSeparator" },
    TabLineSel = config.style.tabline.reverse and { theme.base.fg, theme.colors[config.style.tabline.color] } or { theme.colors[config.style.tabline.color], theme.base.bg },
    TabLine = { theme.comment, theme.bg },
    TabLineFill = { link = 'TabLine' },
    Title = { theme.comment },
    NonText = { theme.bg2, theme.none },
    Folded = { theme.comment },
    FoldColumn = { theme.bg1 },

    NormalFloat        = { theme.fg, theme.bg },
    FloatBorder        = { theme.bg2 },
    StatusLine         = { theme.fg2, theme.none },
    StatusLineNC       = { theme.fg2, theme.bg1 },
    FloatShadow        = { theme.none, theme.none },
    FloatShadowThrough = { theme.none, theme.none },

    OkText       = { theme.diagnostic.ok,    theme.none      },
    ErrorText    = { theme.diagnostic.error, theme.none      },
    WarningText  = { theme.diagnostic.warn,  theme.none      },
    InfoText     = { theme.diagnostic.info,  theme.none      },
    HintText     = { theme.diagnostic.hint,  theme.none      },
    OkFloat      = { theme.diagnostic.ok,    theme.bg_accent },
    ErrorFloat   = { theme.diagnostic.error, theme.bg_accent },
    WarningFloat = { theme.diagnostic.warn,  theme.bg_accent },
    InfoFloat    = { theme.diagnostic.info,  theme.bg_accent },
    HintFloat    = { theme.diagnostic.hint,  theme.bg_accent },

    Question = { theme.comment },

    Search = { theme.taiyo, reverse = config.style.search.reverse },
    IncSearch = { theme.taiyo, reverse = config.style.search.inc_reverse },

    Error      = { theme.diagnostic.error },
    ErrorMsg   = { link = "Error" },
    WarningMsg = { theme.diagnostic.warn },
    MoreMsg = { theme.comment },
    ModeMsg = { theme.bg2, theme.none },

    ColorColumn = { theme.none, theme.bg1 },

    Todo = { theme.base.fg, theme.seiun },

    PreProc = { theme.syntax.annotation },
    Include = { theme.syntax.annotation },

    Directory = { theme.colors.grey1 },

    Conceal = { theme.bg3 },

    Underlined = { theme.none, theme.none },

    -- Completion Menu
    Pmenu = { theme.fg1, theme.bg2 },
    PmenuSel = { theme.bg2, theme.shinme, reverse = theme.style.search.reverse },
    PmenuSbar = { theme.none, theme.bg2 },
    PmenuThumb = { theme.none, theme.fg2 },

    -- Diffs
    DiffAdd    = { theme.diff.add,    theme.bg },
    DiffDelete = { theme.diff.delete, theme.bg },
    DiffChange = { theme.diff.change, theme.bg },
    DiffText   = { theme.fg0, theme.bg },
    diffAdded   = { theme.diff.add    },
    diffRemoved = { theme.diff.delete },
    diffChanged = { theme.diff.change },
    diffFile    = { theme.syntax.object },
    diffNewFile = { theme.syntax.object },
    diffLine    = { theme.syntax.context },

    -- Spell
    SpellCap   = { theme.shinme },
    SpellBad   = { theme.sage },
    SpellLocal = { theme.sage },
    SpellRare  = { theme.seiun },

    -- Diagnostics
    DiagnosticFloatingError = { link = "ErrorFloat" },
    DiagnosticFloatingWarn  = { link = "WarningFloat" },
    DiagnosticFloatingInfo  = { link = "InfoFloat" },
    DiagnosticFloatingHint  = { link = "HintFloat" },
    DiagnosticFloatingOk    = { link = "OkFloat" },
    DiagnosticOk            = { theme.diagnostic.ok    },
    DiagnosticError         = { theme.diagnostic.error },
    DiagnosticWarn          = { theme.diagnostic.warn  },
    DiagnosticInfo          = { theme.diagnostic.info  },
    DiagnosticHint          = { theme.diagnostic.hint  },
    DiagnosticVirtualTextError           = { link = "DiagnosticError" },
    DiagnosticVirtualTextWarn            = { link = "DiagnosticWarn" },
    DiagnosticVirtualTextInfo            = { link = "DiagnosticInfo" },
    DiagnosticVirtualTextHint            = { link = "DiagnosticHint" },
    DiagnosticUnderlineOk                = { theme.diagnostic.ok,    theme.none, underline = true },
    DiagnosticUnderlineError             = { theme.diagnostic.error, theme.none, underline = true },
    DiagnosticUnderlineWarn              = { theme.diagnostic.warn,  theme.none, underline = true },
    DiagnosticUnderlineInfo              = { theme.diagnostic.info,  theme.none, underline = true },
    DiagnosticUnderlineHint              = { theme.diagnostic.hint,  theme.none, underline = true },
    DiagnosticSignOk                     = { theme.diagnostic.ok,    theme.sign },
    DiagnosticSignError                  = { theme.diagnostic.error, theme.sign },
    DiagnosticSignWarn                   = { theme.diagnostic.warn,  theme.sign },
    DiagnosticSignInfo                   = { theme.diagnostic.info,  theme.sign },
    DiagnosticSignHint                   = { theme.diagnostic.hint,  theme.sign },
    LspDiagnosticsFloatingError          = { link = "DiagnosticFloatingError" },
    LspDiagnosticsFloatingWarning        = { link = "DiagnosticFloatingWarn" },
    LspDiagnosticsFloatingInformation    = { link = "DiagnosticFloatingInfo" },
    LspDiagnosticsFloatingHint           = { link = "DiagnosticFloatingHint" },
    LspDiagnosticsDefaultError           = { link = "DiagnosticError" },
    LspDiagnosticsDefaultWarning         = { link = "DiagnosticWarn" },
    LspDiagnosticsDefaultInformation     = { link = "DiagnosticInfo" },
    LspDiagnosticsDefaultHint            = { link = "DiagnosticHint" },
    LspDiagnosticsVirtualTextError       = { link = "DiagnosticVirtualTextError" },
    LspDiagnosticsVirtualTextWarning     = { link = "DiagnosticVirtualTextWarn" },
    LspDiagnosticsVirtualTextInformation = { link = "DiagnosticVirtualTextInfo" },
    LspDiagnosticsVirtualTextHint        = { link = "DiagnosticVirtualTextHint" },
    LspDiagnosticsUnderlineError         = { link = "DiagnosticUnderlineError" },
    LspDiagnosticsUnderlineWarning       = { link = "DiagnosticUnderlineWarn" },
    LspDiagnosticsUnderlineInformation   = { link = "DiagnosticUnderlineInfo" },
    LspDiagnosticsUnderlineHint          = { link = "DiagnosticUnderlineHint" },
    LspDiagnosticsSignError              = { link = "DiagnosticSignError" },
    LspDiagnosticsSignWarning            = { link = "DiagnosticSignWarn" },
    LspDiagnosticsSignInformation        = { link = "DiagnosticSignInfo" },
    LspDiagnosticsSignHint               = { link = "DiagnosticSignHint" },
    LspReferenceText                     = { link = "CurrentWord" },
    LspReferenceRead                     = { link = "CurrentWord" },
    LspReferenceWrite                    = { link = "CurrentWord" },
    LspCodeLens                          = { link = "VirtualTextInfo" },
    LspCodeLensSeparator                 = { link = "VirtualTextHint" },
    LspSignatureActiveParameter          = { link = "Search" },
    healthError                          = { link = "DiagnosticError" },
    healthSuccess                        = { link = "DiagnosticOk" },
    healthWarning                        = { link = "DiagnosticWarn" },
    DiagnosticDeprecated = { theme.diagnostic.warn, theme.none, strikethrough = true }
  }

  if vim.fn.has('nvim-0.8.0') then
    hl_groups['@annotation']            = { link = "TSAnnotation" }
    hl_groups['@attribute']             = { link = "TSAttribute" }
    hl_groups['@boolean']               = { link = "TSBoolean" }
    hl_groups['@character']             = { link = "TSCharacter" }
    hl_groups['@comment']               = { link = "TSComment" }
    hl_groups['@conditional']           = { link = "TSConditional" }
    hl_groups['@constant']              = { link = "TSConstant" }
    hl_groups['@constant.builtin']      = { link = "TSConstBuiltin" }
    hl_groups['@constant.macro']        = { link = "TSConstMacro" }
    hl_groups['@constructor']           = { link = "TSConstructor" }
    hl_groups['@exception']             = { link = "TSException" }
    hl_groups['@field']                 = { link = "TSField" }
    hl_groups['@float']                 = { link = "TSFloat" }
    hl_groups['@function']              = { link = "TSFunction" }
    hl_groups['@function.call']         = { link = "TSFunction" }
    hl_groups['@function.builtin']      = { link = "TSFuncBuiltin" }
    hl_groups['@function.macro']        = { link = "TSFuncMacro" }
    hl_groups['@include']               = { link = "TSInclude" }
    hl_groups['@keyword']               = { link = "TSKeyword" }
    hl_groups['@keyword.function']      = { link = "TSKeywordFunction" }
    hl_groups['@keyword.operator']      = { link = "TSKeywordOperator" }
    hl_groups['@label']                 = { link = "TSLabel" }
    hl_groups['@method']                = { link = "TSMethod" }
    hl_groups['@method.call']           = { link = "@function.call" }
    hl_groups['@namespace']             = { link = "TSNamespace" }
    hl_groups['@none']                  = { link = "TSNone" }
    hl_groups['@number']                = { link = "TSNumber" }
    hl_groups['@operator']              = { link = "TSOperator" }
    hl_groups['@parameter']             = { link = "TSParameter" }
    hl_groups['@parameter.reference']   = { link = "TSParameterReference" }
    hl_groups['@property']              = { link = "TSProperty" }
    hl_groups['@punctuation.bracket']   = { link = "TSPunctBracket" }
    hl_groups['@punctuation.delimiter'] = { link = "TSPunctDelimiter" }
    hl_groups['@punctuation.special']   = { link = "TSPunctSpecial" }
    hl_groups['@repeat']                = { link = "TSRepeat" }
    hl_groups['@storageclass']          = { link = "TSStorageClass" }
    hl_groups['@string']                = { link = "TSString" }
    hl_groups['@string.escape']         = { link = "TSStringEscape" }
    hl_groups['@string.regex']          = { link = "TSStringRegex" }
    hl_groups['@symbol']                = { link = "TSSymbol" }
    hl_groups['@tag']                   = { link = "TSTag" }
    hl_groups['@tag.delimiter']         = { link = "TSTagDelimiter" }
    hl_groups['@text']                  = { link = "TSText" }
    hl_groups['@strike']                = { link = "TSStrike" }
    hl_groups['@math']                  = { link = "TSMath" }
    hl_groups['@type']                  = { link = "TSType" }
    hl_groups['@type.builtin']          = { link = "TSTypeBuiltin" }
    hl_groups['@type.qualifier']        = { link = "TSKeyword" }
    hl_groups['@uri']                   = { link = "TSURI" }
    hl_groups['@variable']              = { link = "TSVariable" }
    hl_groups['@variable.builtin']      = { link = "TSVariableBuiltin" }

    --[[ local captures = require 'adachi.hl.treesitter'.captures(theme)
    for l_name, higroups in pairs(captures) do
      for capture_name, higroup in pairs(higroups) do
        hlGroups[capture_name .. '.' .. l_name] = higroup
      end
    end ]]
  end

  -- merge treesitter hl groups
  hl_groups = vim.tbl_extend('force', hl_groups, require 'evergarden.hl.treesitter'(theme, config))

  -- lsp
  hl_groups['@none'] = { theme.fg }

  hl_groups['@constructor.lua'] = { theme.syntax.context }

  hl_groups['@lsp.type.namespace'] = { link = "TSNamespace" }
  hl_groups['@lsp.type.keyword.lua'] = { link = "TSKeyword" }

  hl_groups['@tag.html'] = { theme.syntax.keyword }
  hl_groups['@tag.delimiter.html'] = { theme.syntax.context }
  hl_groups['@tag.attribute.html'] = { theme.fg0 }
  hl_groups['@string.html'] = { theme.sukai }

  hl_groups['@lsp.type.macro.rust'] = { theme.syntax.macro }

  -- fix lsp hover doc
  hl_groups['@none.markdown'] = { theme.none, theme.none }
  hl_groups['@text.emphasis'] = { theme.taiyo, italic = true }

  -- hl_groups['@include.typescript'] = { theme.syntax.keyword }

  hl_groups['markdownH1'] = { theme.seiun }
  hl_groups['markdownH2'] = { theme.taiyo }
  hl_groups['markdownH3'] = { theme.shinme }
  hl_groups['markdownH4'] = { link = "markdownH1" }
  hl_groups['markdownH5'] = { link = "markdownH2" }
  hl_groups['markdownH6'] = { link = "markdownH3" }

  -- Telescope
  hl_groups['TelescopeMatching']       = { link = "Search" }
  hl_groups['TelescopeSelection']      = { link = "Identifier" }
  hl_groups['TelescopePromptPrefix']   = { link = "Constant" }
  hl_groups['TelescopeNormal']         = { theme.syntax.context }
  hl_groups['TelescopeSelectionCaret'] = { link = "TelescopeNormal" }

  hl_groups['TelescopeBorder']        = { theme.bg2 }
  hl_groups['TelescopePromptBorder']  = { link = "TelescopeBorder" }
  hl_groups['TelescopeResultsBorder'] = { link = "TelescopeBorder" }
  hl_groups['TelescopePreviewBorder'] = { link = "TelescopeBorder" }

  -- GitSigns
  hl_groups['GitGutterAdd']    = { theme.diff.add,    theme.sign }
  hl_groups['GitGutterChange'] = { theme.diff.change, theme.sign }
  hl_groups['GitGutterDelete'] = { theme.diff.delete, theme.sign }
  hl_groups['GitGutterChangeDelete'] = { link = 'GitGutterChange' }

  -- Cmp
  hl_groups['CmpItemMenu'] = { theme.syntax.constant, italic = true }

  hl_groups['CmpItemKindText']  = { theme.fg1 }
  hl_groups['CmpItemKindMethod']  = { theme.syntax.constant }
  hl_groups['CmpItemKindFunction']  = { theme.syntax.call }
  hl_groups['CmpItemKindConstructor']  = { theme.syntax.type }
  hl_groups['CmpItemKindField']  = { theme.syntax.object }
  hl_groups['CmpItemKindVariable']  = { theme.syntax.object }
  hl_groups['CmpItemKindClass']  = { theme.syntax.type }
  hl_groups['CmpItemKindInterface']  = { theme.syntax.type }
  hl_groups['CmpItemKindModule']  = { theme.syntax.keyword }
  hl_groups['CmpItemKindProperty']  = { theme.syntax.keyword }
  hl_groups['CmpItemKindUnit']  = { theme.syntax.constant }
  hl_groups['CmpItemKindValue']  = { theme.syntax.constant }
  hl_groups['CmpItemKindEnum']  = { theme.syntax.constant }
  hl_groups['CmpItemKindKeyword']  = { theme.syntax.keyword }
  hl_groups['CmpItemKindSnippet']  = { theme.syntax.macro }
  hl_groups['CmpItemKindColor']  = { theme.syntax.constant }
  hl_groups['CmpItemKindFile']  = { theme.syntax.type }
  hl_groups['CmpItemKindReference']  = { theme.fg0 }
  hl_groups['CmpItemKindFolder']  = { theme.syntax.type }
  hl_groups['CmpItemKindEnumMember']  = { theme.syntax.constant }
  hl_groups['CmpItemKindConstant']  = { theme.syntax.constant }
  hl_groups['CmpItemKindStruct']  = { theme.syntax.type }
  hl_groups['CmpItemKindEvent']  = { theme.syntax.keyword }
  hl_groups['CmpItemKindOperator']  = { link = "Operator" }
  hl_groups['CmpItemKindTypeParameter']  = { theme.syntax.type }

  hl_groups['CmpItemAbbrDeprecated'] = { link = "Comment" }

  hl_groups['CmpItemAbbrMatch']      = { link = "Search" }
  hl_groups['CmpItemAbbrMatchFuzzy'] = { link = "CmpItemAbbrMatch" }

  -- lukas-reineke/indent-blankline.nvim
  hl_groups['IndentBlanklineIndent1'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent2'] = { theme.colors.red, nocombine = true }
  hl_groups['IndentBlanklineIndent3'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent4'] = { theme.colors.orange, nocombine = true }
  hl_groups['IndentBlanklineIndent3'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent4'] = { theme.colors.yellow, nocombine = true }
  hl_groups['IndentBlanklineIndent5'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent6'] = { theme.colors.green, nocombine = true }
  hl_groups['IndentBlanklineIndent7'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent8'] = { theme.colors.aqua, nocombine = true }
  hl_groups['IndentBlanklineIndent9'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent10'] = { theme.colors.blue, nocombine = true }
  hl_groups['IndentBlanklineIndent11'] = { theme.bg2, nocombine = true }
  hl_groups['IndentBlanklineIndent12'] = { theme.colors.purple, nocombine = true }

  -- simrat39/symbols-outline.nvim
  hl_groups['FocusedSymbol'] = { theme.syntax.call }

  if config.override_terminal then
    require 'evergarden.hl.terminal'(theme, theme.colors)
  end

  for hl, override in pairs(config.overrides or {}) do
    if hl_groups[hl] and not vim.tbl_isempty(override) then
      hl_groups[hl].link = nil
    end
    hl_groups[hl] = vim.tbl_deep_extend("force", hl_groups[hl] or {}, override)
  end

  return hl_groups
end

return M
