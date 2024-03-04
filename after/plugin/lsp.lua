local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  desc = 'LSP actions',
  callback = function(event)
	  local opts = {buffer = bufnr, remap = false}

	  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  end
})

lspconfig.tsserver.setup({
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
      -- defaults
      ts_utils.setup({
          debug = false,
          disable_commands = false,
          enable_import_on_completion = true,

          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers = higher priority
          import_all_priorities = {
              same_file = 1, -- add to existing import statement
              local_files = 2, -- git files or files with relative path markers
              buffer_content = 3, -- loaded buffer content
              buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
          -- if false will avoid organizing imports
          always_organize_imports = true,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},

          -- inlay hints
          auto_inlay_hints = true,
          inlay_hints_highlight = "Comment",
          inlay_hints_priority = 200, -- priority of the hint extmarks
          inlay_hints_throttle = 150, -- throttle the inlay hint request
          inlay_hints_format = { -- format options for individual hint kind
              Type = {},
              Parameter = {},
              Enum = {},
              -- Example format customization for `Type` kind:
              -- Type = {
              --     highlight = "Comment",
              --     text = function(text)
              --         return "->" .. text:sub(2)
              --     end,
              -- },
          },

          -- update imports on file move
          update_imports_on_move = false,
          require_confirmation_on_move = false,
          watch_dir = nil,
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    end,
})

lspconfig.tailwindcss.setup({capabilities = lsp_capabilities})

local null_ls = require('null-ls')
local eslint = require('eslint')

eslint.setup({
  bin = 'eslint_d',
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" }
    }
  },
  diagnostics = {
    enable = true,
    run_on = "save"
  }
})
local root_pattern = require("lspconfig.util").root_pattern

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  root_dir = root_pattern(
    ".eslintrc",
    "node_modules/bin",
    ".git"
  ),
})
