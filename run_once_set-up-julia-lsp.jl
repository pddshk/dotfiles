#!/usr/bin/env -S julia --project=@nvim-lspconfig
#
# TODO: remove when Mason support introduced

using Pkg
Pkg.add(["LanguageServer", "SymbolServer", "StaticLint"])
