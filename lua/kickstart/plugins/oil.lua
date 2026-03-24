-- Oil.nvim - edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '\\', '<cmd>Oil<CR>', desc = 'Open Oil (file explorer)', silent = true },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = { 'icon' },
    keymaps = {
      ['<CR>'] = 'actions.select',
      ['<BS>'] = 'actions.parent',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['q'] = 'actions.close',
      ['\\'] = 'actions.close',
      ['gs'] = 'actions.change_sort',
      ['g.'] = 'actions.toggle_hidden',
      ['gx'] = 'actions.open_external',
      ['g\\'] = 'actions.toggle_trash',
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = false,
    },
  },
}
