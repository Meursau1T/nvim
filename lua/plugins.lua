local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed', packer)
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Packer自己
  use {
    'itchyny/lightline.vim',
    'morhetz/gruvbox',
    'jiangmiao/auto-pairs' -- 括号自动补全
  }
  use {
    'nvim-treesitter/nvim-treesitter', -- 着色
    run = ':TSUpdate'
  }
  use 'onsails/lspkind-nvim' --- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in lsp
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP基础
  use 'glepnir/lspsaga.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'lewis6991/gitsigns.nvim'

  use "williamboman/mason.nvim"
  use 'skywind3000/asyncrun.vim'
end)
