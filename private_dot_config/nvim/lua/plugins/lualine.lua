return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_b = {
        "branch",
        {
          "diff",
          -- reuse gitsigns data instead of spawning `git diff` (which can take index.lock)
          source = function()
            local s = vim.b.gitsigns_status_dict
            if s then
              return { added = s.added, modified = s.changed, removed = s.removed }
            end
          end,
        },
        "diagnostics",
      },
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
