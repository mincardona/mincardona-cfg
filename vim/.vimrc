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
colo slate
" enable syntax highlighting
syntax on

" show text position info (line, column, top, percent of file content, etc.)
" in the lower bar
set ruler
" show line numbers
set number

" enter normal mode with C-L
inoremap <C-L> <Esc>

" use C-arrow to move windows
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

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
else
    " terminal-specific stuff
endif

