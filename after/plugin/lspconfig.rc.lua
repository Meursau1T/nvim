local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- always show gutter after attach
  -- vim.opt.signcolumn = "yes"
  vim.diagnostic.config({
    virtual_text = true,
    signs = false,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })
  -- formatting
  --if client.server_capabilities.documentFormattingProvider then
    --vim.api.nvim_command [[augroup Fromat]]
    --vim.api.nvim_command [[autocmd! * <buffer>]]
    --vim.api.nvim_command [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    --vim.api.nvim_command [[augroup END]]
  --end
end

nvim_lsp.ts_ls.setup {
  on_attach = on_attach,
  -- filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'vue', 'javascriptreact' },
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
  cmd = { '/home/meursault/.local/share/fnm/aliases/default/bin/typescript-language-server', '--stdio'},

  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = "/home/meursault/.local/share/fnm/aliases/default/lib/node_modules",
        languages = { 'vue' },
      },
    },
  },
}

nvim_lsp.csharp_ls.setup {
  on_attach = on_attach,
}

nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
}

-- nvim_lsp.volar.setup { }

nvim_lsp.volar.setup {
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}
