
" .vimrc

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    " This prevents YCM server to crash when MacVim.app is opened outside
    " the terminal.
    let $PATH = $HOME.'/bin:/usr/local/bin:'.$PATH

    set rtp+=$HOME/dropbox/dev/vim-tag-surfer
    set rtp+=$HOME/dropbox/dev/vim-plum
    set rtp+=$HOME/dropbox/dev/vim-taboo
    set rtp+=$HOME/dropbox/dev/vim-ozzy
    set rtp+=$HOME/dropbox/dev/vim-breeze
    set rtp+=$HOME/dropbox/dev/vim-tube
    set rtp+=$HOME/dropbox/dev/vim-go-syntax
    set rtp+=/usr/local/opt/go/libexec/misc/vim

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'majutsushi/tagbar'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'SirVer/ultisnips'
    Bundle 'mattn/emmet-vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/gundo.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle "Valloric/YouCompleteMe"
    Bundle 'nsf/gocode'
    Bundle 'tpope/vim-markdown'
    Bundle 'tpope/vim-haml'
    Bundle 'sjl/vitality.vim'
    Bundle 'suan/vim-instant-markdown'

    filetype plugin indent on
    syntax on

    " personal stuff
    source $HOME/dropbox/personal/.vimrc

" }}}

" OPTIONS ---------------------------------- {{{

    set sessionoptions+=tabpages,globals
    set encoding=utf-8
    set noautowrite
    set hidden
    set tags=
    set backspace=2
    set iskeyword=_,$,@,a-z,A-Z,48-57
    set autochdir
    set autoread
    set modeline
    set cryptmethod=blowfish
    set shell=bash\ -i

    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set history=10000
    set undolevels=10000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=1000

    set noswapfile
    set nobackup

    if $TMUX == ''
        set clipboard+=unnamed
    endif

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_stuff
        au!

        au VimResized * wincmd = | redraw
        au BufReadPost * call RestoreCursorPosition()
        au BufWritePre * sil! call StripWhitespaces()
        au FileChangedShell * call HandleFileChangedShellEvent()
        au FocusLost,FocusGained,CursorHold,VimResized * call PlumSetBackground()
        au BufReadPost * if &key != "" | setl noswf nowb viminfo= nobk nostmp history=0 secure | endif

        au BufWritePost .vimrc source $MYVIMRC
        au BufWritePost plum.vim colorscheme plum

        au WinEnter * set cursorline
        au WinLeave * set nocursorline

        au BufRead,BufNewFile *.pde  setf java
        au BufRead,BufNewFile *.clj  setf clojure
        au BufRead,BufNewFile *.json  setf javascript

        au FileType text  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>
        au FileType markdown  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>

        au FileType gitconfig  setl noet
        au FileType vim  setl fdm=marker
        au FileType html  setl sts=2 ts=2 sw=2
        au FileType css  setl sts=2 ts=2 sw=2

        au FileType python  setl fdm=indent fdn=2 fdl=1
        au FileType python  nnoremap <buffer> <F6> :!python %<CR>
        au FileType python  inoremap <buffer> <F6> <ESC>:!python %<CR>a

        au FileType go  setl nolist ts=4 noet fdm=syntax fdn=1 makeprg=go\ build ofu=gocomplete#Complete
        au FileType go  nnoremap <buffer> <F6> :!go run *.go<CR>
        au FileType go  inoremap <buffer> <F6> <ESC>:!go run *.go<CR>a
        au FileType go  nnoremap <buffer> <F7> :exe (&ft == 'go' ? 'Fmt' : '')<CR>:w<CR>
        au FileType go  inoremap <buffer> <F7> <ESC>:exe (&ft == 'go' ? 'Fmt' : '')<CR>:w<CR>a

    augroup END

" }}}

