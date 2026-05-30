---@module 'evergarden.utils'

local M = {}

---@private
---@param min number
---@param max number
---@param v number
---@return number
local function clamp(min, max, v)
  return math.max(min, math.min(max, v))
end

local nonnil = vim.nonnil or vim.F.if_nil

---@param group string
---@param colors evergarden.types.colorspec
---@param config? evergarden.types.config
function M.set_hl(group, colors, config)
  config = config or require('evergarden.config').get()

  if type(colors) ~= 'table' or vim.tbl_isempty(colors) then
    return
  end
  if type(group) ~= 'string' then
    return error(
      string.format(
        'type of group was expected to be string but got `%s`',
        vim.inspect(group)
      )
    )
  end

  colors.fg = colors.fg or colors[1] or 'none'
  colors.bg = colors.bg or colors[2] or 'none'

  ---@type vim.api.keyset.highlight
  local color = {
    link = colors.link,
    blend = colors.blend,
    sp = colors.sp,
  }
  if type(colors.fg) == 'string' then
    color.fg = colors.fg
  elseif type(colors.fg) == 'number' then
    color.ctermfg = colors.fg
  end
  if type(colors.bg) == 'string' then
    color.bg = colors.bg
  elseif type(colors.bg) == 'number' then
    color.ctermbg = colors.bg
  end

  local styles = vim
    .iter(ipairs(colors.style or {}))
    :fold({}, function(acc, _, style)
      acc[style] = not vim.tbl_contains(config.style.disable_styles, style)
      return acc
    end)

  color = vim.tbl_extend('force', color, styles)

  local ok, result = pcall(vim.api.nvim_set_hl, 0, group, color)
  if not ok then
    vim.notify(
      ('error while setting highlight (%s):\n\t%s'):format(group, result),
      vim.log.levels.ERROR
    )
  end
  if config.cache then
    require('evergarden.cache').add(group, color)
  end
end

---@param hlgroups evergarden.types.hlgroups.OL
---@param config? evergarden.types.config
function M.set_highlights(hlgroups, config)
  config = config or require('evergarden.config').get()
  require('evergarden.overlay'):new(hlgroups, config):set()
end

---@param style evergarden.types.styleopt
---@return integer?
function M.is_reverse(style)
  if not vim.islist(style) then
    return
  end
  local index = vim.iter(ipairs(style)):find(function(_, s)
    return s == 'reverse'
  end)
  return index
end

---@param t table
---@param default any
---@param ... string
function M.vary(t, default, ...)
  return nonnil(vim.tbl_get(t, ...), default)
end

---@generic T
---@param config evergarden.types.config
---@param props { [evergarden.types.variant]: T }
---@param default T
---@return T?
function M.vary_color(config, props, default)
  return M.vary(props, default, config.theme.variant)
end

---@param normal evergarden.types.colorspec
---@param reverse evergarden.types.colorspec
---@return evergarden.types.colorspec
function M.vary_reverse(normal, reverse)
  local style = normal.style
  if not style then
    return normal
  end
  style = vim.deepcopy(style)
  local index = M.is_reverse(style)
  if index then
    table.remove(style, index)
    local hl = vim.tbl_extend('force', normal, reverse)
    hl.style = style
    return hl
  else
    return normal
  end
end

---@param hex_str string hexadecimal value of a color
local hex_to_rgb = function(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(
    string.find(hex_str, pat) ~= nil,
    'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str)
  )

  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

--- adapted from @catppuccin/nvim https://github.com/catppuccin/nvim/blob/5b5e3aef9ad7af84f463d17b5479f06b87d5c429/lua/catppuccin/utils/colors.lua#L24
---@param fg string|integer
---@param bg string|integer
---@param alpha number amount of fg to mix in (0.0 is only bg)
---@return string|integer
function M.blend(fg, bg, alpha)
  if type(fg) == 'number' or type(bg) == 'number' then
    return fg
  end
  ---@diagnostic disable-next-line: cast-local-type
  bg = hex_to_rgb(bg)
  ---@diagnostic disable-next-line: cast-local-type
  fg = hex_to_rgb(fg)

  local blendChannel = function(i)
    local ret = math.floor((alpha * fg[i] + ((1 - alpha) * bg[i])) + 0.5)
    return clamp(0, 255, ret)
  end

  return string.format(
    '#%02X%02X%02X',
    blendChannel(1),
    blendChannel(2),
    blendChannel(3)
  )
end

---@param hls evergarden.types.hlgroups.OL
---@param theme evergarden.types.theme
---@param config evergarden.types.config }
---@return fun(modbase: string, lst: string[])
function M.make_hl_loader(hls, theme, config)
  if not theme or type(theme) ~= 'table' then
    error 'property of theme passed to make_hl_loader() was expected to be a table of theme options'
  end
  if not config or type(config) ~= 'table' then
    error 'property of config passed to make_hl_loader() was expected to be a table of config options'
  end
  return function(modbase, lst)
    local overlays = vim
      .iter(ipairs(lst))
      :map(function(_, mod)
        local mod_path = modbase:format(mod)
        local ok, result = pcall(require, mod_path)
        if not ok then
          return error(
            string.format('could not import hl groups from %s', mod_path)
          )
        end

        ---@type fun(theme, config): evergarden.types.hlgroups.OL
        local cb
        if type(result) == 'table' then
          if result.get and type(result.get) == 'function' then
            cb = result.get
          end
        elseif type(result) == 'function' then
          cb = result
        end

        ---@diagnostic disable-next-line: redefined-local
        local ok, result = pcall(cb, theme, config)
        if not ok then
          vim.notify(
            ('could not get hls for %s'):format(mod_path),
            vim.log.levels.WARN
          )
          return
        end
        return result
      end)
      :totable()
    table.insert(hls, overlays)
  end
end

---@private
---@param s string
---@return number
local function hash_str(s)
  return vim.iter(ipairs(vim.split(s, ''))):fold(5381, function(hash, _, char)
    return bit.lshift(hash, 5) + hash + string.byte(char)
  end)
end

---@param v any
---@return number|any
function M.hash(v)
  if type(v) == 'table' then
    return vim.iter(pairs(v)):fold(0, function(hash, k, vv)
      return bit.bxor(hash, hash_str(k .. tostring(M.hash(vv))))
    end)
  end

  return v
end

return M
