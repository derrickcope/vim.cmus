setlocal conceallevel=3
setlocal concealcursor=n
syntax region FilePath start=/^\/home/ end=/\/music\// conceal
highlight FilePath cterm=bold ctermfg=Blue ctermbg=black
