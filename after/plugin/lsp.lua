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
  capabilities = lsp_capabilities, 
  filetypes = { 
    "typescript", 
    "typescriptreact", 
    "typescript.tsx", 
    "javascript", 
    "javascriptreact", 
    "javascript.jsx" 
  },
  cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.tailwindcss.setup({capabilities = lsp_capabilities})

local null_ls = require('null-ls')

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require('prettier')
prettier.setup({
  bin = 'prettier',
  filetype = {
    "css",
    "graphql",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "json",
    "html",
    "handlebars"
  }
})


local eslint = require('eslint')
eslint.setup({
  bin = 'eslint',
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line"
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "save"
  },
})
