# How to install
1. clone this repository `git clone https://github.com/comfysage/evergarden.git`
2. copy tmux directory to tmux plugins `cp -R ./extra/tmux/* ~/.tmux/plugins/evergarden-tmux`
3. add `run ~/.tmux/plugins/evergarden-tmux/evergarden.sh` to your `.tmux.conf`

## Note
Our default theme is "medium". If you want to change the theme to `soft` or `hard` you need to explicitly set the @evergarden_style before run `evergarden.sh`
```
# .tmux.conf

set -gq @evergarden_style "hard"

run ~/.tmux/plugins/evergarden-tmux/evergarden.sh
```

## Shoutout to
  - [catppuccin/tmux](https://github.com/catppuccin/tmux)
