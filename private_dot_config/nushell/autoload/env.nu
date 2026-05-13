$env.SSH_AUTH_SOCK = $env.XDG_RUNTIME_DIR | path join "ssh-agent.socket"
$env.EDITOR = which nvim | first | get path
$env.BAT_THEME = "Catppuccin Mocha"
