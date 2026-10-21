-- Last normal-mode command as typed (gd, 2j, "ayy, qa...); stays until the next command starts
local last_cmd = ""

return {
  "nvim-lualine/lualine.nvim",
  init = function()
    -- %S must target the statusline so the on_key handler can read the pending keys
    vim.o.showcmdloc = "statusline"
    vim.on_key(function(_, typed)
      local mode = vim.api.nvim_get_mode().mode
      -- typed is empty for keys produced by mappings / remaps (x -> dl), skip those
      if typed == "" or not mode:find("^n") then
        return
      end
      local k = vim.fn.keytrans(typed)
      if k:find("Mouse") or k:find("Scroll") or k:find("Drag") or k:find("Release") then
        return
      end
      -- nothing pending and no operator waiting -> this key starts a new command
      if vim.api.nvim_eval_statusline("%S", {}).str == "" and not mode:find("^no") then
        last_cmd = ""
      end
      last_cmd = (last_cmd .. k):sub(-12)
    end, vim.api.nvim_create_namespace("lualine_last_cmd"))
    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
      -- reg_recording() is still set during RecordingLeave, refresh after it clears
      callback = function()
        vim.schedule(function()
          require("lualine").refresh({ place = { "statusline" } })
        end)
      end,
    })
  end,
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
        {
          function()
            return "REC @" .. vim.fn.reg_recording()
          end,
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
          color = { fg = "#ffffff", bg = "#d70000", gui = "bold" },
        },
        function()
          return last_cmd
        end,
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
