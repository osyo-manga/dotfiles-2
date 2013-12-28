
" .vimrc

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    " For some reasons prevents YCM server to crash when MacVim.app is
    " opened outside the terminal.
    let $PATH = $HOME.'/opt/bin:/usr/local/bin:'.$PATH
    let $GOPATH=$HOME.'/dropbox/dev/go:'.$GOPATH
    let $GOPATH=$HOME.'/opt/go:'.$GOPATH

    set rtp+=$HOME/dropbox/dev/vim/surfer
    set rtp+=$HOME/dropbox/dev/vim/plum
    set rtp+=$HOME/dropbox/dev/vim/taboo
    set rtp+=$HOME/dropbox/dev/vim/ozzy
    set rtp+=$HOME/dropbox/dev/vim/breeze
    set rtp+=$HOME/dropbox/dev/vim/tube
    set rtp+=/usr/local/opt/go/libexec/misc/vim

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'goldfeld/vim-seek'
    Bundle 'tpope/vim-surround'
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
    Bundle 'ap/vim-css-color'
    Bundle 'tpope/vim-haml'
    Bundle 'tpope/vim-markdown'
    Bundle 'suan/vim-instant-markdown'

    filetype plugin indent on
    syntax on

    " personal stuff
    if filereadable(expand("~/dropbox/personal/.vimrc"))
        source ~/dropbox/personal/.vimrc
    endif

" }}}

" OPTIONS ---------------------------------- {{{

    set sessionoptions+=tabpages,globals
    set encoding=utf-8
    set termencoding=utf-8
    set fileformats="unix,dos,mac"
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

    set viminfo=!,'100,:50,h,n~/.viminfo
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
        au FocusGained,FocusLost,CursorHold,CursorHoldI * call PlumSetBackground()
        au BufReadPost * if &key != "" | setl noswf nowb viminfo= nobk nostmp history=0 secure | endif

        au BufWritePost .vimrc source $MYVIMRC
        au BufWritePost plum.vim colorscheme plum

        au WinEnter * set cursorline
        au WinLeave * set nocursorline

        au BufRead,BufNewFile *.pde  setf java
        au BufRead,BufNewFile *.json  setf javascript

        au FileType text,markdown  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>

        au FileType gitconfig  setl noet
        au FileType vim  setl fdm=marker
        au FileType html,css  setl sts=2 ts=2 sw=2

        au BufRead,BufNewFile *.py  normal! zR
        au FileType python  setl cin tw=79 fdm=indent fdn=2 fdl=1
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
    let python_version_2 = 1

    "let g:plum_force_bg = "dark"
    let g:plum_cursorline_style = 3
    colorscheme plum

    if has("gui_running")

        set guioptions=mc  " remove 'e' for terminal-style tabs
        set linespace=0

        if has("gui_macvim")
            set guifont=Source\ Code\ Pro\ Light:h13
            "set guifont=GohuFont:h14
        endif

    else

        augroup iterm_cursor_shape
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

    set ttyfast
    set t_Co=256
    set startofline
    set tabpagemax=19
    set lazyredraw

    set noerrorbells
    set novisualbell
    set t_vb=

    set formatoptions=qn1c
    set nrformats-=octal

    set notimeout
    set ttimeout
    set ttimeoutlen=50

    set number
    set cursorline
    "set colorcolumn=81
    call matchadd("SpellRare", "\\%101v.", -1)

    set mouse=a
    set virtualedit=all

    set title
    set titlestring=%<%{GitCurrentBranch('⎇\ ')}\ %F
    set titlelen=100

    set complete-=i
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

    set sidescrolloff=5
    set scrolloff=5

    set smarttab
    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
    set shiftround

    set autoindent
    set copyindent

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

    set wrapscan
    set ignorecase
    set smartcase
    set showmatch
    set incsearch
    set hlsearch
    set gdefault
    set magic

    set foldenable
    set foldcolumn=0
    set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
    set foldtext=CustomFoldText()

" }}}

