let s:save_cpo = &cpo
set cpo&vim

function! s:Copy(text)
    let encodedText=""
    if $TMUX != ""
        let encodedText=substitute(a:text, '\', '\\', "g")
    else
        let encodedText=substitute(a:text, '\', '\\\\', "g")
    endif
    let encodedText=substitute(encodedText, "\'", "'\\\\''", "g")
    let executeCmd="echo -n '".encodedText."' | base64 | tr -d '\\n'"
    let encodedText=system(executeCmd)
    if $TMUX != ""
        " tmux
        let executeCmd='echo -en "\033Ptmux;\033\033]52;;'.encodedText.'\033\033\\\\\033\\" > /dev/tty'
    elseif $TERM == "screen"
        " screen
        let executeCmd='echo -en "\033P\033]52;;'.encodedText.'\007\033\\" > /dev/tty'
    else
        let executeCmd='echo -en "\033]52;;'.encodedText.'\033\\" > /dev/tty'
    endif
    call system(executeCmd)
    redraw!
endfunction

" Yank selected content 
function! CopySelected() range
    let tmp = @@
    silent normal gvy
    let text = @@
    let @@ = tmp
    call s:Copy(text)
endfunction

" Yank lines 
function! CopyLines(line1, line2)
    let lines = getline(a:line1, a:line2)
    for idx in range(len(lines))
        let lines[idx] = escape(lines[idx], '\')
    endfor
	let text = join(lines, '\n')
    call s:Copy(text)
endfunction

command! -range CopySelected call CopySelected()
command! -range CopyLines call CopyLines(<line1>, <line2>)

let &cpo = s:save_cpo
unlet s:save_cpo
