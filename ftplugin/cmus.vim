set buftype=nofile
set textwidth=180
setlocal statusline=%!CMUSstatus()
command! -buffer PlaySelectedSong call CMUSplaysong(line('.'))
"command! CmusBrowser call CMUSopen()
