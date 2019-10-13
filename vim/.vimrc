" set file encoding first to prevent any decoding errors
set encoding=utf-8

" enable filetype detection
filetype on
" enable per-filetype indentation rules
filetype plugin indent on

" any time a user .vimrc is loaded, nocompatible is set unless the -C option is
" given, so we can comment out this option
"set nocompatible

" allow unindenting with shift-tab
inoremap <S-Tab> <C-V><Tab>

" set tab/indentation behavior
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab autoindent

" set h and l, as well as the arrow keys in normal/visual (<>) and insert ([])
" mode to wrap across line boundaries
set whichwrap+=<,>,h,l,[,]   " allow using arrow keys to navigate over EOL
" allow backspacing over automatic indents, line boundaries, and the start of
" insert mode
set backspace=indent,eol,start

" when splitting, prefer to create new windows on the bottom and the right
set splitright
set splitbelow

" set color scheme
try
    colorscheme jcd
catch /^Vim\%((\a\+)\)\=:E185/
" use this if jcd doesn't exist
    colorscheme slate
endtry

" enable syntax highlighting
syntax on

" show text position info (line, column, top, percent of file content, etc.)
" in the lower bar
set ruler
" show line numbers
set number

" enter normal mode with C-L
inoremap <C-L> <Esc>

" TODO: cmap/cnoremap and omap/onoremap mappings?

" use S-arrow to move windows
nnoremap <silent> <S-Right> <C-w>l
nnoremap <silent> <S-Left> <C-w>h
nnoremap <silent> <S-Up> <C-w>k
nnoremap <silent> <S-Down> <C-w>j
inoremap <silent> <S-Right> <C-o><C-w>l
inoremap <silent> <S-Left> <C-o><C-w>h
inoremap <silent> <S-Up> <C-o><C-w>k
inoremap <silent> <S-Down> <C-o><C-w>j

" <M-m> and <C-a> are switched here relative to Emacs
inoremap <M-m> <Home>
vnoremap <M-m> <Home>
imap <C-a> <C-o>^
vmap <C-a> ^
imap <C-e> <End>
vmap <C-e> <End>
imap <C-f> <Right>
vmap <C-f> <Right>
imap <C-b> <Left>
vmap <C-b> <Left>
imap <C-n> <Down>
vmap <C-n> <Down>
imap <C-p> <Up>
vmap <C-p> <Up>

inoremap <C-v> <PageDown>
vnoremap <C-v> <PageDown>
inoremap <M-v> <PageUp>
vnoremap <M-v> <PageUp>

inoremap <M-x> <C-o>:
vnoremap <M-x> :

inoremap <C-x>2 <C-o><C-w>s
inoremap <C-x>3 <C-o><C-w>v
inoremap <C-x>0 <C-o><C-w>c
inoremap <C-x>1 <C-o><C-w>o
inoremap <C-x>+ <C-o><C-w>=
inoremap <C-x>o <C-o><C-w>w

inoremap <C-x><C-f> <C-o>:hide edit<Space>


" http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files
command -nargs=0 -bar SmartSave
\ if &modified
\|  if empty(bufname('%'))
\|    browse confirm write
\|  else
\|    confirm write
\|  endif
\|endif

" use <C-s> in insert mode to save
inoremap <C-s> <C-o>:<C-u>SmartSave<CR>
inoremap <C-x><C-s> <C-o>:<C-u>SmartSave<CR>

" don't wrap lines by default.
" when textwidth (tw) is 0, manually using gq will wrap to 79 characters
set textwidth=0

" platform specific stuff
if has("win32") || has("win16")
    set guifont=Consolas:h10
else
    set shell=/bin/bash
endif

if has("gui_running")
    " gui specific stuff (gui is running or about to start)

    " Maximize gvim window
    set lines=52 columns=110
    " highlight current line
    set cursorline
else
    " terminal-specific stuff
endif

" cool statusline
set statusline=
set statusline+=%<
set statusline+=%f\ %h%m%r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %-14.(%l,%c%V%)
set statusline+=\ %P

set laststatus=2

set foldmethod=syntax
set foldlevelstart=99
