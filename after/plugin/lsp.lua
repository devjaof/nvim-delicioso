local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  }, 
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-n>'] = cmp_action.luasnip_jump_forward(),
    ['<C-p>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  desc = 'LSP actions',
  callback = function(event)
	  local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
  }
})
lspconfig.eslint.setup({capabilities = lsp_capabilities})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll',
  group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
})
