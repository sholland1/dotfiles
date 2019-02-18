"autosave
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

"persistent undo
set undofile

"edit note
Alias enew execute\ "e"\ GenerateIntFilename()<Enter>
function! GenerateIntFilename()
    let l:path = '~\Documents\Notes\'
    let l:files = split(globpath(l:path, '*.txt'), '\n')
    call map(l:files, 'str2nr(fnamemodify(v:val,":t:r"))')
    return l:path . (max(l:files) + 1) . '.txt'
endfunction

