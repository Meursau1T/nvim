local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup {
  server_filetype_map = {},
  lightbulb = {
    enable = false,
  }
}

local tops = { noremap = true, silent = ture }
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_line_diagnostics<cr>', opts)
vim.keymap.set('n', 'T', '<Cmd>Lspsaga term_toggle<cr>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<cr>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<cr>', opts)
vim.keymap.set('n', 'go', '<Cmd>Lspsaga outline<cr>', opts)

