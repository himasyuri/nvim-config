---@diagnostic disable: different-requires
local gitsignsConfig = require "env.config.gitsigns"

return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return gitsignsConfig.config
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
