"
"       VIMRC CONFIG
"
" Sections: 
"-> General 
"-> VIM User Interface 
"-> Colors and Fonts 
"-> Files and Backups 
"-> Text, Tab, and Indentation
"-> Plug-ins
"-> Plug-in Configuration
"-> Helper Functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable full compatibility with Vi
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype detection 
filetype on

" Enable and load plugins for the detected filetype
filetype plugin on 
filetype indent on

" Enable ALE plugin autocompletion
let g:ale_linters = {
      \ 'vhdl': ['hdl_checker'],
      \}
let g:ale_completion_enabled=1




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Enable auto completion menu after pressing TAB
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc 
if has("win16") || has("win32") 
    set wildignore+=.git\*,.hg\*,.svn\* 
else 
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store 
endif

" Height of the command bar
set cmdheight=1

" Show matching words, highlight, ignore case during search
set showmatch 
set hlsearch 
set ignorecase

" Try to be smart about cases while searching
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Remap to remove highlighting
nnoremap <CR> :noh<CR><CR>:<backspace>

" Don't redraw while executing macros
set lazyredraw

" Turn magic on for regular expressions
set magic

" Show matching brackets when cursor is over them
set showmatch

" Correct backspacing
set backspace=indent,eol,start

" Autoclose brackets and move cursor between them
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap <expr> <CR> search('{\%#}', 'n') ? "\<CR>\<CR>\<Up>\<C-f>" : "\<CR>"

" Get rid of annoying bell
set belloff=all




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set regular expression engine automatically
set regexpengine=0

set t_Co=256

" Set colourscheme
colorscheme molokai


" Add line numbers
set number

" Display cursorline and cursorcolumn ONLY in active window.
set cursorline cursorcolumn 

augroup cursor_off 
    autocmd!  
    autocmd WinLeave * set nocursorline nocursorcolumn 
    autocmd WinEnter * set cursorline cursorcolumn 
augroup END


" Show partial command in the last line of the screen
set showcmd

" Don't show current mode on the last line, airline plugin takes care of that
set noshowmode

" Set the GUI font used
set guifont=SauceCodePro\ NFM\ SemiBold:h16

" Set utf8 as standard encoding 
set encoding=utf8

" Set conceal level for NERDTree-devicon
set conceallevel=3

" Add sign column and reduce updatetime for GitGutter signs
set signcolumn=auto
set updatetime=100




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, Backups and Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Temp file directories
set undodir=$HOME/.vim/tmp/undo/     " undo files 
set backupdir=$HOME/.vim/tmp/backup/ " backups 
set directory=$HOME/.vim/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir)) 
    call mkdir(expand(&undodir), "p") 
endif 
if !isdirectory(expand(&backupdir)) 
    call mkdir(expand(&backupdir), "p") 
endif
if !isdirectory(expand(&directory)) 
    call mkdir(expand(&directory), "p")
endif




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab, and Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab = 4 spaces
set shiftwidth=4 
set tabstop=4 

" Disable text wrapping
set nowrap

" Auto indenting, smart indenting
set autoindent
set smartindent




""""""""""""""""""""""""""""""
" => Plug-ins
""""""""""""""""""""""""""""""
" List of plug-ins
call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Load icon plugin last
Plug 'ryanoasis/vim-devicons'

call plug#end()




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plug-in Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start NERDTree and vim-startify as splashscreen
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

" lightline configuration

" Set the colorscheme for lightline
let g:lightline = { 'colorscheme' : 'default' }

" lightline-ale integration and devicon addition
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = {
      \ 'left' : [ [ 'mode', 'paste' ], 
      \            [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \            [ 'lineinfo' ],
	  \            [ 'percent' ],
	  \            [ 'fileformat', 'fileencoding', 'filetype'] ] }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline.component_function = {
      \   'gitbranch': 'MyFugitiveHead',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ }

" indentline configuration
let g:indentLine_char_list = ['¦']
let g:indentLine_setColors = 1

" Set label mode for vim-sneak 
let g:sneak#label = 1

" Make NERDTree change CWD automatically
let g:NERDTreeChDirMode = 2




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function MyFugitiveHead()
  let head = FugitiveHead()
  if head != ""
    let head = "\uf126 " .. head
  endif
  return head
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction




" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"       EOF - VIMRC CONFIG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
