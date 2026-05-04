return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require('nvim-treesitter.config').setup({
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
