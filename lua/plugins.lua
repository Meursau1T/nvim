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
  "cohama/lexima.vim", -- 括号自动补全
  -- 'jiangmiao/auto-pairs', 
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_background = 'soft'
      vim.g.everforest_enable_italic = true
    end
  },
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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }, -- Markdown预览
  "sindrets/diffview.nvim", -- 查看Git文件历史Diff
  "HiPhish/rainbow-delimiters.nvim", -- 彩虹括号
  'williamboman/mason.nvim',
  'skywind3000/asyncrun.vim', -- 用于后台调用rsync

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }, -- 注释工具
  {
    -- dir = "~/source/rsync-git.nvim",
    "Meursau1T/rsync-git.nvim",
    config = function()
      require("rsync-git").setup {
        rules = {
          {
            cond = "douyin_web/",
            localPath = "/home/meursault/workspace/douyin_web",
            remotePath = "/cloudide/workspace/douyin_web",
            userIp = "cloudide-ws1f2f9f5f9c5d8672",
          },
          {
            cond = "douyin_web_1/",
            localPath = "/home/meursault/workspace/douyin_web_1",
            remotePath = "/cloudide/workspace/douyin_web",
            userIp = "cloudide-ws18a5a9be721c2d39",
          },
          {
            cond = "douyin_web_2/",
            userIp = "cloudide-ws502726de974cf8f5",
            localPath = "/home/meursault/workspace/douyin_web_2",
            remotePath = "/cloudide/workspace/douyin_web",
          },
          {
            cond = "douyin_mobile/",
            userIp = "cloudide-ws18a5a9be721c2d39",
            localPath = "/home/meursault/workspace/douyin_mobile",
            remotePath = "/cloudide/workspace/douyin_mobile",
          }
        },
        config = {
          showLog = true,
          ignoreKeyword = "aweme_idl",
        }
      }
    end
  }
})



