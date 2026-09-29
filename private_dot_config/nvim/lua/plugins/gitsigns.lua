local function nav_hunk(dir)
  if dir == "first" or dir == "last" then
    return function() package.loaded.gitsigns.nav_hunk(dir) end
  end
  local cmd = dir == "next" and "]c" or "[c"
  return function()
    if vim.wo.diff then
      vim.cmd.normal({ cmd, bang = true })
    else
      package.loaded.gitsigns.nav_hunk(dir)
    end
  end
end

return {
  "lewis6991/gitsigns.nvim",
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    { "]h", nav_hunk("next"), desc = "Next Hunk" },
    { "[h", nav_hunk("prev"), desc = "Prev Hunk" },
    { "]H", nav_hunk("last"), desc = "Last Hunk" },
    { "[H", nav_hunk("first"), desc = "First Hunk" },
    { "<leader>ghs", ":Gitsigns stage_hunk<CR>", mode = { "n", "x" }, desc = "Stage Hunk" },
    { "<leader>ghr", ":Gitsigns reset_hunk<CR>", mode = { "n", "x" }, desc = "Reset Hunk" },
    { "<leader>ghS", function() package.loaded.gitsigns.stage_buffer() end, desc = "Stage Buffer" },
    { "<leader>ghu", function() package.loaded.gitsigns.undo_stage_hunk() end, desc = "Undo Stage Hunk" },
    { "<leader>ghR", function() package.loaded.gitsigns.reset_buffer() end, desc = "Reset Buffer" },
    { "<leader>ghp", function() package.loaded.gitsigns.preview_hunk_inline() end, desc = "Preview Hunk Inline" },
    { "<leader>ghb", function() package.loaded.gitsigns.blame_line({ full = true }) end, desc = "Blame Line" },
    { "<leader>ghB", function() package.loaded.gitsigns.blame() end, desc = "Blame Buffer" },
    { "<leader>ghd", function() package.loaded.gitsigns.diffthis() end, desc = "Diff This" },
    { "<leader>ghD", function() package.loaded.gitsigns.diffthis("~") end, desc = "Diff This ~" },
    { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "GitSigns Select Hunk" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "🞂" },
      topdelete = { text = "🞂" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "🞂" },
      topdelete = { text = "🞂" },
      changedelete = { text = "▎" },
    },
  },
}
