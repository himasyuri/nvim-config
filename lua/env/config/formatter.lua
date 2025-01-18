local M = {}

M.conformConfig = {
  lsp_fallback = false,

  log_level = 1,

  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },

    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    typescriptvue = { "prettier" },
    vue = { "prettierd" },

    css = { "prettier" },
    html = { "prettier" },

    json = { "prettier" },
    jsonc = { "prettier" },
    mdx = { "prettier" },

    sql = { "sqlfmt" },
    go = { "gofumpt", "goimports", "golines" },
    cs = { "csharpier" },
  },
}
function M.conformKeys()
  local conform = require "conform"

  return {
    {
      "<leader>fm",
      function()
        conform.format()
      end,
      desc = "Format Code",
    },
  }
end

return M
