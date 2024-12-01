return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<C-f>', function() require('telescope.builtin').find_files() end, mode = 'n', desc = 'Find files' },
    { '<C-p>', function() require('telescope.builtin').live_grep() end, mode = 'n', desc = 'Live grep' },
    { '<leader>g', function() require('telescope.builtin').git_files() end, mode = 'n', desc = 'Git files' },
    { '<leader>ll', function() require('telescope.builtin').grep_string({ search = vim.fn.input("grep > ") }) end, mode = 'n', desc = 'Grep string' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        theme = "ivy",
        layout_strategy = "horizontal",
        prompt_position = 'top',
        sorting_strategy = "ascending",
        layout_config = {
          height = 0.8,
          width = 0.8,
          preview_width = 0.5,
        },
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    })
  end,
}
