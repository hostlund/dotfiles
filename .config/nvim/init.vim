" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
let g:python3_host_prog = '/usr/bin/python3'

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'scrooloose/nerdTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'gko/vim-coloresque'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/vim-gitbranch'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
" https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ervandew/supertab'
" Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
" Plug 'othree/html5.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'prabirshrestha/async.vim'
Plug 'janko/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'pechorin/any-jump.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanolsonx/vim-lsp-python'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

" Config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
syntax on
set number
set noshowmode
set tabstop=2 shiftwidth=2 expandtab

let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('omni', 'functions', {
  \ 'javascript': ['tern#Complete', 'jspc#omni']
\})

set completeopt=longest,menuone,preview
let g:deoplete#custom#sources = {}
let g:deoplete#custom#sources['javascript.jsx'] = ['file', 'ternjs']

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#sources#ternjs#types = 1

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'python': ['yapf']
\}

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

let test#strategy = "asyncrun_background_term"

let g:lsp_preview_float = 1

" lightline


let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],
      \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \           ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \ },
      \ 'component_expand' : {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type' : {
      \   'linter_checking': 'middle',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'middle',
      \ },
      \ }
"let g:lightline#ale#indicator_checking = "\uf110"
"let g:lightline#ale#indicator_warnings = "\uf071"
"let g:lightline#ale#indicator_errors = "\uf05e"
"let g:lightline#ale#indicator_ok = "\uf00c"


" Colors / Themes
colorscheme gruvbox

" KeyMaps
nmap <C-n> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <C-e> <Plug>(ale_next_wrap)

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Normal mode: Jump to definition under cursore
nnoremap <leader>s :AnyJump<CR>
nnoremap <C-j> :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
" xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

nnoremap <C-i> :IndentGuidesToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
