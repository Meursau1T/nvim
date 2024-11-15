local status, telescope = pcall(require, "telescope")
if (not status) then
  print('Telescope rc wrong')
  return
end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      horizontal = {
        size = {
          width = "95%",
          height = "95%",
        },
      },
      vertical = {
        size = {
          width = "95%",
          height = "95%",
        },
      },
    },
  },
  mappings = {
    n = {
      ['q'] = actions.close
    }
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          ['<C-w>'] = function() vim.cmd{ 'normal vbd' } end,
          ["<C-t>"] = require "telescope.actions".select_tab,
        },
        ['n'] = {
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['/'] = function()
            vim.cmd('startinsert')
          end
        }
      }
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}

telescope.load_extension('file_browser')

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fl', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fk', builtin.grep_string, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.man_pages, opts)
vim.keymap.set('n', '<leader>fm', builtin.marks, opts)
vim.keymap.set('n', '<leader>fgs', builtin.git_status, opts)
vim.keymap.set('n', '<leader>fgc', builtin.git_commits, opts)

-- open telescope-file-browser in current buffer
vim.api.nvim_set_keymap(
  "n",
  "<leader>fe",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
