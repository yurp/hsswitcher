
function! GetCppFilePair()
    let s:hsswitcher_py = resolve(expand('<sfile>:p:h')) . '/py/hsswitcher.py'
    execute 'pyfile' . s:hsswitcher_py
endfunc

