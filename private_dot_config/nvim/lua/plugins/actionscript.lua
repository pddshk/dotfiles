return {
  {
    "actionscript-syntax",
    dir = vim.fn.stdpath("data") .. "/actionscript-syntax",
    name = "actionscript-syntax",
    build = function()
      local dir = vim.fn.stdpath("data") .. "/actionscript-syntax/syntax"
      vim.fn.mkdir(dir, "p")
      vim.fn.system({
        "curl",
        "-L",
        "-o",
        dir .. "/actionscript.vim",
        "https://www.vim.org/scripts/download_script.php?src_id=10123",
      })
    end,
    init = function()
      vim.filetype.add({ extension = { as = "actionscript" } })
    end,
  },
}
