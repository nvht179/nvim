## Introduction
This is my personal neovim configuration. It follows the philosophy of [mini.nvim](https://github.com/echasnovski/mini.nvim), aiming to achieve sufficient functionality with minimal configuration effort. It does not try to integrate everything but only a minimum for a pleasurable editor experience. Most of the plugins are from `mini.nvim`

## Dependencies
- Neovim >= 0.10
- fzf
- ripgrep
- fd
- rg
- bat
- gcc (or any other C compiler)

## Installation
- Installing dependencies
It is recommended that you have recent versions of the dependencies. I use Homebrew (on Linux) because it tends to have the latest version available:

```bash
# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Install dependencies with Homebrew:

```bash
brew install neovim git gcc fzf ripgrep fd rg bat
```

- Installing the config

```bash
git clone https://github.com/nvht179/nvim.git ~/.config/nvim
```

## Specification
### Config directory structure
```
nvim
├── init.lua
└── lua
    ├── opts.lua
    ├── keymaps.lua
    └── plugins
        ├── lsp.lua
        ├── mini.lua
        └── (other plugins)
```

### Plugins
Plugins are managed with mini.deps
- [mini.nvim](https://github.com/echasnovski/mini.nvim) (except for `mini.animate`, `mini.colors`, `mini.doc`, `mini.pick`, `mini.jump2d`, `mini.test`)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): easy configuration of LSP servers
- [mason.nvim](https://github.com/williamboman/mason.nvim): LSP, DAP, linter, formatter manager
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): a bridge between mason.nvim and nvim-lspconfig
- [conform](https://github.com/stevearc/conform.nvim): a code formatter for Neovim
- [conform-mason](https://github.com/williamboman/conform-mason.nvim): a bridge between conform and mason.nvim
- [fzf-lua](https://github.com/ibhagwan/fzf-lua): a high performance fuzzy finder
- [flash.nvim](https://github.com/folke/flash.nvim): easy code navigation
- [multicursor](https://github.com/jake-stewart/multicursor.nvim): multicursor support for now (Neovim has this feature in roadmap)
- [supermaven](https://github.com/supermaven-inc/supermaven-nvim): AI code completion, nice to have

### LSP and formatters
The following LSP servers are pre-configured:
- pyright
- lua_ls
- ts_ls
- marksman
- html

The following formatters are pre-configured:
- stylua
- isort
- black
- prettierd
- prettier

Add more LSP and formatters in `lua/plugins/lsp.lua`

### Keymaps
Keymaps can be found in `lua/keymaps.lua` and sometimes in plugin configuration files. Generally, the most frequently used are availlable in one keystroke (after the leader key) while other less important ones are grouped into: Buffer, Code, Find, Multicursor, Session and Window. Some other useful but harder to find keybindings are:
- `alt-j/k`: next/previous item or text lines moving in visual mode
- `alt-h/l`: increase/decrease indentation in normal mode
- `alt-n`: add cursor to next matching item (see `lua/plugins/multicursor.lua` for more keybindings)
