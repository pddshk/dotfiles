return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = {},
      lualine_x = {
        "searchcount",
        "encoding",
        function()
          local fmt = vim.bo.fileformat
          if fmt == "unix" then
            return "LF"
          elseif fmt == "dos" then
            return "CRLF"
          else
            return "CR"
          end
        end,
      },
      lualine_y = { "filetype" },
      lualine_z = {
        function()
          return vim.fn.line(".") .. "/" .. vim.fn.line("$") .. ":" .. vim.fn.col(".")
        end,
      },
    },
  },
}
