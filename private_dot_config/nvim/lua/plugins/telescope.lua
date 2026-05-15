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
      "<leader><space>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
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
