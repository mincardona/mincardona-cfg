" set file encoding first to prevent any decoding errors
set encoding=utf-8

let mapleader=","

" any time a user .vimrc is loaded, nocompatible is set unless the -C option is
" given, so we can comment out this option
set nocompatible

" enable filetype detection
filetype on
" enable per-filetype indentation rules
filetype plugin indent on

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

" don't close old buffers when opening a new one
set hidden

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

" use S-arrow to move between windows
nnoremap <silent> <S-Right> <C-w>l
nnoremap <silent> <S-Left> <C-w>h
nnoremap <silent> <S-Up> <C-w>k
nnoremap <silent> <S-Down> <C-w>j
inoremap <silent> <S-Right> <C-o><C-w>l
inoremap <silent> <S-Left> <C-o><C-w>h
inoremap <silent> <S-Up> <C-o><C-w>k
inoremap <silent> <S-Down> <C-o><C-w>j

" <M-m> and <C-a> are switched here relative to Emacs
" Go to absolute beginning of line (seems broken?)
inoremap <M-m> <C-o>0
vnoremap <M-m> 0
" Go to start of line after whitespace
inoremap <C-a> <C-o>^
vnoremap <C-a> ^
" make <C-e> go to end-of-line (like Emacs) unless the completion
" popup menu is open (<C-e> exits the popup menu)
inoremap <expr> <C-e> pumvisible() ? '<C-e>' : '<End>'
vnoremap <expr> <C-e> pumvisible() ? '<C-e>' : '<End>'

" enter text command
inoremap <M-x> <C-o>:
vnoremap <M-x> :

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

    " integrate with the system clipboard
    if has("clipboard")
        set clipboard=unnamed
    end

    " use common paste shortcut
    inoremap <C-v> <C-r>*
    cnoremap <C-v> <C-r>*
else
    set shell=/bin/bash

    " integrate with the system clipboard
    if has("clipboard")
        set clipboard=unnamedplus
    end

    " use common paste shortcut
    " inoremap <C-v> <C-r>+
    " cnoremap <C-v> <C-r>+
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
" always display status bar
set laststatus=2

" code folding
set foldmethod=syntax
set foldlevelstart=99

" enable right-click menu
set mousemodel=popup

set wildmenu
set wildmode=list:full

" enable mouse control
set mouse=a

" cursor settings (https://vimhelp.org/term.txt.html)
" terminal code: use bar cursor in insert mode
let &t_SI = "\<Esc>[5 q"
" terminal code: use underline cursor in replace mode
let &t_SR = "\<Esc>[3 q"
" terminal code: use block cursor otherwise
let &t_EI = "\<Esc>[1 q"
