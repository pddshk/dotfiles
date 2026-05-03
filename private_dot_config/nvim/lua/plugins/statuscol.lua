return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local function lnum_both()
      local total = vim.api.nvim_buf_line_count(0)
      local abw = #tostring(total)
      local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
      return string.format("%" .. abw .. "d %2d ", vim.v.lnum, relnum)
    end
    require("statuscol").setup({
      setopt = true,
      segments = {
        { sign = { namespace = { ".*" }, auto = true } },
        { text = { lnum_both, " ", } },
        { sign = { namespace = { "gitsigns" } } },
      },
    })
  end,
}
