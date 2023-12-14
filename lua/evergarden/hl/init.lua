local M = {}

---@alias ColorSpec { [1]: Color, [2]: Color, link: string, reverse: boolean }
---@alias HLGroups { [string]: ColorSpec }

---@param theme EvergardenTheme
---@param config EvergardenConfig
function M.setup(theme, config)
  ---@type HLGroups
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

    NormalFloat        = { theme.fg, theme.bg_accent },
    FloatShadow        = { theme.none, theme.none },
    FloatShadowThrough = { theme.none, theme.none },

    Search = { theme.taiyo, reverse = config.style.search.reverse },
    IncSearch = { theme.taiyo, reverse = config.style.search.inc_reverse },

    Error = { theme.sakura },
    ErrorMsg = { link = "Error" },
    WarningMsg = { link = "Error" },
    MoreMsg = { theme.comment },
    ModeMsg = { theme.bg2, theme.none },

    ColorColumn = { theme.none, theme.bg1 },

    Todo = { theme.base.fg, theme.seiun },

    PreProc = { theme.syntax.annotation },
    Include = { theme.syntax.annotation },

    Directory = { theme.colors.grey1 },

    Underlined = { theme.none, theme.none },

    -- Treesitter
    --[[ TSStrong    = { theme.none, theme.none, bold = theme.bold.general },
    TSEmphasis  = { theme.none, theme.none, italic = theme.italic.general },
    TSUnderline = { theme.none, theme.none, underline = theme.underline.general },
    TSNote      = { theme.blue, theme.bg0, bold = theme.bold.general },
    TSWarning   = { theme.yellow, theme.bg0, bold = theme.bold.general },
    TSDanger    = { theme.red, theme.bg0, bold = theme.bold.general }, ]]

    TSAnnotation         = { theme.seiun },
    TSAttribute          = { theme.seiun },
    TSBoolean            = { link = "Boolean" },
    TSCharacter          = { link = "Character" },
    TSComment            = { link = "Comment" },
    TSConditional        = { link = "Conditional" },
    TSConstBuiltin       = { link = "Constant" },
    TSConstMacro         = { link = "Constant" },
    TSConstant           = { link = "Constant" },
    TSConstructor        = { theme.shinme },
    TSException          = { link = "Exception" },
    TSField              = { theme.syntax.object },
    TSFloat              = { link = "Float" },
    TSFuncBuiltin        = { link = "Constant" },
    TSFuncMacro          = { theme.syntax.macro },
    TSFunction           = { link = "Function" },
    TSInclude            = { link = "Include" },
    TSKeyword            = { link = "Keyword" },
    TSKeywordFunction    = { link = "Keyword" },
    TSKeywordOperator    = { theme.taiyo },
    TSLabel              = { link = "Label" },
    TSMethod             = { theme.syntax.context },
    TSNamespace          = { link = "Constant" },
    TSNone               = { link = "Normal" },
    TSNumber             = { link = "Number" },
    TSOperator           = { link = "Operator" },
    TSParameter          = { link = "Identifier" },
    TSParameterReference = { link = "TSParameter" },
    TSProperty           = { theme.syntax.object },
    TSPunctBracket       = { theme.syntax.context },
    TSPunctDelimiter     = { link = "Delimiter" },
    TSPunctSpecial       = { link = "Special" },
    TSRepeat             = { link = "Repeat" },
    TSStorageClass       = { link = "StorageClass" },
    TSString             = { link = "String" },
    TSStringEscape       = { theme.sakaeru },
    TSStringRegex        = { theme.sakaeru },
    TSSymbol             = { theme.fg1 },
    TSTag                = { link = "Tag" },
    TSTagDelimiter       = { theme.fg1 },
    TSText               = { theme.fg1 },
    TSStrike             = { theme.fg2 },
    TSMath               = { theme.sukai },
    TSType               = { link = "Type" },
    TSTypeBuiltin        = { link = "Type" },
    TSURI                = { link = "markdownUrl" },
    TSVariable           = { link = "Identifier" },
    TSVariableBuiltin    = { link = "Constant" },

    -- Completion Menu
    Pmenu = { theme.fg1, theme.bg2 },
    PmenuSel = { theme.bg2, theme.shinme, reverse = theme.style.search.reverse },
    PmenuSbar = { theme.none, theme.bg2 },
    PmenuThumb = { theme.none, theme.fg2 },

    -- Diffs
    DiffDelete = { theme.sakura, theme.bg },
    DiffAdd = { theme.shinme, theme.bg },
    DiffChange = { theme.ike, theme.bg },
    DiffText = { theme.fg, theme.bg },
    diffAdded   = { link = 'DiffAdd' },
    diffRemoved = { link = 'DiffDelete' },
    diffChanged = { link = 'DiffChange' },
    diffFile    = { theme.syntax.object },
    diffNewFile = { theme.syntax.object },
    diffLine    = { theme.syntax.context },

    -- Spell
    SpellCap   = { theme.shinme },
    SpellBad   = { theme.sage },
    SpellLocal = { theme.sage },
    SpellRare  = { theme.seiun },

    -- Diagnostics
    DiagnosticFloatingError              = { link = "ErrorFloat" },
    DiagnosticFloatingWarn               = { link = "WarningFloat" },
    DiagnosticFloatingInfo               = { link = "InfoFloat" },
    DiagnosticFloatingHint               = { link = "HintFloat" },
    --[[ DiagnosticError                      = { link = "AdachiRedDark" },
    DiagnosticWarn                       = { link = "AdachiYellowDark" },
    DiagnosticInfo                       = { link = "AdachiAquaDark" }, ]]
    -- DiagnosticHint                       = { link = "AdachiAquaDark" },
    DiagnosticOk = { theme.shinme },
    DiagnosticError = { theme.sakura },
    DiagnosticWarn = { theme.sakaeru },
    DiagnosticInfo = { theme.sage },
    DiagnosticHint = { theme.sukai },
    DiagnosticVirtualTextError           = { link = "DiagnosticError" },
    DiagnosticVirtualTextWarn            = { link = "DiagnosticWarn" },
    DiagnosticVirtualTextInfo            = { link = "DiagnosticInfo" },
    DiagnosticVirtualTextHint            = { link = "DiagnosticHint" },
    DiagnosticUnderlineError             = { link = "ErrorText" },
    DiagnosticUnderlineWarn              = { link = "WarningText" },
    DiagnosticUnderlineInfo              = { link = "InfoText" },
    DiagnosticUnderlineHint              = { link = "HintText" },
    DiagnosticSignError                  = { link = "AdachiRedSign" },
    DiagnosticSignWarn                   = { link = "AdachiYellowSign" },
    DiagnosticSignInfo                   = { link = "AdachiBlueSign" },
    DiagnosticSignHint                   = { link = "AdachiGreenSign" },
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
    healthSuccess                        = { link = "AdachiGreenDark" },
    healthWarning                        = { link = "DiagnosticWarn" },
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

  -- lsp
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
  hl_groups['GitGutterAdd']    = { link = "DiffAdd" }
  hl_groups['GitGutterChange'] = { link = "DiffChange" }
  hl_groups['GitGutterDelete'] = { link = "DiffDelete" }
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
  hl_groups['CmpItemKindReference']  = { theme.fg1 }
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
