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

-- vim.lsp.config("ts_ls", {
--   on_attach = on_attach,
--   filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
--   cmd = { '/Users/xinfu.wang/.local/share/fnm/aliases/default/bin/typescript-language-server', '--stdio'},
--
--   init_options = {
--     plugins = {
--       {
--         name = '@vue/typescript-plugin',
--         location = "/Users/xinfu.wang/.local/share/fnm/aliases/default/lib/node_modules",
--         languages = { 'vue' },
--       },
--     },
--   },
-- })
-- vim.lsp.enable({"ts_ls"})

vim.lsp.config("tsgo", {
  on_attach = on_attach,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git', 'tsconfig.base.json' },
  cmd = { '/Users/xinfu.wang/.local/share/fnm/aliases/default/bin/tsgo', '--lsp', '--stdio'},

  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = "/Users/xinfu.wang/.local/share/fnm/aliases/default/lib/node_modules",
        languages = { 'vue' },
      },
    },
  },
})
vim.lsp.enable({"tsgo"})

vim.lsp.config("csharp_ls", {
  on_attach = on_attach
})
vim.lsp.enable({"csharp_ls"})

vim.lsp.config("csharp_ls", {
  on_attach = on_attach
})
vim.lsp.enable({"csharp_ls"})

vim.lsp.config("copilot", {
  on_attach = on_attach
})
vim.lsp.enable({"copilot"})

-- vim.lsp.config("volar", {
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--   },
-- })
-- vim.lsp.enable({"volar"})
