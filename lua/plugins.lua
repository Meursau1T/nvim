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
  -- { 'echasnovski/mini.icons', version = false },
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
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Lua
  { "folke/twilight.nvim", },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
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



