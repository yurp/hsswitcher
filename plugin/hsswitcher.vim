
let s:this_script_path = escape(expand('<sfile>:p:h'), '\')

function! s:SetupPlugin()
python3 << EOF

import os
import sys
import vim

p = vim.eval('s:this_script_path')
sys.path.insert(0, os.path.join(p, '../python'))

EOF
endfunction

function! s:HssSwitchCall()
python3 << EOF

from hsswitcher import hsswitcher

pair = hsswitcher(p =  vim.current.buffer.name)
if pair:
    vim.command('e %s' % pair);
else:
    print('c++ pair not found')

EOF
endfunction

call s:SetupPlugin()

command! HssSwitch call s:HssSwitchCall()

