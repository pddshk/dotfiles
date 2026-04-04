#!/usr/bin/env nu

let wanted: list<string> = [
    "Rolv-Apneseth/starship"
    "yazi-rs/plugins:git"
    "yazi-rs/plugins:mime-ext"
]

let installed: list<string> = ya pkg list
    | lines
    | where { |l| not ($l | str ends-with ":") and ($l | str trim | is-not-empty) }
    | each { |l| $l | str trim | split row " " | first }

for pkg in $wanted {
    if $pkg not-in $installed {
        ya pkg add $pkg
    }
}

ya pkg upgrade
