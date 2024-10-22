-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  'itchyny/lightline.vim',
  'jiangmiao/auto-pairs', -- 括号自动补全
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  { "shaunsingh/nord.nvim" },
  {
    'nvim-treesitter/nvim-treesitter', -- 着色
    build = ':TSUpdate'
  },
  'onsails/lspkind-nvim', --- vscode-like pictograms
  'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
  'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in lsp
  'hrsh7th/nvim-cmp', -- Completion
  'neovim/nvim-lspconfig', -- LSP基础
  'glepnir/lspsaga.nvim',

  'nvim-lua/plenary.nvim', -- lua语言库，许多插件的基础依赖
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  {
    'lewis6991/gitsigns.nvim', -- GitBlame和增删标记
    config = function()
      require('gitsigns').setup {
        signcolumn = false,
        numhl = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame = true,
      }
    end
  },
  "sindrets/diffview.nvim", -- 查看Git文件历史Diff

  'williamboman/mason.nvim',
  'skywind3000/asyncrun.vim', -- 用于后台调用rsync

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }, -- 注释工具
})

