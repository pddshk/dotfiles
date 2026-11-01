# LS_COLORS with ANSI colors only, so `ls` names follow the terminal's
# light/dark switch. Mirrors the categories of nushell's builtin default,
# which uses fixed 256-color slots (e.g. neon #00ff87 for source files).
let file_types = [
  "di=1;34"   # directory
  "ln=36"     # symlink
  "or=4;31"   # broken symlink
  "mi=4;31"   # missing symlink target
  "ex=1;32"   # executable
  "pi=33"     # fifo
  "so=35"     # socket
  "bd=1;33"   # block device
  "cd=1;33"   # char device
  "su=1;31"   # setuid
  "sg=1;31"   # setgid
  "tw=1;34"   # sticky + other-writable dir
  "ow=1;34"   # other-writable dir
  "st=1;34"   # sticky dir
]

let by_suffix = {
  # source code
  "32": [
    bash bat c cc cjs cmd cpp cs cxx el fish fs go h hpp hs java jl js jsx kt
    lua mjs ml nu php pl ps1 psm1 py pyi rb rs scala sh swift ts tsx vim zig zsh
  ]
  # config / data
  "33": [
    cfg CMakeLists.txt conf csv Dockerfile ini json jsonc justfile kbd Makefile
    toml tsv xml yaml yml
  ]
  # docs
  "35": [css epub htm html LICENSE markdown md org pdf README rst tex txt]
  # media
  "34": [
    avi bmp flac gif ico jpeg jpg m4a mkv mov mp3 mp4 ogg png svg tiff wav webm
    webp
  ]
  # archives
  "4;31": [7z bz2 deb eopkg gz iso rar rpm tar tgz xz zip zst]
  # backup / generated / logs
  "90": [bak lock log old orig swp tmp]
}

$env.LS_COLORS = (
  $file_types
  | append (
    $by_suffix | items {|code, suffixes|
      $suffixes | each {|s| if ($s =~ '^[a-z0-9]+$') { $"*.($s)=($code)" } else { $"*($s)=($code)" } }
    } | flatten
  )
  | str join ":"
)
