#!/usr/bin/env julia
# Find the xterm 256-color cube slot (16-231) closest to given color(s).
#
# WezTerm (like xterm) fills slots 16-231 with a 6x6x6 RGB cube using the
# channel levels below. Distance is measured in OKLab (perceptual).
#
# Usage:
#   julia nearest_xterm_slot.jl [-n N] COLOR...
#
#   COLOR  hex, e.g. "#cba6f7" or cba6f7
#   -n N   show N nearest slots per color (default 1)
#
# With several colors, also prints the single slot whose worst-case
# distance to all of them is smallest (e.g. one slot for both the Mocha
# and Latte variant of a Catppuccin color).

const LEVELS = (0x00, 0x5f, 0x87, 0xaf, 0xd7, 0xff)

const CUBE = [
    (16 + 36r + 6g + b, (LEVELS[r+1], LEVELS[g+1], LEVELS[b+1]))
    for r in 0:5 for g in 0:5 for b in 0:5
]

function parse_hex(s::AbstractString)::NTuple{3, UInt8}
    h = lstrip(s, '#')
    length(h) == 6 || error("expected 6-digit hex color, got \"$s\"")
    v = parse(UInt32, h; base=16)
    return (UInt8(v >> 16), UInt8((v >> 8) & 0xff), UInt8(v & 0xff))
end

hex((r, g, b)) = "#" * join(string.((r, g, b); base=16, pad=2))

linear(c) = (x=c / 255; x <= 0.04045 ? x / 12.92 : ((x + 0.055) / 1.055)^2.4)

function oklab(rgb)
    r, g, b = linear.(rgb)
    l = cbrt(0.4122214708r + 0.5363325363g + 0.0514459929b)
    m = cbrt(0.2119034982r + 0.6806995451g + 0.1073969566b)
    s = cbrt(0.0883024619r + 0.2817188376g + 0.6299787005b)
    return (0.2104542553l + 0.7936177850m - 0.0040720468s,
        1.9779984951l - 2.4285922050m + 0.4505937099s,
        0.0259040371l + 0.7827717662m - 0.8086757660s)
end

dist(a, b) = sqrt(sum(abs2, oklab(a) .- oklab(b)))

function main(args)
    n = 1
    colors = String[]
    i = 1
    while i <= length(args)
        if args[i] == "-n"
            n = parse(Int, args[i+1])
            i += 2
        else
            push!(colors, args[i])
            i += 1
        end
    end
    if isempty(colors)
        println(stderr, "usage: julia nearest_xterm_slot.jl [-n N] COLOR...")
        exit(1)
    end

    targets = parse_hex.(colors)
    for (name, t) in zip(colors, targets)
        ranked = sort(CUBE; by=((_, c),) -> dist(t, c))
        println(hex(t))
        for (slot, c) in ranked[1:min(n, end)]
            println("  slot $(lpad(slot, 3))  $(hex(c))  ΔE=$(round(dist(t, c); digits=4))")
        end
    end

    if length(targets) > 1
        worst((_, c)) = maximum(t -> dist(t, c), targets)
        slot, c = argmin(worst, CUBE)
        println("best common: slot $slot  $(hex(c))  max ΔE=$(round(worst((slot, c)); digits=4))")
    end
end

main(ARGS)
