#!/usr/bin/env nu

juliaup update
# julia -e 'using Pkg; Pkg.add(split("Crayons OhMyREPL"));'
julia --project=@lsp -e 'using Pkg; Pkg.add(split("LanguageServer"));'

rustup update