" UI --------------------------------------- {{{

    " syntax options
    let html_no_rendering = 1
    let python_highlight_builtin_objs = 1

    " colorscheme options
    "let g:plum_force_bg = "dark"
    let g:plum_cursorline_highlight_only_linenr = 1

    colorscheme plum

    if has("gui_running")

        set guioptions=mc  " remove 'e' for terminal-style tabs
        set linespace=0

        if has("gui_macvim")
            "set guifont=Source\ Code\ Pro:h13
            "set guifont=Anonymous\ Pro:h14
            set guifont=GohuFont:h14
        endif

    endif

    set ttyfast
    set noerrorbells vb t_vb=
    set t_Co=256
    set nostartofline
    set formatoptions=qn1c

    set notimeout
    set ttimeout
    set ttimeoutlen=0

    set number
    set cursorline
    "set colorcolumn=81
    call matchadd("SpellRare", "\\%81v.", -1)

    set mouse=a
    set virtualedit=insert

    set title
    set titlestring=%<%((⎇\ %{fugitive#head()})%)\ %F
    set titlelen=100

    set completeopt=longest,menuone
    set wildmenu
    set wildmode=longest,full
    set wildignore=*.dll,*.o,*.so,*.pyc,*$py.class,*.class,*.fasl,__pycache__
    set wildignore+=*.jpg,*.jpeg,*.png,*.gif,.DS_Store,.gitignore,.git,tags
    set wildignore+=*.swp,*.dex,*.apk,*.d,*.cache,*.ap_,.env

    set cmdheight=1
    set report=0
    set shortmess=IaA
    set noshowmode

    set sidescrolloff=1
    set scrolloff=0

    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
    set shiftround

    set autoindent
    set smartindent

    set splitbelow
    set splitright

    set nowrap
    set whichwrap+=<,>,h,l,[,]

    set nolist
    set fillchars=vert:\|
    set listchars=tab:\|\ ,trail:·,precedes:…,extends:…

    set nowrap
    set textwidth=79
    set showbreak=..
    set linebreak

    set wrapscan
    set ignorecase
    set smartcase
    set showmatch
    set incsearch
    set hlsearch
    set gdefault
    set magic

    set foldtext=CustomFoldText()

" }}}

" STATUSLINE ------------------------------- {{{

    set laststatus=2

    set stl=
    set stl+=\ %w%r%#StatusLineErr#%m%*%h
    set stl+=\ #%{bufnr('%')}
    set stl+=\ %((%{fugitive#head()})\ %)
    set stl+=%{DynamicFilePath()}
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ~\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ~\ ':''}
    set stl+=%1l:%02v\ (%L)
    set stl+=%#StatusLineErr#%{empty(SyntasticStatuslineFlag())?'':'\ [errors]'}%*\ "

" }}}

" MAPPINGS --------------------------------- {{{

    let mapleader=","

    noremap j gj
    noremap k gk
    noremap gj j
    noremap gk k

    vnoremap < <gv
    vnoremap > >gv

    " sudo write
    command! -bang SudoWrite
        \ exec "w !/usr/bin/sudo tee % > /dev/null" |
        \ edit!

    " rename the current buffer
    command! -bar -nargs=1 -bang -complete=file Rename
        \ sav<bang> <args> |
        \ setl modified |
        \ call delete(expand('#:p')) |
        \ exec "silent bw " . expand('#:p')

    " use arrows for moving among tabs and buffers
    nnoremap <down> gT
    inoremap <down> <ESC>gT
    nnoremap <up> gt
    inoremap <up> <ESC>gt
    nnoremap <left> :bp<CR>
    inoremap <left> <ESC>:bp<CR>
    nnoremap <right> :bn<CR>
    inoremap <right> <ESC>:bn<CR>

    " osx gestures (MacVim only)
    nnoremap <SwipeDown> gT
    inoremap <SwipeDown> <ESC>gT
    nnoremap <SwipeUp> gt
    inoremap <SwipeUp> <ESC>gt
    nnoremap <SwipeLeft> :bp<CR>
    inoremap <SwipeLeft> <ESC>:bp<CR>
    nnoremap <SwipeRight> :bn<CR>
    inoremap <SwipeRight> <ESC>:bn<CR>

    " windows navigation
    noremap <C-h> <C-W>h
    noremap <C-j> <C-W>j
    noremap <C-k> <C-W>k
    noremap <C-l> <C-W>l

    " clear searches
    nnoremap <silent> <leader><space> :noh<CR>

    " edit the .vimrc file
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

    " kill the window
    nnoremap <silent> Q :q<CR>

    " kill only the buffer but keep the window
    nnoremap <leader>q :Kwbd<CR>

    " let Y behave like other capitals
    nnoremap Y y$

    " discard deletion
    nnoremap <leader>d "_dd
    vnoremap <leader>d "_d

    " paste the last yanked text
    nnoremap <C-P> "0p
    vnoremap <C-P> "0p

    " paste and indent
    nnoremap <leader>p p`[v`]=

    " select the current line excluding starting whitespaces
    nnoremap vv ^vg_

    " alternate buffer (last modified/viewed buffer)
    nnoremap <SPACE> <C-^>

    " move across buffers
    nnoremap <silent> <leader>n :bn<CR>
    nnoremap <silent> <leader>m :bp<CR>

    " curly brackets are a nightmare on european keyboards
    nnoremap <silent> <TAB> }
    vnoremap <silent> <TAB> }
    nnoremap <silent> \ {
    vnoremap <silent> \ {

    " split windows
    nnoremap <leader>w <C-W>v<C-W>l
    nnoremap <leader>W <C-W>s<C-W>l

    " open/close tabs
    nnoremap <leader>t :tabedit! %<CR>

    " toggle options
    nnoremap <leader>i :set number!<CR>
    nnoremap <leader>o :set wrap!<CR>

    " select entire buffer
    nnoremap vg ggVG

    " don't move on * and #
    nnoremap * *<C-O>
    nnoremap # #<C-O>

    " keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " useful cheats
    inoremap <C-A> <ESC>I
    inoremap <C-E> <ESC>A
    inoremap <C-S> <ESC>ciw
    inoremap <C-W> <ESC>lwi
    inoremap <C-B> <ESC>lbi
    inoremap <C-O> <ESC>O

    " insert pair bracket
    inoremap <silent> { <C-R>=SmartPairBracketInsertion("{", "}")<CR>
    inoremap <silent> [ <C-R>=SmartPairBracketInsertion("[", "]")<CR>
    inoremap <silent> ( <C-R>=SmartPairBracketInsertion("(", ")")<CR>
    inoremap <silent> < <C-R>=SmartPairBracketInsertion("<", ">")<CR>

    " insert pair quote
    inoremap <silent> " <C-R>=SmartPairQuoteInsertion('"')<CR>
    inoremap <silent> ' <C-R>=SmartPairQuoteInsertion("'")<CR>

    inoremap <silent> <C-Z> <ESC>/[)}\]>'"]<CR>:noh<CR>:call histdel("search",-1)<CR>a
    inoremap <silent> <ENTER> <C-R>=SmartEnter()<CR>
    inoremap <silent> <BS> <C-R>=SmartBackspace()<CR>

    " typos
    iabbrev lenght length
    iabbrev wiht with
    iabbrev retrun return
    cabbrev E e
    cabbrev W w
    cabbrev Q q
    cabbrev Wa wa
    cabbrev WA wa
    cabbrev Wq wq
    cabbrev WQ wq
    cabbrev Mes mes
    cabbrev Set set

    inoremap <leader>' `
    inoremap <leader>? ~

    nnoremap q: :q
    nnoremap ; :

    " delete last path component in the command line
    cnoremap <C-T> <C-\>e(RemoveLastPathComponent())<CR>

    " delete last word in the command line
    cnoremap <C-W> <C-\>e(RemoveLastWord())<CR>

    " inject the current project root in the command line
    cnoremap <C-R> <C-\>e(InjectCurrentProjectRoot())<CR>

    " delete all trailing white-spaces
    nnoremap <silent> <F8> :call StripWhitespaces()<CR>
    inoremap <silent> <F8> <ESC>:call StripWhitespaces()<CR>a

    " make
    nnoremap <F5> :make<CR>
    inoremap <F5> <ESC>:make<CR>a

" }}}

" PLUGINS ---------------------------------- {{{

    " Gundo

    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " NERDTree

    let NERDTreeShowBookmarks = 1
    nnoremap <silent> <F1> :NERDTreeToggle<CR>
    inoremap <silent> <F1> <ESC>:NERDTreeToggle<CR>a

    " Tagbar

    let g:tagbar_left = 0
    let g:tagbar_sort = 0
    let g:tagbar_width = 40
    let g:tagbar_iconchars = ['+ ', '* ']
    nnoremap <silent> <F2> :TagbarToggle<CR>
    inoremap <silent> <F2> <ESC>:TagbarToggle<CR>a
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds' : [
            \ 'p:package:1','i:imports:1','c:constants','v:variables','t:types',
            \ 'n:interfaces', 'w:fields','e:embedded','m:methods','r:constructor',
            \ 'f:functions'],
        \ 'sro' : '.',
        \ 'kind2scope' : {'t' : 'ctype', 'n' : 'ntype'},
        \ 'scope2kind' : {'ctype' : 't', 'ntype' : 'n'},
        \ 'ctagsbin' : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

    " Ozzy

    let g:ozzy_ignore = ['tags', '.env', '.gitignore', '.vimrc']
    let g:ozzy_track_only = ['/Users/giacomo']
    let g:ozzy_project_mode_flag = '-> '
    let g:ozzy_global_mode_flag = '>> '
    let g:ozzy_matches_color_darkbg = 'Function'
    nnoremap <leader>- :Ozzy<CR>

    " Tag Surfer

    let g:tsurf_custom_languages = {
        \"go": {
            \"bin": "/Users/giacomo/bin/go/bin/gotags",
            \"args": "-silent -sort",
            \"kinds_map": {
                \ 'p': 'package', 'i': 'import', 'c': 'constant', 'v': 'variable',
                \ 't': 'type', 'n': 'interface', 'w': 'field','e': 'embedded',
                \ 'm': 'method', 'r': 'constructor', 'f': 'function'},
            \"exclude_kinds": ["package", "import"],
            \"extensions": [".go"]
        \}
    \}
    let g:tsurf_debug = 0
    nnoremap <leader>. :Tsurf<CR>

    " Taboo

    let g:taboo_tab_format = "%m %f "
    let g:taboo_modified_tab_flag = " [*]"

    " Tube

    let g:tube_terminal = 'iterm'

    " IndentLine

    let g:indentLine_char = '|'
    let g:indentLine_fileType = ['html', 'xml', 'java', 'c', 'cpp']

    " Syntastic

    nnoremap <leader>e :Errors<CR>
    "nnoremap <leader>E :lcl<CR>
    let g:syntastic_error_symbol = '*'
    let g:syntastic_warning_symbol = '*'
    let g:syntastic_style_error_symbol = '*'
    let g:syntastic_style_warning_symbol = '*'
    highlight link SyntasticErrorSign WarningMsg
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['c', 'cpp', 'javascript', 'python'],
        \ 'passive_filetypes': ['java']
    \ }

    " Ack

    command! -bang -nargs=* Ackp exec "Ack".<q-bang>." ".<q-args>." ".pyeval('_find_project_root()')
    nnoremap <expr> <leader>a ":Ack "
    nnoremap <expr> <leader>A ":Ackp "

    " Ultisnips

    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "CustomSnips"]
    let g:UltiSnipsExpandTrigger = "<C-C>"

    " Vim Instant Markdown

    let g:instant_markdown_slow = 1
    let g:instant_markdown_autostart = 0

    " YouCompleteMe

    let g:ycm_filetype_blacklist = {'vim' : 1}

" }}}

" FUNCTIONS -------------------------------- {{{

python << END
import vim, os

def _find_project_root(path=None, markers=None):
    """To find the the root of the current project.

    `markers` is a list of file/directory names the can be found
    in a project root directory.
    """
    if path is None:
        path = vim.eval("getcwd()")
    if markers is None:
        markers = ['.git', '.svn', '.hg', '.bzr']

    if path == "/":
        return ""
    elif any(m in os.listdir(path) for m in markers):
        return path
    else:
        return _find_project_root(os.path.dirname(path), markers)

END

    fu! _count(haystack, needle)
        if type(a:haystack) == 1
            return count(split(a:haystack, "\\zs"), a:needle)
        elseif type(a:haystack) == 3 || type(a:haystack) == 4
            return count(a:haystack, a:needle)
        endif
    endfu

    fu! SmartPairQuoteInsertion(quote)
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        let [before, after] = [line[:col(".")-2], line[col(".")-1:]]
        if a:quote == '"'
            let special_cond = &ft == "vim" && before =~# "^\\s\\+$"
        else
            let special_cond = before[strlen(before)-1] =~# "\[a-zA-Z\]"
        endif
        if (special_cond || _count(line, a:quote) % 2 != 0) && context !~# "()\\|\[\]\\|{}"
            return a:quote
        endif
        return a:quote.a:quote."\<ESC>i"
    endfu

    fu! SmartPairBracketInsertion(obr, cbr)
        if _count(getline("."), a:obr) == _count(getline("."), a:cbr)
            return a:obr.a:cbr."\<ESC>i"
        endif
        return a:obr
    endfu

    fu! SmartEnter()
        let context = getline(".")[col(".")-2] . getline(".")[col(".")-1]
        if context =~# "()\\|\[\]\\|{}"
            return "\<CR>\<ESC>O"
        endif
        return "\<CR>"
    endfu

    fu! SmartBackspace()
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if context =~# "()\\|\[\]\\|{}\\|'\\|\"\"" && _count(line, context[0]) == _count(line, context[1])
            return "\<ESC>la\<BS>\<BS>"
        endif
        return "\<BS>"
    endfu

    " to handle the FileChangedShell event
    fu! HandleFileChangedShellEvent()
        let l:msg = "File changed shell "
        if v:fcs_reason =~# "changed\\|conflict\\|deleted"
            let l:msg .= "[".v:fcs_reason ."]."
            if v:fcs_reason == "deleted"
                let &mod = 1
            endif
        else
            let v:fcs_choice = "ask"
        endif
        echohl WarningMsg | echom l:msg | echohl None
    endfu

    " to display a variable-length file path according the witdh of the
    " current window
    fu! DynamicFilePath()
        if &bt == 'help' || &bt == 'nofile'
            return expand('%:t')
        endif

        let path = substitute(expand('%:p'), $HOME, '~', '')
        let x = winwidth(winnr()) - 50
        let available_chars = float2nr(6 * sqrt(x < 0 ? 0 : x))

        if strlen(path) > available_chars
            let path = strpart(path, strlen(path) - available_chars)
            " round the path to the nearest slash
            let cut_pos = match(path, '/')
            if cut_pos >= 0
                let path = strpart(path, cut_pos + 1)
            endif
        endif
        return path
    endfu

    " to strip trailing whitespace
    fu! StripWhitespaces()
        let cursor = getpos(".")
        exec "%s/\\s\\+$//e"
        call histdel("search", -1)
        call setpos('.', cursor)
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
        return '+' . repeat('-', n-1) . ' ' . stripped_line
    endfu

    " to delete the last path component in the command line
    fu! RemoveLastPathComponent()
        return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
    endfu

    " to delete the last word in the command line
    fu! RemoveLastWord()
        return substitute(getcmdline(), '\S\+$', '', '')
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
            exec "normal! viw"
        endif
    endfu

" }}}

" vim: fdm=marker:
