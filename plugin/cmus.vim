function! CMUSstatus()
  let cmd = "cmus-remote -Q"
  let cmdary = split(system(cmd), '\n')
  for settag in cmdary
    if match(settag,'tag title .\+') >= 0
      let title = join(remove(split(settag),2,-1))
    endif
    if match(settag, 'tag artist .\+') >= 0
      let artist = join(remove(split(settag),2,-1))
    endif
  endfor
  let current = "now playing: " . title . " by: " . artist

  "echomsg current
  return current

endfunction

function! CMUSlist()
  let cmd = "cmus-remote -C 'save -p -'"
  let playlist = split(system(cmd), '\n')
  for track in playlist
    if(playlist[0] == track)
      execute "normal! LGdGI" . track
    else
      call append(line('$'), track)
    endif
  endfor
endfunction

function! CMUSopen()
  if(bufexists('win.cmus'))
    let mpcwin = bufwinnr('win.cmus')
    if(mpcwin == -1)
      execute "sbuffer " . bufnr('win.cmus')
    else
      execute mpcwin . 'wincmd w'
      return
    endif
  else
    execute "10 new win.cmus"
  endif
  call CMUSlist()
endfunction

function! CMUSplaysong(no)
  let song = getline(a:no)
  let cmdcom = "cmus-remote -C "
  let cmdarg = "\"player-play " . song . "\""
  let cmd = cmdcom . cmdarg
  "echomsg "Now Playing: " . song
  let playsong = system(cmd)
  echomsg CMUSstatus()
endfunction


function! CMUSplay()
  let cmd = "cmus-remote -p"
  let play = system(cmd)
endfunction

function! CMUSstop()
  let cmd = "cmus-remote -s"
  let stop = system(cmd)
endfunction

command! CmusBrowser call CMUSopen()

command! -nargs=1 CmusPlayList call CMUSloadplaylist(<args>)

function! CMUSloadplaylist(playlist)
  let cmda = "cmus-remote -C 'load -p '"
  let list = "/home/derrick/music/" . a:playlist
  let cmd = cmda . list 
  let loadplaylist = system(cmd)
  if(bufexists('win.cmus'))
    execute "bw win.cmus" 
  endif
  echomsg "loaded: " . list
  call CMUSopen()
endfunction

function! CMUStest()
  let mpcnum = bufnr('cmus')
  echo mpcnum
endfunction
