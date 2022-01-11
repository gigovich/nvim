set mouse=a
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set nobackup
set termguicolors
set number relativenumber

call plug#begin('~/.config/nvim/plugged')
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kamykn/spelunker.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'nanotee/sqls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'windwp/nvim-autopairs'
call plug#end()

" Solorized8
colorscheme solarized8
" colorscheme aurora

" higlight but not jump
nnoremap * *N

" higlight block in whole file
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>

" setup line length limit line
hi ColorColumn ctermbg=white
" Fuzzyfinder
nmap <leader>fz :FZF<CR>

" ACK and silversearch-ag
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Spelunker, disable it by default
let g:enable_spelunker_vim = 0

" Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_show_linenumbers=2

" JS
autocmd FileType javascript,javascriptreact setlocal expandtab
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal expandtab
autocmd FileType html,css,svelte setlocal expandtab

autocmd FileType javascript,javascriptreact setlocal tabstop=2
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal tabstop=2
autocmd FileType html,css,svelte setlocal tabstop=2

autocmd FileType javascript,javascriptreact setlocal shiftwidth=2
autocmd FileType typescript,typescriptcommon,typescriptreact setlocal shiftwidth=2
autocmd FileType html,css,svelte setlocal shiftwidth=2
autocmd BufEnter *.svelte :syntax sync fromstart

" Remap FZF and add other mappings by Telescope
nnoremap <silent> <leader>fz :Files<cr>
nnoremap <silent> <leader>fg :GitFiles<cr>
nnoremap <silent> <leader>fr :Rg<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>ft :Commits<cr>

" setup line length limit line
hi ColorColumn ctermbg=white

" Syntastic
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

" Netrw
let g:netrw_liststyle=3
let g:netrw_list_hide= '^\..\?'
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" Yaml
autocmd FileType yaml,yml setlocal shiftwidth=2
autocmd FileType yaml,yml setlocal tabstop=2

" Go
" autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
" autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil, 500)
" autocmd BufWritePre (InsertLeave?) <buffer> lua require('go.format').goimport()

lua << EOF
require('nvim-autopairs').setup()
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'gopls' },
  },
}
EOF
