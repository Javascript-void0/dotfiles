" general
set nocompatible                   " disable compatibility to old-time vi
set showmatch                      " show matching 
set ignorecase                     " case insensitive 
set wildignorecase                 " wildignorecase duh
set mouse=a                        " idk mouse stuff
set nowrap                         " line wrappin
set hlsearch                       " highlight search 
set incsearch                      " incremental search
set tabstop=4                      " tab character width of 8
set softtabstop=4                  " idk
set shiftwidth=4                   " width for autoindents
set smarttab                       " smart stuff
set expandtab                      " converts tabs
set autoindent                     " indent a new line the same amount as the line just typed
set smartindent                    " smart indenting?
set number                         " add line numbers
set wildmode=longest,list          " get bash-like tab completions
set cc=0                           " set an 80 column border for good coding style
filetype plugin indent on          " allow auto-indenting depending on file type
syntax on                          " syntax highlighting
set mouse=a                        " enable mouse click
set clipboard=unnamedplus          " using system clipboard
filetype plugin on                 " no clue
set cursorline                     " highlight current cursorline
set ttyfast                        " speed up scrolling in vim
set noswapfile                     " disable creating swap file
set backupdir=~/.cache/vim         " directory to store backup files.
set t_Co=256                       " 256 colors?
set path+=**                       " subdirectories
set termguicolors                  " no clue :shrug:
set foldenable                     " fold with zc, zo
set foldmethod=marker              " default marker: {{{  }}}

" install plugins
call plug#begin()

    Plug 'ellisonleao/gruvbox.nvim'                             " colorscheme
    Plug 'vim-airline/vim-airline'                              " bottom bar thing
    Plug 'vim-airline/vim-airline-themes'                       " bottom bar thing theme
    Plug 'preservim/nerdtree'                                   " file explorer
    Plug 'ap/vim-css-color'                                     " css color highlighting
    Plug 'romgrk/barbar.nvim'                                   " tab buffers
    Plug 'sheerun/vim-polyglot'                                 " language pack
    Plug 'jiangmiao/auto-pairs'                                 " complete pairs
    Plug 'tpope/vim-surround'                                   " add surrounding pairs
    Plug 'plasticboy/vim-markdown'                              " markdown
    Plug 'tpope/vim-commentary'                                 " commenting
    Plug 'mg979/vim-visual-multi'                               " multiple cursors
    Plug 'sirver/ultisnips', {'on': []}                         " snippets (for coc-snippets)
    Plug 'airblade/vim-gitgutter'                               " git changes
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }           " autocomplete
    Plug 'nvim-treesitter/nvim-treesitter', {
    \    'do': ':TSUpdate'
    \    }                                                      " syntax highlighting i think
    " Plug 'mikroskeem/vim-sk-syntax'                             " skript syntax highlighting
    Plug 'voldikss/vim-floaterm'                                " floating terminal
    Plug 'xiyaowong/transparent.nvim'                           " make background transparent
    " Plug 'peterhoeg/vim-qml'                                    " qt gui
    Plug 'bullets-vim/bullets.vim'                              " lists
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " fzf
    Plug 'junegunn/fzf.vim'                                     " fzf vim
    
call plug#end()

" commands for vim
command! Reload execute "so $MYVIMRC"
cnoreabbrev reload Reload
command! Config execute "e $MYVIMRC"
cnoreabbrev config Config
command! W execute "w"
cnoreabbrev W w
command! Q execute "q"
cnoreabbrev Q q

" :gof opens directory of current file in NERDTree
command! Gof execute "NERDTree %:p:h"

" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" enable TreeSitter highlighting
autocmd VimEnter * TSEnable highlight
autocmd VimEnter * TSDisable highlight lua

" disable folding for markdown
autocmd FileType markdown setlocal nofoldenable




" 
" [ ========== Theme ========== ]
"
colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_medium'
hi Normal               guibg=NONE ctermbg=NONE " general transparent background
hi EndOfBuffer          guibg=NONE ctermbg=NONE " unused space transparent background
hi LineNr               guibg=NONE ctermbg=NONE " line numbers transparent background
hi SignColumn           guibg=NONE ctermbg=NONE " git-gutter transparent background

