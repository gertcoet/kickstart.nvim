# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). The entire config lives in `init.lua` as the single source of truth, with optional modules under `lua/kickstart/plugins/` and user extensions under `lua/custom/plugins/`.

## Formatting

Lua files must be formatted with [stylua](https://github.com/JohnnyMorganz/StyLua). Configuration is in `.stylua.toml`:
- 160 column width, 2-space indent, single quotes preferred, always collapse simple statements

Check formatting: `stylua --check .`
Fix formatting: `stylua .`

CI enforces stylua on PRs via `.github/workflows/stylua.yml`.

## Architecture

### Entry Point

`init.lua` is the single main file (~900 lines). It handles everything in order:
1. Leader key + global settings
2. `vim.opt` options
3. Keymaps and autocommands
4. lazy.nvim bootstrap + all plugin specs inline

### Plugin Extension Points

- **`lua/kickstart/plugins/`** — optional features (autopairs, debug, gitsigns, indent_line, lint, neo-tree). Enable by adding `require('kickstart.plugins.X')` to the plugins table in `init.lua`.
- **`lua/custom/plugins/`** — personal extensions. Files here are auto-imported via `{ import = 'custom.plugins' }` at the end of the lazy setup call. Add new plugins by creating `.lua` files in this directory.

### Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) with `lazy-lock.json` for version pinning. Update plugins: `:Lazy update`. Check status: `:Lazy`.

### LSP Stack

- `mason.nvim` installs language servers automatically
- `nvim-lspconfig` configures them
- `blink.cmp` handles completion (replaces nvim-cmp)
- `conform.nvim` handles formatting (format on save enabled)
- Add servers by extending the `servers` table in the LSP section of `init.lua`

### Treesitter

Parsers auto-install on first open. Add languages to the `ensure_installed` list in the treesitter plugin spec.

## Key Keymaps

**Leader**: `<space>`

| Key | Action |
|-----|--------|
| `<leader>sf` | Telescope: find files |
| `<leader>sg` | Telescope: live grep |
| `<leader>sd` | Telescope: diagnostics |
| `<leader>sn` | Telescope: search Neovim config |
| `<leader>f` | Format buffer |
| `<leader>q` | Diagnostic quickfix list |
| `<leader>mp` | Markdown preview toggle |
| `\` | Toggle NeoTree file explorer |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<A-j>` / `<A-k>` | Move line down / up |

## External Dependencies

Required for full functionality: `git`, `make`, `unzip`, a C compiler, `ripgrep` (`rg`), `fd-find`.
Run `:checkhealth` to verify. The health module is at `lua/kickstart/health.lua`.

The markdown-preview plugin requires `npm` (builds with `cd app && npm install`).

## Autogroup Naming

All custom autogroups use the `kickstart-` prefix (e.g., `kickstart-highlight-yank`, `kickstart-lsp-attach`).
