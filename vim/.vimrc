
" .vimrc

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    " For some reasons prevents YCM server to crash when MacVim.app is
    " opened outside the terminal.
    let $PATH = $HOME.'/opt/go/bin:'.$HOME.'/opt/bin:/usr/local/bin:'.$PATH
    let $GOPATH=$HOME.'/dropbox/dev/go:'.$GOPATH
    let $GOPATH=$HOME.'/opt/go:'.$GOPATH

    set rtp+=$HOME/dropbox/dev/vim/surfer
    set rtp+=$HOME/dropbox/dev/vim/gate
    set rtp+=$HOME/dropbox/dev/vim/wildfire
    set rtp+=$HOME/dropbox/dev/vim/plum
    set rtp+=$HOME/dropbox/dev/vim/taboo
    set rtp+=$HOME/dropbox/dev/vim/breeze
    set rtp+=$HOME/dropbox/dev/vim/tube
    set rtp+=$HOME/.vim/bundle/gocode/vim
    set rtp+=/usr/local/opt/go/libexec/misc/vim

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'goldfeld/vim-seek'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'tpope/vim-surround'
    Bundle 'majutsushi/tagbar'
    Bundle 'SirVer/ultisnips'
    Bundle 'mattn/emmet-vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/gundo.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle "Valloric/YouCompleteMe"
    Bundle 'nsf/gocode'
    Bundle 'ap/vim-css-color'
    Bundle 'tpope/vim-haml'
    Bundle 'tpope/vim-markdown'
    Bundle 'suan/vim-instant-markdown'

    filetype plugin indent on
    syntax on

    " personal stuff
    sil! source ~/dropbox/personal/.vimrc

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_stuff
        au!

        au VimResized * wincmd = | redraw
        au BufReadPost * call RestoreCursorPosition()
        au BufWritePre * sil! call RemoveTrailingWhitespaces()
        au BufReadPost * if &key != "" | setl noswf nowb viminfo= nobk nostmp history=0 secure | endif
        au BufEnter * if !empty(&buftype) | setl scrolloff=0 | endif

        au BufWritePost .vimrc source $MYVIMRC
        au BufWritePost plum.vim nested colorscheme plum

        au BufRead,BufNewFile *.pde  setf java
        au BufRead,BufNewFile *.json  setf javascript

        au BufRead,BufNewFile *.txt,*.md,*.rst  setl nonu nornu foldcolumn=2
        au BufRead,BufNewFile *.txt,*.md,*.rst  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>

        au BufRead,BufNewFile .gitconfig  setl noet
        au BufRead,BufNewFile *.vim,.vimrc  setl fdm=marker
        au BufRead,BufNewFile *.html,*.css  setl sts=2 ts=2 sw=2

        au BufWinEnter *.py let g:match80 = matchadd("SpellRare", "\\%81v.", -1)
        au BufWinLeave *.py sil! call matchdelete(g:match80) | unlet! g:match80
        au BufRead,BufNewFile *.py  setl cin tw=79 fdm=indent fdn=2 fdl=1

        au BufRead,BufNewFile *.go  setl nolist ts=4 noet fdm=syntax fdn=1 makeprg=go\ build
        au BufRead,BufNewFile *.go  nnoremap <buffer> <F5> :Fmt<CR>:w<CR>

    augroup END

" }}}

