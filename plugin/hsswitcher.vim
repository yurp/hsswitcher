
let s:this_script_path = escape(expand('<sfile>:p:h'), '\')

" python -------------------------------------------------------------------------------------------

function! s:SetupPlugin()
python << EOF

import os
import sys
import vim

sys.path.insert(0, os.path.join(vim.eval('s:this_script_path'), '../python'))

EOF
endfunction

function! s:HssSwitchCall()
python << EOF

from hsswitcher import hsswitch_call

hsswitch_call(p =  vim.current.buffer.name)

EOF
endfunction

" python3 ------------------------------------------------------------------------------------------

function! s:SetupPlugin3()
python3 << EOF

import os
import sys
import vim

sys.path.insert(0, os.path.join(vim.eval('s:this_script_path'), '../python'))

EOF
endfunction

function! s:HssSwitchCall3()
python3 << EOF

from hsswitcher import hsswitch_call

hsswitch_call(p =  vim.current.buffer.name)

EOF
endfunction

" no python ----------------------------------------------------------------------------------------

function! s:HssSwitchCallNoPython()
    echo "python isn't supported"
endfunction

" --------------------------------------------------------------------------------------------------

if has("python")
    call s:SetupPlugin()
    command! HssSwitch call s:HssSwitchCall()
elseif has("python3")
    call s:SetupPlugin3()
    command! HssSwitch call s:HssSwitchCall3()
else
    command! HssSwitch call s:HssSwitchCallNoPython()
endif

