local config = require "env.config.debugger"

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      config.setup() -- Call the setup function to load the configuration
    end,
    event = "VeryLazy",
  },
}
