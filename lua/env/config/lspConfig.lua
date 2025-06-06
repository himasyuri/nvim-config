local M = {}
local map = vim.keymap.set
local lspBuf = vim.lsp.buf

M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  -- Mappings
  map("n", "gD", lspBuf.declaration, opts "Go to Declaration")
  map("n", "gd", lspBuf.definition, opts "Go to Definition")
  map("n", "K", vim.lsp.buf.hover, opts "Hover Information")
  map("n", "gi", lspBuf.implementation, opts "Go to Implementation")
  map("n", "<leader>sh", lspBuf.signature_help, opts "Show Signature help")
  map("n", "<leader>D", lspBuf.type_definition, opts "Go to Type definition")
  map({ "n", "v" }, "<leader>ca", lspBuf.code_action, opts "Code Action")
  map("n", "gr", lspBuf.references, opts "Show References")

  -- Signature popup
  if client.server_capabilities.signatureHelpProvider then
    require("env.utils.lsp.signature").setup(client, bufnr)
  end
end

M.on_attach_omnisharp = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map(
    "n",
    "gd",
    '<cmd>lua require("omnisharp_extended").lsp_definition()<CR>',
    opts "Go to Definition"
  )
  map(
    "n",
    "<leader>D",
    '<cmd>lua require("omnisharp_extended").lsp_type_definition()<CR>',
    opts "Go to Type definition"
  )
  map(
    "n",
    "gr",
    '<cmd>lua require("omnisharp_extended").lsp_references()<CR>',
    opts "Show References"
  )
  map(
    "n",
    "gi",
    '<cmd>lua require("omnisharp_extended").lsp_implementation()<CR>',
    opts "Go to Implementation"
  )
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts "Hover Information")

  -- Signature popup
  if client.server_capabilities.signatureHelpProvider then
    require("env.utils.lsp.signature").setup(client, bufnr)
  end
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.setup = function()
  require "env.utils.lsp"

  -- list of lsp servers that should be setup with default settings
  local servers = {
    "html",
    "cssls",
    "emmet_language_server",
    "marksman",
    "intelephense",
    "tailwindcss",
    "gopls",
  }

  -- Setup servers with default configuration
  for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
      on_init = M.on_init,
    }
  end

  -- Volar LSP configuration
  local get_vue_lsp_path = function()
    return vim.fn.getcwd() .. "/node_modules/@vue"
  end
  local mason_registry = require "mason-registry"
  local vue_language_server_path = mason_registry
    .get_package("vue-language-server")
    :get_install_path() .. "/node_modules/@vue/language-server"

  require("lspconfig").ts_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "vue" },
        },
      },
    },
    filetypes = { "vue" },
  }

  require("lspconfig").volar.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    init_options = {
      typescript = {
        tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
      },
    },
  }

  -- Pyright LSP configuration
  require("lspconfig").pyright.setup {
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    filetypes = { "python" },
    settings = {
      pyright = {
        autoImportCompletion = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "on",
        },
      },
    },
  }

  -- Omnisharp LSP configuration
  require("lspconfig").omnisharp.setup {
    on_attach = M.on_attach_omnisharp,
    capabilities = M.capabilities,
    cmd = {
      "dotnet",
      vim.fn.stdpath "data"
        .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
    },
    enable_import_completion = true,
    organize_imports_on_format = true,
    enable_roslyn_analyzers = true,
    autoselect_existing_sln = true,
    enable_ms_build_load_projects_on_demand = true,
    enable_decompilation_support = true,
    enable_editorconfig_support = true,
    enable_package_restore = true,
    root_dir = require("lspconfig.util").root_pattern(
      "*.sln",
      "*.csproj",
      ".git"
    ),
  }

  -- Custom LSP configuration
  require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end

return M
