$env.SSH_AUTH_SOCK = $env.XDG_RUNTIME_DIR | path join "ssh-agent.socket"
$env.EDITOR = which nvim | first | get path
$env.BAT_THEME = "Catppuccin Mocha"
$env.FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix'
$env.FZF_CTRL_T_COMMAND = 'fd --type f --strip-cwd-prefix'
