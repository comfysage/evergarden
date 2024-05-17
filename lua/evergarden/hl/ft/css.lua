---@param theme evergarden.types.theme
---@param config evergarden.types.config
---@return evergarden.types.hlgroups
return function(theme, config)
  return {
    ['@property.css'] = { theme.sukai },
    -- tag
    ['@tag.css'] = { theme.syntax.keyword },
    -- #id
    ['@constant.css'] = { theme.syntax.constant },
    -- .class
    ['@type.css'] = { link = '@type' },
    -- % or literals
    ['@string.css'] = { link = 'NonText' },
  }
end
