  return {
    {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme "tokyonight-night"
      vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    end,
  },
}
