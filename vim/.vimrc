set encoding=utf-8

" allow untabbing
inoremap <S-Tab> <C-V><Tab>
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab cindent autoindent

set whichwrap+=<,>,[,]   " allow using arrow keys to navigate over EOL
set backspace=indent,eol,start    " allow backspacing across EOL

" platform specific stuff
if has("win32") || has("win16")
    set guifont=Consolas:h10
else
    set shell=/bin/bash
endif

colo slate  " color scheme
syntax on   " enable syntax highlighting

" enter normal mode with C-L
inoremap <C-L> <Esc>

" use C-arrow to move windows
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j
