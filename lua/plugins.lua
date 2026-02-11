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
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },
  {
    "cohama/lexima.vim", -- 括号自动补全
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter", -- 着色
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true,
          disable = {},
        },
        ensure_installed = { "tsx", "typescript", "lua", "json", "css" },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim", -- GitBlame和增删标记
    event = { "BufReadPre", "BufNewFile" },
    cond = function()
      return vim.fn.executable("git") == 1
    end,
    config = function()
      require("gitsigns").setup({
        signcolumn = false,
        numhl = true,
        current_line_blame = true,
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    opts = {},
  },
  {
    "sindrets/diffview.nvim", -- 查看Git文件历史Diff
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            disable_diagnostics = false,
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            disable_diagnostics = false,
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
            hg = {
              single_file = {},
              multi_file = {},
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = {},
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "[F", actions.select_first_entry, { desc = "Open the diff for the first file" } },
            { "n", "]F", actions.select_last_entry, { desc = "Open the diff for the last file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." } },
            { "n", "[x", actions.prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
            { "n", "]x", actions.next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },
            { "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
            { "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
            { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all the versions of a conflict" } },
            { "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
            { "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
            { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
            { "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
            { "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
            { "n", "dX", actions.conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
          },
        },
      })
    end,
  },
  {
    "esmuellert/vscode-diff.nvim",
    cmd = { "CodeDiff" },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "HiPhish/rainbow-delimiters.nvim", -- 彩虹括号
    ft = { "lua", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    init = function()
      vim.g.rainbow_delimiters = {
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
    config = function()
      local rd = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = vim.tbl_deep_extend("force", vim.g.rainbow_delimiters or {}, {
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig", -- LSP基础
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local on_attach = function(_, _)
        vim.diagnostic.config({
          virtual_text = true,
          signs = false,
          underline = true,
          update_in_insert = false,
          severity_sort = false,
        })
      end

      vim.lsp.config("tsgo", {
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git", "tsconfig.base.json" },
        cmd = { "/Users/xinfu.wang/.local/share/fnm/aliases/default/bin/tsgo", "--lsp", "--stdio" },
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/Users/xinfu.wang/.local/share/fnm/aliases/default/lib/node_modules",
              languages = { "vue" },
            },
          },
        },
      })
      vim.lsp.enable({ "tsgo" })

      vim.lsp.config("csharp_ls", {
        on_attach = on_attach,
      })
      vim.lsp.enable({ "csharp_ls" })
    end,
  },
  {
    "hrsh7th/nvim-cmp", -- Completion
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp_ok, cmp = pcall(require, "cmp")
      if not cmp_ok then
        return
      end

      local lspkind_ok, lspkind = pcall(require, "lspkind")
      if not lspkind_ok then
        return
      end

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
          }),
        },
      })

      vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
      ]])
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      local ok, saga = pcall(require, "lspsaga")
      if not ok then
        return
      end

      saga.setup({
        server_filetype_map = {},
        lightbulb = {
          enable = false,
        },
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", opts)
      vim.keymap.set("n", "<C-k>", "<Cmd>Lspsaga show_line_diagnostics<cr>", opts)
      vim.keymap.set("n", "T", "<Cmd>Lspsaga term_toggle<cr>", opts)
      vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<cr>", opts)
      vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<cr>", opts)
      vim.keymap.set("n", "go", "<Cmd>Lspsaga outline<cr>", opts)
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "prettier", stop_after_first = true },
          typescript = { "prettier", stop_after_first = true },
          javascriptreact = { "prettier", stop_after_first = true },
          typescriptreact = { "prettier", stop_after_first = true },
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    event = "VimEnter",
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
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() require("snacks").git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() require("snacks").lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>fgs", function() require("snacks").picker.git_status() end, desc = "Git status" },
      { "<leader>fb", function() require("snacks").picker.buffers({ current = false }) end, desc = "Buffer list" },
      { "<leader>ff", function() require("snacks").picker.files() end, desc = "File list" },
      { "<leader>fl", function() require("snacks").picker.grep() end, desc = "Grep words" },
      { "<leader>fk", function() require("snacks").picker.grep_word() end, desc = "Grep current word" },
      {
        "<leader>fe",
        function()
          require("snacks").explorer({
            layout = { preset = "default", preview = false, reverse = false },
            auto_close = true,
            win = {
              list = {
                keys = {
                  ["<c-c>"] = "explorer_close",
                },
              },
            },
          })
        end,
        desc = "Explorer",
      },
      { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
}, {
  defaults = { lazy = true },
})
