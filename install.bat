REM symlinks for windows

REM nvim config directory
mklink /D C:\Users\Java\AppData\Local\nvim\ C:\Users\Java\Downloads\GitHub\dotfiles\nvim\

REM fastfetch config
mklink C:\Users\Java\.config\fastfetch\config.jsonc C:\Users\Java\Downloads\GitHub\dotfiles\fastfetch\config.jsonc

REM glazewm config directory
mklink /D C:\Users\Java\.glaze-wm\ C:\Users\Java\Downloads\GitHub\dotfiles\glazewm\

REM wezterm config
mklink C:\Users\Java\.wezterm.lua C:\Users\Java\Downloads\GitHub\dotfiles\wezterm\.wezterm.lua
