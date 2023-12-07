![preview](images/preview-rust__data.png)

evergarden is a cozy neovim colorscheme for cozy morning coding.

evergarden is inspired by the [everforest colorscheme](https://github.com/sainnhe/everforest).

## Installation

using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  'crispybaccoon/evergarden',
  opts = {
    transparent_background = true,
    contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
    overrides = { }, -- add custom overrides
  }
}
```

using [vim-plug](https://github.com/junegunn/vim-plug):

```Vim
Plug 'crispybaccoon/evergarden'
```

## Configuration

```lua
require 'evergarden'.setup {
  transparent_background = false,
  contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
  override_terminal = true,
  style = {
    tabline = { reverse = true, color = 'green' },
    search = { reverse = false, inc_reverse = true },
    types = { italic = true },
    keyword = { italic = true },
    comment = { italic = false },
  },
  overrides = { }, -- add custom overrides
}
```

### Overrides

Overrides can take all options passed to `vim.api.nvim_set_hl()`.

```lua
require 'aurora'.setup {
    overrides = {
        'Normal' = { '#fddce3', '#1d2021' } -- { 'fg', 'bg', bold = bool, italic = bool, ... }
    },
}
```

## Features

- Lots of style-customization options (contrast, color invertion etc.)
- Support for Treesitter highlighting.
- Support for transparent background.
- Supported plugins: [GitGutter][], [Telescope][].

  [gitgutter]: https://github.com/airblade/vim-gitgutter
  [telescope]: https://github.com/nvim-telescope/telescope

![telescope preview](images/preview-telescope__files.png)

## License

[MIT/X11](https://en.wikipedia.org/wiki/MIT_License)
