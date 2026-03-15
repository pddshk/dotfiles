return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>sR",
      function()
        require("snacks")
        Snacks.picker.resume({ source = "grep" })
      end,
      desc = "Resume grep",
    },
  },
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
