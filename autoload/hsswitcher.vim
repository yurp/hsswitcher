
let s:this_script_path = escape(expand('<sfile>:p:h'), '\')

function! SetupPlugin()
python << EOF

import os
import sys
import vim

p = vim.eval('s:this_script_path')
sys.path.insert(0, os.path.join(p, '../python')

EOF
endfunction

SetupPlugin()

