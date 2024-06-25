local config = require "env.config.manager"

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    opts = function()
      return config.mason
    end,
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lspconfig = require "lspconfig"
      lspconfig.omnisharp_mono.setup {}
      
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {} )
    end,
  },
}