" STATUSLINE ------------------------------- {{{

    set laststatus=2

    set stl=
    set stl+=\ %w%r%#StatusLineErr#%m%*%h
    set stl+=\ #%{bufnr('%')}
    set stl+=\ %(%{GitCurrentBranch('')}\ %)
    set stl+=%{DynamicFilePath()}
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ~\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ~\ ':''}
    set stl+=%1l:%02v\ ~\ %P
    set stl+=%#StatusLineErr#%(\ %{SyntasticStatuslineFlag()}%)%*\ "

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
    command! -bang SudoWrite exec "w !sudo tee % > /dev/null"

    " rename the current buffer
    command! -bar -nargs=1 -bang -complete=file Rename
        \ sav<bang> <args> |
        \ setl modified |
        \ call delete(expand('#:p')) |
        \ exec "silent bw " . expand('#:p')

    " tabs navigation and relocation
    nnoremap <left> gT
    inoremap <left> <ESC>gT
    nnoremap <right> gt
    inoremap <right> <ESC>gt
    nnoremap <silent> <down> :exec 'sil! tabmove ' . (tabpagenr()-2)<CR>
    inoremap <silent> <down> <ESC>:exec 'sil! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <up> :exec 'sil! tabmove ' . tabpagenr()<CR>
    inoremap <silent> <up> <ESC>:exec 'sil! tabmove ' . tabpagenr()<CR>

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
    nnoremap <silent> <leader>q :call Kwbd(1)<CR>

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
    nnoremap <TAB> }
    vnoremap <TAB> }
    nnoremap \ {
    vnoremap \ {

    " split windows
    nnoremap <leader>w <C-W>v<C-W>l
    nnoremap <leader>W <C-W>s<C-W>l

    " open/close tabs
    nnoremap <leader>te :tabedit! <C-R>=expand("%:p")<CR><CR>
    nnoremap <leader>tc :tabclose<CR>

    " toggle options
    nnoremap <leader>on :set number!<CR>
    nnoremap <leader>ow :set wrap!<CR>

    " select entire buffer
    nnoremap vg ggVG

    " don't move on * and #
    nnoremap * *<C-O>
    nnoremap # #<C-O>

    " keep search matches in the middle of the window
    nnoremap n nzvzz
    nnoremap N Nzvzz

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

    " NERDTree

    let NERDTreeMinimalUI = 1
    let NERDTreeWinSize = 30
    nnoremap <silent> <F1> :NERDTreeToggle<CR>
    inoremap <silent> <F1> <ESC>:NERDTreeToggle<CR>
    nnoremap - :edit .<CR>

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
        \ 'ctagsbin' : $HOME.'/bin/go/bin/gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

    " Gundo

    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " Ozzy

    let g:ozzy_ignore = ['tags', '.env', '.gitignore', '.vimrc']
    let g:ozzy_track_only = ['/Users/giacomo']
    let g:ozzy_project_mode_flag = '-> '
    let g:ozzy_global_mode_flag = '>> '
    let g:ozzy_matches_color_darkbg = 'Function'
    nnoremap <leader>- :Ozzy<CR>

    " Surfer

    let g:surfer_line_format = [" @ {file}", " ({line})", " class: {class}"]
    let g:surfer_visual_kinds_shape = "\u25cf"
    let g:surfer_exclude = ["*/[Dd]oc?/*", "*/[Tt]est?/*"]
    let g:surfer_exclude_kinds = ["field", "package", "import", "namespace"]
    let g:surfer_custom_languages = {
        \"go": {
            \"ctags_prg": $HOME."/bin/go/bin/gotags",
            \"ctags_args": "-silent -sort",
            \"kinds_map": {
                \ 'p': 'package', 'i': 'import', 'c': 'constant', 'v': 'variable',
                \ 't': 'type', 'n': 'interface', 'w': 'field','e': 'embedded',
                \ 'm': 'method', 'r': 'constructor', 'f': 'function'},
            \"exclude_kinds": ["package", "import", "variable", "field"],
            \"extensions": [".go"]
        \}
    \}
    let g:surfer_debug = 0
    nnoremap <leader>. :Surf<CR>

    " Taboo

    let g:taboo_tab_format = " %f%m "
    let g:taboo_modified_tab_flag = " *"

    " Tube

    let g:tube_terminal = 'iterm'

    " Syntastic

    hi link SyntasticErrorSign DiffDelete
    hi link SyntasticWarningSign DiffChange
    hi link SyntasticErrorLine DiffDelete
    hi link SyntasticWarningLine DiffChange
    hi link SyntasticError None
    hi link SyntasticWarning None

    nnoremap <silent> <leader>e :Errors<CR>
    let g:syntastic_stl_format = "[ln:%F (%t)]"
    let g:syntastic_error_symbol = '>>'
    let g:syntastic_warning_symbol = '>>'
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['c', 'cpp', 'javascript', 'python'],
        \ 'passive_filetypes': ['java']
    \ }

    " Easymotion

    hi link EasyMotionTarget WarningMsg
    hi link EasyMotionShade Comment

    " Ack

    command! -bang -nargs=* Ackp
        \ exec "Ack".<q-bang>." ".(empty(<q-args>)?'<cword>':<q-args>)
        \ ." ".pyeval('_find_project_root()')
    nnoremap <expr> <leader>a ":Ackp "

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
        markers = ['.git', '.svn', '.hg', '.bzr', '.travis.yml']

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
            let special_cond = &ft == "vim" && before =~ "^\\s*$"
        else
            let special_cond = before[strlen(before)-1] =~? "\[a-z\]"
        endif
        if (special_cond || _count(line, a:quote) % 2 != 0) && context !~ "()\\|\[\]\\|{}"
            return a:quote
        endif
        return a:quote.a:quote."\<ESC>i"
    endfu

    fu! SmartPairBracketInsertion(obr, cbr)
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        let special_cond = a:obr == "(" && context[1] =~? "[a-z]"
        if !special_cond && _count(getline("."), a:obr) == _count(getline("."), a:cbr)
            return a:obr.a:cbr."\<ESC>i"
        endif
        return a:obr
    endfu

    fu! SmartEnter()
        let context = getline(".")[col(".")-2] . getline(".")[col(".")-1]
        if context =~ "()\\|\[\]\\|{}"
            return "\<CR>\<ESC>O"
        endif
        return "\<CR>"
    endfu

    fu! SmartBackspace()
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if context =~ "()\\|\[\]\\|{}\\|''\\|\"\"" && _count(line, context[0]) == _count(line, context[1])
            return "\<ESC>la\<BS>\<BS>"
        endif
        return "\<BS>"
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
        exec "keepj %s/\\s\\+$//e"
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
        return '+' . repeat('-', n-2) . ' ' . stripped_line
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
            exec "normal! \<ESC>viw"
        endif
    endfu

    " To return the git branch for the current buffer
    fu! GitCurrentBranch(prefix)
        if empty(&buftype) && exists("g:loaded_fugitive")
            let branch = fugitive#head()
            if !empty(branch)
                return "(" . a:prefix . branch . ")"
            endif
        endif
        return ""
    endfu

    " http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
    " delete the buffer; keep windows; create a scratch buffer if no buffers left
    " TODO: prevent tabs to be closed when the last buffer is closed.
    fu! Kwbd(kwbdStage)

        if(a:kwbdStage == 1)

            if(!buflisted(winbufnr(0)))
                bd!
                return
            endif

            let s:kwbdBufNum = bufnr("%")
            let s:kwbdWinNum = winnr()

            windo call Kwbd(2)
            execute s:kwbdWinNum . 'wincmd w'

            let s:buflistedLeft = 0
            let s:bufFinalJump = 0
            let l:nBufs = bufnr("$")
            let l:i = 1

            while(l:i <= l:nBufs)
                if(l:i != s:kwbdBufNum)
                    if(buflisted(l:i))
                        let s:buflistedLeft = s:buflistedLeft + 1
                    else
                        if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
                            let s:bufFinalJump = l:i
                        endif
                    endif
                endif
                let l:i = l:i + 1
            endwhile

            if(!s:buflistedLeft)
                if(s:bufFinalJump)
                    windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
                else
                    enew
                    let l:newBuf = bufnr("%")
                    windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
                endif
                execute s:kwbdWinNum . 'wincmd w'
            endif

            if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
                execute "bd! " . s:kwbdBufNum
            endif

            if(!s:buflistedLeft)
                set buflisted
                set bufhidden=delete
                set buftype=
                setlocal noswapfile
            endif
        else
            if(bufnr("%") == s:kwbdBufNum)
                let prevbufvar = bufnr("#")
                if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
                    b #
                else
                    bn
                endif
            endif
        endif
    endfu

" }}}

" vim: fdm=marker: