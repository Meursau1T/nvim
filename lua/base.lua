-- python配置
vim.cmd([[
    let g:python3_host_prog='C:/Users/MeursaulT/scoop/apps/python/current/python.exe'
    let g:python_host_prog='C:/Users/MeursaulT/scoop/apps/python/current/python.exe'
]])

-- neovide配置
if vim.g.neovide then
  vim.o.guifont = "Cascadia Code:h13"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

-- 常用系统配置
vim.g.mapleader = ','
vim.g.directory = '$HOME/.vim/tmp/'    -- 设置directory，避免出现无法新建swap文件夹的错误
vim.opt.vb = true -- 禁用响铃
vim.g.novisualbell = true -- 禁用屏幕闪烁
vim.g.backspace = 2
vim.cmd([[
    syntax enable
    set number
    set showcmd
]])
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a' -- 允许终端鼠标滚动与复制
vim.opt.hlsearch = true

-- Language
vim.opt.langmenu = 'en_US'

-- Format settings
vim.cmd([[
    filetype indent on
    set cindent
    set showmatch
    set wildmenu
    set expandtab
]])
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wildmode = 'longest:list'


-- Reset keymap
vim.opt.virtualedit = 'onemore'

-- Lightline settings
vim.opt.laststatus = 2
vim.cmd [[
  set noshowmode
  let g:lightline = {
  \ 'colorscheme': 'solarized'
  \ }
]] --不再在最下行显示输入模式，因为有状态栏

-- nohls by enter
vim.cmd[[
    noremap <leader><space> :nohlsearch<CR>
]]

-- gutter transparent
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})

vim.cmd[[
    noremap <leader>cc :s#_\(\l\)#\u\1#g<CR>:nohlsearch<CR>
]]


--- rsync
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    local curr = vim.api.nvim_buf_get_name(0)
    if (string.match(curr, 'douyin_web_2/'))
    then
      vim.cmd([[
        :AsyncRun -silent ~/source/rsync-g/bin/Debug/net7.0/rsync-g -u byteide@10.174.131.249 -l /home/meursault/workspace/douyin_web_2 -r /cloudide/workspace/douyin_web -d true
        call feedkeys("\<CR>")
      ]])
    elseif (string.match(curr, 'douyin_web_3/'))
    then
      vim.cmd([[
        :AsyncRun -silent ~/source/rsync-g/bin/Debug/net7.0/rsync-g -u byteide@10.174.152.122 -l /home/meursault/workspace/douyin_web_3 -r /cloudide/workspace/douyin_web -d true
        call feedkeys("\<CR>")
      ]])
    elseif (string.match(curr, 'douyin_web/'))
    then
      vim.cmd([[
       :AsyncRun -silent ~/source/rsync-g/bin/Debug/net7.0/rsync-g -u wangxinfu.wxf@10.37.21.176 -l /home/meursault/workspace/douyin_web -r /mnt/tmp/douyin_web -d true
        call feedkeys("\<CR>")
      ]])
    elseif (string.match(curr, 'douyin_home_web/'))
   then
      vim.cmd([[
        :AsyncRun -silent ~/source/rsync-g/bin/Debug/net7.0/rsync-g -u wangxinfu.wxf@10.37.21.176 -l /home/meursault/workspace/douyin_home_web -r /home/wangxinfu.wxf/workspace/douyin_home_web -d true
        call feedkeys("\<CR>")
      ]])
    else
    end
  end,
})
