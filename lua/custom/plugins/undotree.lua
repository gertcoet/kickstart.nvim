return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle Undotree' },
  },
  init = function()
    if vim.fn.has 'win32' == 1 then
      -- Git ships diff.exe in usr/bin, derive path from git executable
      local git = vim.fn.exepath 'git'
      if git ~= '' then
        local diff = vim.fn.fnamemodify(git, ':h:h') .. '/usr/bin/diff.exe'
        if vim.fn.executable(diff) == 1 then
          vim.g.undotree_DiffCommand = diff
        else
          vim.g.undotree_DiffAutoOpen = 0
        end
      else
        vim.g.undotree_DiffAutoOpen = 0
      end
    end
  end,
}
