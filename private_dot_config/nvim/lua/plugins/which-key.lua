return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        mode = { "n", "x" },
        { "<leader>y", group = "Yazi" },
      },
      {
        mode = { "n", "x" },
        { "<leader>b", group = "Buffers"}
      },
      {
        mode = { "n", "x" },
        { "<leader>g", group = "git"}
      },
      {
        mode = { "n", "x" },
        { "<leader>gh", group = "hunks"}
      },
      {
        mode = { "n", "x" },
        { "<leader>u", group = "Tree-sitter"}
      },
      {
        mode = { "n", "x" },
        { "<leader>c", group = "Code"}
      },
    },
  },
}
