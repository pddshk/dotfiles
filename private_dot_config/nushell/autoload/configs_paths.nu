let CHEZMOI_ROOT: string = $nu.home-dir | path join ".local" "share" "chezmoi" 
let CHEZMOI_PRIVATE_DOT_CONFIG: string = $CHEZMOI_ROOT | path join "private_dot_config"

let NUSHELL_CONFIG: string = $CHEZMOI_PRIVATE_DOT_CONFIG | path join "nushell"
let STARSHIP_CONFIG_FILE: string = $CHEZMOI_PRIVATE_DOT_CONFIG | path join "starship.toml""
let WEZTERM_CONFIG: string = $CHEZMOI_PRIVATE_DOT_CONFIG | path join "wezterm""
let NVIM_CONFIG: string = $CHEZMOI_PRIVATE_DOT_CONFIG | path join "nvim"
let LAZYGIT_CONFIG: string = $CHEZMOI_PRIVATE_DOT_CONFIG | path join "lazygit" "config.yml"
