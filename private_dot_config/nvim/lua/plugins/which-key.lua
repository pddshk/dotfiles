return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        mode = { "n", "x" },
        { "<leader>y", group = "yazi" },
      },
    },
  },
}
