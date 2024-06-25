local config = require "env.config.nvim-tree"

return {
  "nvim-tree/nvim-tree.lua",
  --"nvim-tree/nvim-web-devicons",
  event = "UIEnter",
  keys = function()
    return config.nvimTreeKeys()
  end,
  opts = function()
    return config.nvimTree
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
