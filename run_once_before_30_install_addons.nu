#!/usr/bin/env nu

juliaup update
julia -e 'using Pkg; Pkg.add(split("Crayons OhMyREPL"));'

rustup update