" OPTIONS ---------------------------------- {{{

    " syntax options
    let html_no_rendering = 1

    "let g:plum_force_bg = "dark"
    "let g:plum_cursorline_style = 4
    colorscheme plum

    if has("gui_running")

        set guioptions=mc  " remove 'e' for terminal-style tabs
        set linespace=1

        if has("gui_macvim")
            set guifont=Source\ Code\ Pro\ Light:h13
            "set guifont=GohuFont:h14
        endif

    else

        augroup iterm
            au!
            " When vims starts set the block shape, while when vim is closed
            " restore the vertical bar (iTerm)
            au VimLeave * sil !echo -ne "\033]50;CursorShape=1\a"
            au VimEnter * sil !echo -ne "\033]50;CursorShape=0\a"
        augroup END

        " Use the correct cursor shape according to the current mode
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " insert mode (vertical bar)
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " normal mode (block)

    endif

    set encoding=utf8
    set fileformats="unix,dos,mac"
    set hidden
    set tags=
    set backspace=2
    set modeline
    set cryptmethod=blowfish
    set shell=bash\ -i
    set ttyfast
    set t_Co=256
    set startofline
    set lazyredraw
    set switchbuf=useopen,usetab

    set noerrorbells
    set visualbell
    set t_vb=

    set autochdir
    set autoread

    set sessionoptions+=tabpages,globals
    set viminfo=!,'100,h,n~/.viminfo
    set history=1000
    set undolevels=10000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=1000

    set noswapfile
    set nobackup

    if $TMUX == ''
        set clipboard+=unnamed
    endif

    set formatoptions=qn1c
    set nrformats-=octal

    set timeout
    set ttimeoutlen=50

    set nonumber
    set nocursorline
    call matchadd("SpellRare", "\\%101v.", -1)

    set mouse=a
    set virtualedit=all

    set title
    set titlestring=(\ %(%{&ft},\ %)%(%{&ff}%)%(,\ %{&fenc}%)\ )
    set titlestring+=\ %<%{GitCurrentBranch('⎇\ ')}\ %F
    set titlelen=100

    set tabpagemax=19
    set showtabline=1

    set complete-=i
    set completeopt=longest,menuone
    set omnifunc=syntaxcomplete#Complete

    set wildmenu
    set wildmode=longest,full
    set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,tags
    set wildignore+=*.swp,*.cache,*.jar,*.bat,*.dat,*.gif

    set cmdheight=1
    set report=0
    set shortmess=IaA
    set noshowmode
    set showcmd

    set sidescrolloff=1
    set scrolloff=3

    set smarttab
    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
    set shiftround

    set smartindent

    set splitbelow
    set splitright

    set nowrap

    set nolist
    set fillchars=vert:\|
    set listchars=tab:\|\ ,trail:·,precedes:…,extends:…

    set nowrap
    set textwidth=100
    set showbreak=..
    set linebreak

    set ignorecase
    set smartcase
    set showmatch
    set incsearch
    set hlsearch
    set gdefault

    set nofoldenable
    set foldcolumn=1
    set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
    set foldtext=CustomFoldText()

    hi clear FoldColumn | hi link FoldColumn Hidden
    augroup hide_foldcolumn_signs
        au!
        au Colorscheme * hi clear FoldColumn | hi link FoldColumn Hidden
    augroup END

" }}}

