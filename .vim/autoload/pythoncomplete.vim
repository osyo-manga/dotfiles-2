" ============================================================================
" File: pythoncomplete.vim
" Description: Vim completion for the python language (~ fuzzy)
" Maintainer: Giacomo Comitti - github.com/gcmt
" Version: 0.1
" Last Updated: 13 Jul 2013
"
" To speed up completion you can use the following mapping in your .vimrc file:
"
"  inoremap <C-O> <C-R>=QuickCompletion()<CR>
"  fu! QuickCompletion()
"      if pumvisible()
"           return '\<C-O>'
"       else
"            return '\<C-X>\<C-O>\<C-O>'
"       endif
"   endfu
"
" ============================================================================

if !has("python") || exists('g:loaded_pythoncomplete')
    finish
endif
let g:loaded_pythoncomplete = 1


function! pythoncomplete#Complete(findstart, base)
    "findstart = 1 when we need to get the text length
    if a:findstart == 1
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\w'
            let start -= 1
        endwhile
        return start
    "findstart = 0 when we need to return the list of completions
    else
        exec "py complete('" . a:base . "')"
        return {"words": g:pythoncomplete_completions, "refresh": "always"}
    endif
endfunction


python << PYTHONEOF
from __future__ import division
import vim
import tokenize
from cStringIO import StringIO
from itertools import combinations
from bisect import insort_left


def smart_match(seed, target, start=-1):
    """Smart matching."""
    if start >= len(target)-1:
        return

    positions = []
    a_token_starts = True
    last_successful_match = -1
    _seed = seed

    for i, l in enumerate(target):

        if i <= start:
            continue

        if not _seed:
            break

        if (l.lower() == _seed[0].lower() and
            (not positions or i-1 in positions or a_token_starts)):

            last_successful_match = i
            positions.append(i)
            _seed = _seed[1:]

        a_token_starts = False

        if (l in ('_', '-') or
            (i < len(target)-1 and target[i+1].isupper() and
            not os.path.splitext(target)[0].isupper())):

            a_token_starts = True

    if not _seed:
        return positions
    elif last_successful_match > -1:
        return smart_match(seed, target, start=last_successful_match)


def tokens(buffer):
    """To generate all the python tokens for the given buffer."""
    return tokenize.generate_tokens(
        StringIO("\n".join(buffer)).readline)


def compute_score(positions, curr_line, token_line, tot_lines):
    """To compute the score of a single match."""
    diffs = [abs(c[0]-c[1]) for c in combinations(positions, 2)]
    score = (sum(positions) / len(positions) +
            abs(token_line-curr_line) / tot_lines)
    if diffs:
         score += sum(diffs) / len(diffs)
    return score


def complete(seed):
    """To find all completion candidates."""
    curr_buf = vim.current.buffer
    completions = []
    found = {}

    for buf in [curr_buf] + list(vim.buffers):

        if buf.name is None or not buf.name.endswith(".py"):
            continue

        tot_lines = len(buf)
        if buf.name == curr_buf.name:
            curr_line = vim.current.window.cursor[0]
        else:
            curr_line = 0

        for t, token, start, _, _ in tokens(buf):
            if t == tokenize.NAME and token != seed and token not in found:
                found[token] = True
                positions = smart_match(seed, token)
                if positions:
                    score = compute_score(
                        positions, curr_line, start[0], tot_lines)
                    insort_left(completions, (score, token))

    vim.command('let g:pythoncomplete_completions = {}'.format(
        [w for score, w in completions]))
PYTHONEOF
