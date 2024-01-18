local telescope = require('telescope')
telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "❯ ",
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})

vim.keymap.set('n', '<leader>ps', function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', 'gd', builtin.lsp_definitions, {});

vim.keymap.set('n', 'gD', builtin.lsp_implementations, {});

