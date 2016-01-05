
import collections
import os
import sys
import vim

def is_header(p):
    _, ext = os.path.splitext(p)
    return os.path.isfile(p) and ext in ('.h', '.hpp', '.hxx')

def is_src(p):
    _, ext = os.path.splitext(p)
    return os.path.isfile(p) and ext in ('.c', '.cpp', '.cxx')

def is_root(p):
    return p == os.path.dirname(p)

def get_base_name(p):
    return os.path.splitext(os.path.basename(p))[0]

def bfs(p, max_depth, fbase, f_is_header):
    pair = None
    if not is_root(p):
        pp = os.path.dirname(p)
        q = collections.deque(((pp, 0),))
        while len(q) > 0 and not pair:
            curr_p, curr_depth = q.popleft()
            if os.path.isdir(curr_p) and curr_depth < max_depth:
                ldir = [ os.path.join(curr_p, p) for p in os.listdir(curr_p) ]
                q.extend(zip(ldir, [curr_depth + 1] * len(ldir)))
            elif os.path.isfile(curr_p) and get_base_name(curr_p) == fbase and (
                 (f_is_header and is_src(curr_p)) or (not f_is_header and is_header(curr_p))):
                pair = curr_p

    return pair

def hsswitcher(p, max_depth = 9, curr_depth = 4):
    pair = None
    if os.path.exists(p):
        p = os.path.abspath(p)
        f_is_header = is_header(p)
        if f_is_header or is_src(p):
            fname = os.path.basename(p)
            fbase, _ = os.path.splitext(fname)
            for i in xrange(curr_depth, 0, -1):
                pair = bfs(p, max_depth - i, fbase, f_is_header)
                if pair:
                    break
                p = os.path.dirname(p)
    return pair

pair = hsswitcher(p =  vim.current.buffer.name)
if pair:
    vim.command('e %s' % pair);
else:
    print 'c++ pair not found'

