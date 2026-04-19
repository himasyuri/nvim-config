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
    go = { "goimports", "golines", "gofumpt" },
    cs = { "csharpier" },
  },

  formatters = {
    golines = {
      prepend_args = { "-m", "100" },
    },
  },
}

function M.conformKeys()
  local conform = require "conform"

  return {
    -- Keymap for formatting the entire buffer in Normal mode
    {
      "<leader>fm",
      function()
        conform.format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
    -- Keymap for formatting the selected text in Visual mode
    {
      "<leader>fm",
      function()
        conform.format()
      end,
      mode = "v",
      desc = "Format selection",
    },
  }
end

return M
