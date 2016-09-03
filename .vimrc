inoremap <S-Tab> <C-V><Tab>
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab cindent autoindent
set backspace=2
set backspace=indent,eol,start

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

