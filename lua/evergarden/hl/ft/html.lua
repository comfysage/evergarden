---@param theme evergarden.types.theme
---@param config evergarden.types.config
---@return evergarden.types.hlgroups
return function(theme, config)
  return {
    ['@tag.html'] = { theme.syntax.keyword },
    ['@tag.delimiter.html'] = { theme.syntax.context },
    ['@tag.attribute.html'] = { theme.fg0 },
    ['@string.html'] = { theme.blue },
  }
end
