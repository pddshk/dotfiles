return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        root_markers = {
          ".git",
        },
      },
    },
  },
}
