local theme = require 'evergarden.colors'.setup {}

local colors = {
  normal = theme.shinme[1],
  insert = theme.syntax.object[1],
  visual = theme.syntax.constant[1],

  fg0 = theme.fg0[1],
  fg1 = theme.fg1[1],
  base = {
    fg = theme.base.fg[1],
    bg = theme.base.bg[1],
  },
  bg1 = theme.bg1[1],
  bg2 = theme.bg2[1],
}

local evergarden = {}

evergarden.normal = {
  a = { fg = colors.base.fg, bg = colors.normal },
  b = { bg = colors.bg1, fg = colors.normal },
  c = { bg = colors.base.fg, fg = colors.fg0 },
}

evergarden.insert = {
  a = { fg = colors.base.fg, bg = colors.insert },
  b = { bg = colors.bg1, fg = colors.insert },
}

evergarden.command = evergarden.normal

evergarden.visual = {
  a = { fg = colors.base.fg, bg = colors.visual },
  b = { bg = colors.bg1, fg = colors.visual },
}

evergarden.replace = evergarden.insert

evergarden.inactive = {
  a = { bg = colors.base.bg, fg = colors.fg1 },
  b = { bg = colors.base.bg, fg = colors.fg1 },
  c = { bg = colors.base.bg, fg = colors.fg1 },
}

return evergarden
