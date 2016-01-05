
function! HssSwitchCall()
python << EOF

from hsswitcher import hsswitcher
import vim

pair = hsswitcher(p =  vim.current.buffer.name)
if pair:
    vim.command('e %s' % pair);
else:
    print 'c++ pair not found'

EOF
endfunction

command! HssSwitch call HssSwitchCall()

