" Match *.mud files and files that start with Emacs' line (-*- Mudlle -*-)

function! s:DetectHeader()
    if !did_filetype() && getline(1) =~ '-\*- [mM]udlle -\*-'
        setfiletype mudlle
    endif
endfunction

augroup mudlleFtdetect
    autocmd!
    autocmd BufNewFile,BufRead *.mud setfiletype mudlle
    autocmd BufNewFile,BufRead *     call s:DetectHeader()
augroup END
