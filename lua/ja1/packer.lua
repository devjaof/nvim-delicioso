-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

  use { 'lukas-reineke/indent-blankline.nvim' }

	use({ 'rose-pine/neovim', as = 'rose-pine', config = function() 
		vim.cmd('colorscheme rose-pine')
	end })
  
	use( 'nvim-treesitter/nvim-treesitter', { run =  ':TSUpdate' })
	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use({
    		'kdheepak/lazygit.nvim',
    		-- optional for floating window border decoration
    		requires = {
        		'nvim-lua/plenary.nvim',
    		},
	})

	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
	    --- Uncomment these if you want to manage LSP servers from neovim
	    {'williamboman/mason.nvim'},
	    {'williamboman/mason-lspconfig.nvim'},

	    -- LSP Support
	    {'neovim/nvim-lspconfig'},
	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},
	    {'hrsh7th/cmp-nvim-lsp'},
	    {'L3MON4D3/LuaSnip'},
	  }
	}

  use {'tpope/vim-commentary'}

  use {'mg979/vim-visual-multi'}

  use { 'williamboman/mason.nvim' }

  use {'lewis6991/gitsigns.nvim'}

  use {'editorconfig/editorconfig-vim'}

  use {'windwp/nvim-ts-autotag'}

  use {'APZelos/blamer.nvim', config = function ()
    vim.g.blamer_enabled = true
    vim.g.blamer_show_in_insert_modes = 0
  end}

  use {'github/copilot.vim'}

  use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig'}}
  use {'MunifTanjim/eslint.nvim'}
  use {'prichrd/netrw.nvim'}
  use {'nvim-tree/nvim-web-devicons'}
  use {'jose-elias-alvarez/nvim-lsp-ts-utils'}
  use {'JoosepAlviste/nvim-ts-context-commentstring'}
end)
