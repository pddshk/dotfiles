return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Remove julials from the servers table so Mason doesn't try to manage it
      servers = {},
    },
    init = function()
      vim.lsp.enable("julials")
    end,
  },
}
