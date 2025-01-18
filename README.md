# My Neovim Configuration

This repository is my personal neovim configuration. I use it as main work environment for my projects and work.

## Features
- **Language Support**: Full support for various programming languages including managed by [Mason](https://github.com/williamboman/mason.nvim):
  - C# (via [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn))
  - Go (via [gopls](https://pkg.go.dev/golang.org/x/tools/gopls))
  - TypeScript (via [tsserver](https://github.com/typescript-language-server/typescript-language-server))
  - Vue.js (via [vls](https://github.com/vuejs/language-tools))
  - React (via [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server))
  - HTML, CSS (via [html-lsp](https://github.com/microsoft/vscode-html-languageservice) and [css-lsp](https://github.com/microsoft/vscode-css-languageservice))
  - Tailwind CSS (via [tailwindcss-language-server](https://github.com/tailwindlabs/tailwindcss-intellisense))
  - Emmet (via [emmet-language-server](https://github.com/olrtg/emmet-language-server))
  - Python (via [pyright](https://github.com/microsoft/pyright))
  - Lua (via [lua-language-server](https://github.com/LuaLS/lua-language-server))


- **Formatter Support**: Auto-formatting with the following formatters managed by [Mason](https://github.com/williamboman/mason.nvim):
  - **C#**: `csharpier`
  - **SQL**: `sqlfmt`
  - **Prettier** (for JS, HTML, CSS, JSON)
  - **Prettierd** (Prettier daemon for faster performance)
  - **Shell**: `shfmt`
  - **Lua**: `stylua`
  - **Go**: `gofumpt`, `goimports`, `golines`

## Prerequisites
- **Neovim**: v0.10.0+
- **ripgrep**
- **node**
- **nerd-fonts**
- **gcc**
- **fzf**