hi CocFloating          guibg=NONE ctermbg=NONE " coc-nvim transparent background
hi Floaterm             guibg=NONE ctermbg=NONE " floaterm transparent background
hi FloatermBorder       guifg=#545454 guibg=#282828 ctermbg=NONE " floaterm transparent borders
    
hi GitGutterAdd         guibg=NONE ctermbg=NONE " gitgutter transparent background
hi GitGutterChange      guibg=NONE ctermbg=NONE
hi GitGutterDelete      guibg=NONE ctermbg=NONE

hi FZF                  guibg=#282828 guifg=#bdae93

let g:fzf_colors = 
\ { 'bg':      ['bg', 'FZF'],
  \ 'border':  ['fg', 'FZF'] }



" 
" [ ========= General Remap ========== ]
"

" nagivation between split panes
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" nerdtree toggle
nnoremap <C-b> <Cmd>:NERDTreeToggle<CR>
inoremap <C-b> <Cmd>:NERDTreeToggle<CR>

" occasional ctrl-s
inoremap <silent> <C-s> <Cmd>:w<CR>
nnoremap <silent> <C-s> <Cmd>:w<CR>

" 0 move to beginning of line (default), - to move end of line
nnoremap <silent> - $
vnoremap <silent> - $

" change commenting for c# and skript
augroup comment_string
    autocmd!
    autocmd FileType cs setlocal commentstring=//\ %s
    autocmd FileType sk setlocal ft=skript
    autocmd FileType skript setlocal commentstring=#\ %s
    autocmd FileType c setlocal commentstring=//\ %s
    autocmd FileType ino setlocal commentstring=//\ %s
augroup END

" open explorer where current file is located - ref https://vi.stackexchange.com/a/31847
func! File_manager() abort

    if has("win32") " win11
        if exists("b:netrw_curdir")
            let path = substitute(b:netrw_curdir, "/", "\\", "g")
        elseif expand("%:p") == ""
            let path = expand("%:p:h")
        else
            let path = expand("%:p")
        endif
        
        silent exe '!explorer.exe /select,' .. path


    elseif has ("unix") " wsl2
        if expand("%:p") == ""
            let path = substitute(expand("%:p:h"), "/", "\\", "g")
        else
            let path = substitute(expand("%:p"), "/", "\\", "g")
        endif

        silent exe '!explorer.exe /select,"U:' .. path .. '"'

    endif

endfunc

" nnoremap <silent> gof :silent exe '!explorer.exe .'<CR>
nnoremap <silent> gof :call File_manager()<CR>



" 
" [ ========== barbar =========== ]
"
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-b> <Cmd>BufferClose<CR>

inoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
inoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
inoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
inoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
inoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
inoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>

let g:barbar_auto_setup = v:false " disable auto-setup
lua << EOF
require'barbar'.setup {
    icons = {
        filetype = {
            enabled = false
            }
        }
    }
EOF



" 
" [ =========== coc.nvim ========== ]
"
let g:coc_global_extensions = [
\  'coc-json', 
\  'coc-html', 
\  'coc-tsserver', 
\  'coc-python', 
\  'coc-java', 
\  'coc-css', 
\  'coc-clangd',
\  'coc-snippets'
\] " :CocList extensions

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunc

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" GoTo code navigation
nmap <silent> L <Plug>(coc-definition)

" tab to trigger completion and jump
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = "<s-tab>"


" 
" [ ========== Terminal ========== ]
"
autocmd TermOpen * startinsert

" floating terminal
nnoremap <silent> <C-t> :FloatermToggle<CR>
let g:floaterm_title="TERMINAL"
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_autoinsert=v:true

" silently start floaterm
autocmd VimEnter * FloatermNew --silent

" <esc> to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" <esc> for both fzf and terminal
tnoremap <silent> <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>:FloatermHide<Cr>"



" 
" [ ========== fzf ========== ]
"
nnoremap <silent> <C-f> :Files<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" options for preview
" if has("win32") " win11
"     command! -bang -nargs=? -complete=dir Files
"         \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat --theme=gruvbox-dark {}']}, <bang>0)
" endif
if has("unix") " wsl2
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'options': ['--preview', '~/.config/nvim/fzf-preview.sh {}']}, <bang>0)
endif

" open fzf if no file specified at startup
if argc() == 0 || isdirectory(argv(0))
    autocmd VimEnter * execute "bdelete" | Files
endif

" holy fuck
command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
