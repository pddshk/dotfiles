return {
  "rachartier/tiny-cmdline.nvim",
  opts = function()
    return {
      position = { x = "50%", y = "10%" },
      title = {
        enabled = true,
      },
      on_reposition = require("tiny-cmdline").adapters.blink,
    }
  end,
}
