return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  event = "VeryLazy",
  keys = {
    {
      "<leader>yc",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>yw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<leader>yy",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
}