" STATUSLINE ------------------------------- {{{

    set laststatus=2

    set stl=%(\ %q%w%r%h%#StatusLineErr#%m%*%)\ #%n\ %{FilePath()}
    set stl+=%=
    set stl+=%{AlternateBuffer()}%1l:%02v\ ~\ %P\ "

" }}}

" MAPPINGS --------------------------------- {{{

    " basic
    " -------------------------------------------------------------------------

    let mapleader=","
    inoremap jj <ESC>

    " commands
    " -------------------------------------------------------------------------

    " sudo write
    command! -bang SudoWrite w<bang> !sudo tee % > /dev/null

    " rename the current buffer
    command! -bar -nargs=1 -bang -complete=file Rename
        \ sav<bang> <args> |
        \ setl modified |
        \ call delete(expand('#:p')) |
        \ exec "silent bw " . expand('#:p')

    " typos
    cabbrev E e | cabbrev W w | cabbrev Q q | cabbrev H h
    cabbrev Wa wa | cabbrev Wq wq | cabbrev Set set | cabbrev Mes mes
    cabbrev Echo echo | cabbrev ehco echo

    " tabs
    " -------------------------------------------------------------------------

    " tabs
    nnoremap <silent> <leader>tt :tabedit! <C-R>=expand("%:p")<CR><CR>
    nnoremap <silent> <leader>tc :tabclose<CR>

    " go to next/previous tab
    nnoremap <silent> [t :tabprevious<CR>
    nnoremap <silent> ]t :tabnext<CR>

    " tabs relocation
    nnoremap <silent> <left> :exec 'sil! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <right> :exec 'sil! tabmove ' . tabpagenr()<CR>

    " windows
    " -------------------------------------------------------------------------

    " close the window
    nnoremap <silent> Q :call CloseWindow()<CR>

    " windows navigation
    nnoremap <C-H> <C-W>h
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-L> <C-W>l

    " split windows
    nnoremap <leader>w <C-W>v:b#<CR>
    nnoremap <leader>W <C-W>s:b#<CR>

    nnoremap <C-SPACE> <C-W>W
    nnoremap <SPACE> <C-W>w

    " buffers
    " -------------------------------------------------------------------------

    " go to next/previous buffer
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> [b :bprevious<CR>

    " kill the buffer but keep the window
    nnoremap <silent> <leader>q :call CloseBuffer(0)<CR>
    nnoremap <silent> <leader>Q :call CloseBuffer(1)<CR>

    " edit to the alternate buffer; if it is already visible just move to
    " the window containing the buffer
    nnoremap <silent> _ :call GoToBuffer("#")<CR>

    for i in range(1, 9)
        exec "nnoremap <silent> <leader>".i." :call GoToBuffer(".i.")<CR>"
    endfor

    " editing
    " -------------------------------------------------------------------------

    " useful cheats
    inoremap <C-A> <ESC>I
    inoremap <C-Q> <ESC>A
    inoremap <C-E> <ESC>lwi
    inoremap <C-S> <ESC>lbi
    inoremap <C-D> <ESC>o
    inoremap <C-F> <ESC>O

    " insert pair bracket
    inoremap <silent> { <C-R>=SmartPairBracketInsertion("{", "}")<CR>
    inoremap <silent> [ <C-R>=SmartPairBracketInsertion("[", "]")<CR>
    inoremap <silent> ( <C-R>=SmartPairBracketInsertion("(", ")")<CR>

    " insert pair quote
    inoremap <silent> " <C-R>=SmartPairQuoteInsertion('"')<CR>
    inoremap <silent> ' <C-R>=SmartPairQuoteInsertion("'")<CR>

    inoremap <silent> <C-Z> <ESC>:set nows<CR>:let _ls=@/<CR>/[)}\]>'"`]<CR>
        \:noh<CR>:cal histdel("/",-1)<CR>:let @/=_ls<CR>:unl _ls<CR>:set ws<CR>a

    inoremap <silent> <ENTER> <C-R>=SmartEnter()<CR>
    inoremap <silent> <BS> <C-R>=SmartBackspace()<CR>

    " let Y behave like other capitals
    nnoremap Y y$

    " select the current line without indentation
    nnoremap vv ^vg_

    " paste and indent
    nnoremap <leader>p p`[v`]=
    nnoremap <leader>P P`[v`]=

    " paste the last yanked text
    nnoremap <C-P> "0p
    vnoremap <C-P> "0p

    " don't lose selection after indenting
    vnoremap < <gv
    vnoremap > >gv

    " command line
    " -------------------------------------------------------------------------

    " delete last path component in the command line
    cnoremap <C-T> <C-\>e(RemoveLastPathComponent())<CR>

    " search
    " -------------------------------------------------------------------------

    " don't move on * and #
    nnoremap * *<C-O>
    nnoremap # #<C-O>

    " keep search matches in the middle of the window
    nnoremap n nzvzz
    nnoremap N Nzvzz

    " clear searches
    nnoremap <silent> <leader><SPACE> :noh<CR>

    " moving around
    " -------------------------------------------------------------------------

    nnoremap <TAB> }
    xnoremap <TAB> }
    nnoremap \ {
    xnoremap \ {

    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk

    nmap J 5j
    nmap K 5k
    xmap J 5j
    xmap K 5k

    " misc
    " -------------------------------------------------------------------------

    nnoremap q: :q
    nnoremap ; :

    nnoremap gp vipgq

    " open the finder (or terminal) at the location of the current file
    nnoremap <silent> <leader>ef :exec "sil !open ".expand("%:p:h")<CR>
    nnoremap <silent> <leader>er :TubeCd<CR>:TubeFocus<CR>

    " edit .vimrc
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

    " options
    nnoremap <silent> <leader>on :set number!<CR>
    nnoremap <silent> <leader>or :set relativenumber!<CR>
    nnoremap <silent> <leader>ow :set wrap!<CR>
    nnoremap <silent> <leader>ol :set list!<CR>
    nnoremap <silent> <leader>os :setl spell!<CR>

    " print file size info
    nnoremap <silent> <leader>i :call PrintFileSizeInfo()<CR>

    " quickfix window
    nnoremap <silent> <leader>xx :cwindow<CR>
    nnoremap <silent> <leader>xp :clist<CR>
    nnoremap <silent> <leader>xc :cclose<CR>
    nnoremap <silent> <leader>xz :call setqflist([])<CR>

    " go to the next/previous error in the quickfix list
    nnoremap <silent> ]e :cnext<CR>
    nnoremap <silent> [e :cprevious<CR>

    " typos
    iabbrev lenght length
    iabbrev wiht with
    iabbrev retrun return

    inoremap <C-B> `
    cnoremap <C-B> `
    inoremap <C-T> ~
    cnoremap <C-T> ~

" }}}

" PLUGINS ---------------------------------- {{{

    " Netrw
    " -------------------------------------------------------------------------

    nnoremap <F1> :edit .<CR>
    nnoremap <leader>ee :edit .<CR>
    nnoremap <leader>et :tabe .<CR>

    let g:netrw_banner = 0
    let g:netrw_bufsettings = "noma nomod nu nuw=2 nowrap ro nobl"
    let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+,\.pyc$,^tags$'

    augroup netrw
        au!

        au FileType netrw map <buffer> o <CR>
        au FileType netrw map <buffer> \ -

        exec "au FileType netrw map <buffer> " . 0 . " :" . 10 . "<CR>o"
        for n in range(1, 9)
            exec "au FileType netrw map <buffer> " . n . " :" . n . "<CR>o"
            exec "au FileType netrw map <buffer> <leader>" . n . " :" . (10+n) . "<CR>o"
        endfor

    augroup END

    " Tagbar
    " -------------------------------------------------------------------------

    nnoremap <silent> <F2> :TagbarToggle<CR>
    inoremap <silent> <F2> <ESC>:TagbarToggle<CR>a

    let g:tagbar_left = 0
    let g:tagbar_sort = 0
    let g:tagbar_width = 40
    let g:tagbar_iconchars = ['+ ', '* ']
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds' : [
            \ 'p:package:1','i:imports:1','c:constants','v:variables','t:types',
            \ 'n:interfaces', 'w:fields','e:embedded','m:methods','r:constructor',
            \ 'f:functions'],
        \ 'sro' : '.',
        \ 'kind2scope' : {'t' : 'ctype', 'n' : 'ntype'},
        \ 'scope2kind' : {'ctype' : 't', 'ntype' : 'n'},
        \ 'ctagsbin' : $HOME.'/opt/go/bin/gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

    " Gundo
    " -------------------------------------------------------------------------

    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " Gundo
    " -------------------------------------------------------------------------

    let g:wildfire_objects = {
        \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
        \ "html,xml" : ["it"],
    \ }

    " Gate
    " -------------------------------------------------------------------------

    nnoremap - :Gate<CR>
    nnoremap <leader>- :Gate<CR>#

    let g:gate_debug = 0
    let g:gate_match_file_extension = 0
    let g:gate_mod_flags = {"active": 1}
    let g:gate_matches = {"color_darkbg": "Function"}
    let g:gate_ignore = ["*/[Bb]uild/*", "*.log"]
    let g:gate_filters = {"&": ["*_test.*"]}

    " Surfer
    " -------------------------------------------------------------------------

    nnoremap <leader>. :Surf<CR>

    let g:surfer_debug = 0
    let g:surfer_exclude_tags = []
    let g:surfer_exclude_kinds = ["import", "namespace", "package"]
    let g:surfer_line_format = [" @ {file}", " ({line})", " {kind}"]
    let g:surfer_matches = {"color_darkbg": "Function"}

    " Taboo
    " -------------------------------------------------------------------------

    let g:taboo_tab_format = " #%N %f%m "
    let g:taboo_renamed_tab_format = " #%N [%f] "
    let g:taboo_modified_tab_flag = " *"

    " Tube
    " -------------------------------------------------------------------------

    let g:tube_terminal = 'iterm'

    " Syntastic
    " -------------------------------------------------------------------------

    hi link SyntasticErrorSign WarningMsg
    hi link SyntasticWarningSign ModeMsg
    hi link SyntasticError None
    hi link SyntasticWarning None

    let g:syntastic_stl_format = "[ln:%F (%t)]"
    let g:syntastic_error_symbol = 'xx'
    let g:syntastic_warning_symbol = 'vv'
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['c', 'cpp', 'javascript', 'python'],
        \ 'passive_filetypes': ['java']
    \ }

    " Easymotion
    " -------------------------------------------------------------------------

    hi link EasyMotionTarget WarningMsg
    hi link EasyMotionShade Comment

    " Ack
    " -------------------------------------------------------------------------

    command! -nargs=* Ackp
        \ exec "Ack ".(empty(<q-args>)?'<cword>':<q-args>)
        \ ." ".pyeval('_find_project_root()')
    nnoremap <expr> <leader>A ":Ackp "

    command! -nargs=* Ackb
        \ exec "Ack ".(empty(<q-args>)?'<cword>':<q-args>)
        \ ." ".join(pyeval('_buffers()'), ' ')
    nnoremap <expr> <leader>a ":Ackb "

    " Ultisnips
    " -------------------------------------------------------------------------

    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "CustomSnips"]
    let g:UltiSnipsExpandTrigger = "<C-C>"

    " GitGutter
    " -------------------------------------------------------------------------

    nnoremap <leader>og :GitGutterToggle<CR>

    " InstantMarkdown
    " -------------------------------------------------------------------------

    let g:instant_markdown_slow = 1
    let g:instant_markdown_autostart = 0

    " YouCompleteMe
    " -------------------------------------------------------------------------

    let g:ycm_filetype_blacklist = {'vim' : 1}

