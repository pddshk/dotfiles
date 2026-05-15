return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = 2,
        },
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
