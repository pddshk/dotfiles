local function smart_find_by_ext(ext)
  local is_git = vim.fn.isdirectory(".git") == 1
  if is_git then
    require('telescope.builtin').find_files({
      find_command = { "git", "ls-files", "*." .. ext },
    })
  else
    require('telescope.builtin').find_files({
      find_command = { "fd", "--type", "f", "--unrestricted", "-e", ext },
    })
  end
end

local exts = { "as", "asm", "bat", "bib", "c", "cfg", "cls", "cmd", "cpp", "cr", "cs", "css", "csv", "dart", "diff", "go", "gradle", "h", "hpp", "hs", "html", "ini", "ipynb", "java", "jl", "js", "json", "lua", "md", "ninja", "nu", "pas", "patch", "perl", "php", "pl", "pm", "po", "prefab", "proto", "ps1", "py", "pyi", "rs", "rst", "scm", "scss", "sh", "sql", "svg", "tex", "tmpl", "toml", "ts", "txt", "vim", "xml", "yaml", "yml", "other..." }

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -GNinja -DCMAKE_C_COMPILER=clang -DCMAKE_C_STANDARD=17 -DCMAKE_BUILD_TYPE=Release ; cmake --build build --config Release --target install",
    },
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader>fe",
      function()
        vim.ui.select(exts, { prompt = "Extension: " }, function(ext)
          if not ext then return end
          if ext == "other..." then
            vim.ui.input({ prompt = "Extension: " }, function(ext)
              smart_find_by_ext(ext)
            end)
            return
          end
          smart_find_by_ext(ext)
        end)
      end,
      desc = "Find files by extension",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Find files (git)",
    },
    {
      "<leader>fu",
      function()
        require("telescope.builtin").find_files({ find_command = { "fd", "--type", "f", "--unrestricted" } })
      end,
      desc = "Find files (unrestricted)",
    },
    {
      "<leader>/",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Live grep (args)",
    },
    {
      "<leader>,",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").oldfiles({ cwd_only = true })
      end,
      desc = "Recent files (project)",
    },
    {
      "<leader>fR",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Recent files (all)",
    },
    {
      "gd",
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      desc = "Go to definition",
    },
    {
      "gr",
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "Go to references",
    },
    {
      "gi",
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      desc = "Go to implementation",
    },
    {
      "gy",
      function()
        require("telescope.builtin").lsp_type_definitions()
      end,
      desc = "Go to type definition",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      path_display = { "truncate" },
      layout_config = {
        prompt_position = "top",
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--color", "never" },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")
  end,
}