" }}}

" FUNCTIONS -------------------------------- {{{

python << END
import vim, os

def _eval(expr, fmt=None):
    """To evaluate the given expression."""
    val = vim.eval(expr)
    if fmt is bool:
        return False if val == u'0' else True
    elif fmt is int:
        return int(val)
    else:
        return val

def _find_project_root(path=None, markers=None):
    """To find the the root of the current project.

    `markers` is a list of file/directory names the can be found
    in a project root directory.
    """
    if path is None:
        path = _eval("getcwd()")
    if markers is None:
        markers = ['.git', '.svn', '.hg', '.bzr', '.travis.yml']

    if path == "/":
        return ""
    elif any(m in os.listdir(path) for m in markers):
        return path
    else:
        return _find_project_root(os.path.dirname(path), markers)

def _buflisted(expr):
    """To check if a buffer is listed. See :h buflisted()"""
    return _eval("buflisted({})".format(repr(expr)), fmt=bool)

def _buffers():
    """To return a list of all listed buffers."""
    buffers = filter(None, imap(lambda b: b.name, vim.buffers))
    return filter(lambda b: _buflisted(b), buffers)

END

    fu! _count(haystack, needle)
        if type(a:haystack) == 1
            return count(split(a:haystack, "\\zs"), a:needle)
        elseif type(a:haystack) == 3 || type(a:haystack) == 4
            return count(a:haystack, a:needle)
        endif
    endfu

    " Automatically insert a closing quote
    fu! SmartPairQuoteInsertion(quote)
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if &ft == "vim" && line[:col(".")-2] =~ "^\\s*$"
            return a:quote
        endif
        let odd_quotes = _count(line, a:quote) % 2 != 0
        if odd_quotes || context[0] =~? "\[a-z\]" || context[1] =~? "\[a-z\]"
            return a:quote
        endif
        return a:quote.a:quote."\<ESC>i"
    endfu

    " Automatically insert a closing brace
    fu! SmartPairBracketInsertion(obr, cbr)
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if context[1] =~? "\\S" || _count(line, a:obr) != _count(line, a:cbr)
            return a:obr
        endif
        return a:obr.a:cbr."\<ESC>i"
    endfu

    " if the cursor is inside enclosing braces, add a new line in between
    fu! SmartEnter()
        let context = getline(".")[col(".")-2] . getline(".")[col(".")-1]
        if context =~ "()\\|\[\]\\|{}"
            return "\<CR>\<ESC>O"
        endif
        return "\<CR>"
    endfu

    " if the cursor is inside enclosing braces, delete both
    fu! SmartBackspace()
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        let pattern = "()\\|\[\]\\|{}\\|''\\|\"\"\\|``\\|<>"
        if context =~ pattern
            return "\<ESC>la\<BS>\<BS>"
        elseif line[col(".")-3] . line[col(".")-2] =~ pattern
            return "\<ESC>i"
        endif
        return "\<BS>"
    endfu

    " to strip trailing whitespace
    fu! RemoveTrailingWhitespaces()
        let cursor = getpos(".")
        exec "keepj %s/\\s\\+$//e"
        call histdel("search", -1)
        call setpos('.', cursor)
    endfu

    " to restore the cursor position
    fu! RestoreCursorPosition()
        if line('`"') <= line('$')
            exec 'sil! normal! g`"zvzz'
        endif
    endfu

    " to open the hyperlink under cursor in the default browser
    fu! OpenHyperlink()
        let cursor = getpos(".")
        let motion = &ft == "markdown" ? "vi)" : "viW"
        exec "normal! " . motion . "\<ESC>"
        let [start, end] = [col("'<"), col("'>")]
        let word = strpart(getline("."), start-1, end-start+1)
        call setpos('.', cursor)
        if word =~# "^http://\\|^https://\\|^www\."
            let link = word =~# "^http" ? word : "http://" . word
            exec "silent !open " . link
        else
            exec "normal! \<ESC>viw"
        endif
    endfu

    " to delete the last path component in the command line
    fu! RemoveLastPathComponent()
        return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
    endfu

    " to display a better text for closed folds
    fu! CustomFoldText()
        let line = getline(v:foldstart)
        if (&foldmethod == 'marker')
            let line = substitute(line, split(&foldmarker, ',')[0], '', 1)
        endif
        let stripped_line = substitute(line, '^\s*', '', 1)
        let stripped_line = substitute(stripped_line, '{\s*$', '', 1)
        let n = len(line) - len(stripped_line)
        return '+' . repeat('-', n-2) . ' ' . stripped_line
    endfu

    " to display a variable-length file path according the width of the
    " current window
    fu! FilePath()
        let tail = expand('%:p:t')
        if empty(tail)
            return "[no name]"
        endif
        if !empty(&bt)
            return tail
        endif
        let head = substitute(expand('%:p:h'), $HOME, '~', '') . "/"
        let x = winwidth(winnr()) - 50
        let maxlen = float2nr(5 * sqrt(x < 0 ? 0 : x))
        if strlen(head) > maxlen
            let head = strpart(head, strlen(head) - maxlen)
            let head = strpart(head, match(head, '/') + 1)
        endif
        return head . tail
    endfu

    " to return the git branch for the current buffer
    fu! GitCurrentBranch(prefix)
        if winwidth(winnr()) > 70 && empty(&buftype) && exists("g:loaded_fugitive")
            let branch = fugitive#head()
            if !empty(branch)
                return "(" . a:prefix . branch . ")"
            endif
        endif
        return ""
    endfu

    " to return the alternate buffer for the current buffer
    fu! AlternateBuffer()
        let alt_buffer = expand('#:t')
        if winwidth(winnr()) > 50 && !empty(alt_buffer) && buflisted(expand("#:p"))
            return "[[ " . alt_buffer . " ]]\ ~\ "
        endif
        return ""
    endfu

    " to print info of the current file
    fu! PrintFileSizeInfo()
        let fpath = expand("%:p")
        let msg = ' "' . bufname("%") . '"'
        let msg .= " -- lines: " . line("$")
        if &ft =~? "text\\|markdown"
            let out = system("wc -w " . shellescape(fpath))
            if v:shell_error == 0
                let msg .= ", words: " . matchstr(out, "\\d\\+")
            endif
        endif
        let msg .= ", size: " . getfsize(fpath)/1024 . "Kb -- "
        echo msg
    endfu

    " to delete the buffer but leave the window intact
    fu! CloseBuffer(bang)
        if &modified && !a:bang
            echohl WarningMsg | echo " Write the buffer first" | echohl None
        else
            let currbufnr = bufnr("%")
            set bufhidden=delete
            let buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
            if buffers == 0
                echohl WarningMsg | echo " No more buffers to close" | echohl None
            elseif buffers == 1
                enew!
                set nobuflisted
            else
                bnext!
            endif
            let ei = &eventignore
            set eventignore=all
            tabdo windo if bufnr("%") == currbufnr | bnext! | endif
            let &eventignore=ei
        endif
    endfu

    " to close the current window
    fu! CloseWindow()
        if &modified && !&hidden && !&autowriteall
            echohl WarningMsg | echo " Write the buffer first" | echohl None
        else
            let windows = tabpagewinnr(tabpagenr(), "$")
            if windows == 1
                echohl WarningMsg | echom " Use :q" | echohl None
            else
                q
            endif
        endif
    endfu

    " to edit to the buffer n; if it is already visible, then move to
    " the window containing the buffer
    fu! GoToBuffer(n)
        let winnr = bufwinnr(a:n)
        if winnr >= 0
            exec winnr . "wincmd w"
        else
            if a:n == "#" || buflisted(a:n)
                exec "b " . a:n
            else
                echohl WarningMsg | echo " No such buffer" | echohl None
            endif
        endif
    endfu

" }}}

" vim: fdm=marker:
