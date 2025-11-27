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
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
      }
    end
  },
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
  -- 'onsails/lspkind-nvim', --- vscode-like pictograms
  -- 'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
  -- 'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in lsp
  -- 'hrsh7th/nvim-cmp', -- Completion
  -- 'neovim/nvim-lspconfig', -- LSP基础
  -- 'glepnir/lspsaga.nvim',

  'nvim-lua/plenary.nvim', -- lua语言库，许多插件的基础依赖
  -- 'nvim-telescope/telescope.nvim',
  -- 'nvim-telescope/telescope-file-browser.nvim',
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
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
  -- 'williamboman/mason.nvim',
  'skywind3000/asyncrun.vim', -- 用于后台调用rsync
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
      words = { enabled = false },
      explorer = { enabled = false },
      picker = { enabled = false },
      scroll = { enabled = true },
      image = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>fgs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<leader>fb", function() Snacks.picker.buffers({ current = false }) end, desc = "Buffer list" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "File list" },
      { "<leader>fl", function() Snacks.picker.grep() end, desc = "Grep words" },
      { "<leader>fk", function() Snacks.picker.grep_word() end, desc = "Grep current word" },
      { "<leader>fe",
        function() Snacks.explorer({
          layout = { preset = "telescope", preview = false },
          auto_close = true,
            win = {
              list = {
                keys = {
                  ["<c-c>"] = "explorer_close",
                },
              },
            },
        }) end,
        desc = "Explorer"
      },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
  { 'stevearc/conform.nvim', opts = {}, }, -- 自动格式化代码
  { 'daschw/leaf.nvim', opts = {} }, -- Theme
  {
    'neoclide/coc.nvim',
    branch = 'release', -- 必须使用 release 分支
    event = 'VimEnter',
    config = function()
      -- ❗重要：按键映射
      -- 这里只是示例，你需要根据自己的习惯添加所有必要的映射
      vim.cmd [[
        " 跳转定义、引用等
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        " 重命名
        nmap <leader>rn <Plug>(coc-rename)
        " 格式化
        xmap <leader>fm <Plug>(coc-format-selected)
        nmap <leader>fm <Plug>(coc-format-selected)
        " 悬浮文档/诊断
        nnoremap <silent> K :call CocAction('doHover')<CR>
        " 代码动作
        nmap <leader>ca <Plug>(coc-codeaction)
      ]]
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'gpt-5',           -- AI model to use
      temperature = 0.1,           -- Lower = focused, higher = creative
      window = {
        layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
        width = 0.5,              -- 50% of screen width
      },
      auto_insert_mode = true,     -- Enter insert mode when opening
    },
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
})



