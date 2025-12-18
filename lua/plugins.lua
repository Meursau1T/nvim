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
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  { "EdenEast/nightfox.nvim" },
  { "Shatur/neovim-ayu" },
  {
  "esmuellert/vscode-diff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  },
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
  {
    'nvim-treesitter/nvim-treesitter', -- 着色
    build = ':TSUpdate'
  },

  'nvim-lua/plenary.nvim', -- lua语言库，许多插件的基础依赖
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
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
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
    opts = {},
  }, -- Markdown预览
  "sindrets/diffview.nvim", -- 查看Git文件历史Diff
  "HiPhish/rainbow-delimiters.nvim", -- 彩虹括号
  -- NVIM_LSP
  'williamboman/mason.nvim',
  'onsails/lspkind-nvim', --- vscode-like pictograms
  'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
  'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in lsp
  'hrsh7th/nvim-cmp', -- Completion
  'neovim/nvim-lspconfig', -- LSP基础
  'glepnir/lspsaga.nvim',
  -- NVIM_LSP END
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
      words = { enabled = true },
      explorer = { enabled = true },
      picker = { enabled = true },
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
          layout = { preset = "telescope", preview = false, reverse = false },
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
  -- {
  --   'neoclide/coc.nvim',
  --   branch = 'release', -- 必须使用 release 分支
  --   event = 'VimEnter',
  --   config = function()
  --     -- ❗重要：按键映射
  --     -- 这里只是示例，你需要根据自己的习惯添加所有必要的映射
  --     vim.cmd [[
  --       " 跳转定义、引用等
  --       nmap <silent> gd <Plug>(coc-definition)
  --       nmap <silent> gy <Plug>(coc-type-definition)
  --       nmap <silent> gi <Plug>(coc-implementation)
  --       nmap <silent> gr <Plug>(coc-references)
  --       " 重命名
  --       nmap <leader>rn <Plug>(coc-rename)
  --       " 格式化
  --       xmap <leader>fm <Plug>(coc-format-selected)
  --       nmap <leader>fm <Plug>(coc-format-selected)
  --       " 悬浮文档/诊断
  --       nnoremap <silent> K :call CocAction('doHover')<CR>
  --       " 代码动作
  --       nmap <leader>ca <Plug>(coc-codeaction)
  --     ]]
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
  "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "copilot", focus = true }) end,
        desc = "Sidekick Toggle Copilot",
      },
    },
  }
})



