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
      { "<leader>fe", function() Snacks.explorer() end, desc = "Explorer" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
  { 'stevearc/conform.nvim', opts = {}, }, -- 自动格式化代码
  { 'daschw/leaf.nvim', opts = {} }, -- Theme
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  -- {
  -- "zbirenbaum/copilot-cmp",
  --   config = function ()
  --     require("copilot_cmp").setup()
  --   end
  -- },
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
        " 补全：如果你保留了 lexima.vim，要确保它和 CoC 兼容
        inoremap <silent><expr> <C-space> coc#refresh()
        " ==================== Copilot 行内建议映射 ====================
        " 接受/确认当前行内建议 (最常用)
        " 我们使用 <C-g>I 来防止与 Tab 键的冲突
        imap <silent><script><expr> <C-g>I coc#rpc#request('copilot', 'acceptInlineSuggestion', [])
        " 切换到下一个建议 (如果Copilot提供了多个替代方案)
        imap <silent><script><expr> <C-g>N coc#rpc#request('copilot', 'nextInlineSuggestion', [])
        " 切换到上一个建议
        imap <silent><script><expr> <C-g>P coc#rpc#request('copilot', 'prevInlineSuggestion', [])
        " 隐藏/取消当前建议
        imap <silent><script><expr> <C-g>D coc#rpc#request('copilot', 'hideInlineSuggestion', [])
      ]]
    end,
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



