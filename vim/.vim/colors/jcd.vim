"%% SiSU Vim color file
" comment
:set background=light
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif
let colors_name = "jcd"
:hi Normal guifg=#000000 guibg=#F7F7F7
:hi Cursor guifg=#000000 guibg=#000000
:hi CursorLine guibg=#eeeeec
:hi CursorColumn guibg=#eeeeec
:hi VertSplit guibg=#e9e9e9 guifg=grey40 gui=none cterm=reverse
:hi Folded guibg=grey40 guifg=black ctermfg=grey ctermbg=darkgrey
:hi FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=7
:hi IncSearch guifg=green guibg=black cterm=none ctermfg=yellow ctermbg=green
:hi ModeMsg guifg=#000000 cterm=none ctermfg=brown
:hi MoreMsg guifg=SeaGreen ctermfg=darkgreen
:hi NonText guifg=#3F7F5F guibg=#F7F7F7 cterm=bold ctermfg=blue
:hi Question guifg=springgreen ctermfg=green
:hi Search guibg=peru guifg=wheat cterm=none ctermfg=grey ctermbg=blue
:hi SpecialKey guifg=#7F0055 gui=bold ctermfg=darkgreen
:hi StatusLine guibg=#e9e9e9 guifg=black gui=none cterm=bold,reverse
:hi StatusLineNC guibg=#e9e9e9 guifg=grey40 gui=none cterm=reverse
:hi Title guifg=#7F0055 gui=bold cterm=bold ctermfg=yellow
:hi Statement guifg=#7F0055 ctermfg=lightblue
:hi Visual gui=none guifg=khaki guibg=olivedrab cterm=reverse
:hi WarningMsg guifg=salmon ctermfg=1
:hi String guifg=#2A00FF ctermfg=darkcyan
:hi Comment term=bold ctermfg=11 guifg=#3F7F5F
:hi Constant guifg=#000000 ctermfg=brown
:hi Special guifg=#3F7F5F gui=bold ctermfg=brown
:hi Identifier guifg=#000000 ctermfg=red
:hi Include guifg=#7F0055 gui=bold ctermfg=red
:hi PreProc guifg=#7F0055 gui=bold ctermfg=red
:hi Operator guifg=#000000 ctermfg=Red
:hi Define guifg=#000000 gui=bold ctermfg=yellow
:hi Type guifg=#7F0055 ctermfg=2
:hi Function guifg=#000000 ctermfg=brown
:hi Structure guifg=#7F0055 gui=bold ctermfg=green
:hi LineNr guifg=#3F7F5F ctermfg=3
:hi Ignore guifg=grey40 cterm=bold ctermfg=7
:hi Todo guifg=orangered guibg=yellow2
:hi Directory ctermfg=darkcyan
:hi ErrorMsg cterm=bold guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi VisualNOS cterm=bold,underline
:hi WildMenu ctermfg=0 ctermbg=3
:hi DiffAdd ctermbg=4
:hi DiffChange ctermbg=5
:hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
:hi DiffText cterm=bold ctermbg=1
:hi Underlined cterm=underline ctermfg=5
:hi Error guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi SpellErrors guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
