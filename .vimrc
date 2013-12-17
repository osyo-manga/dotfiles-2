
" .vimrc

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

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

        au VimEnter * let $PATH = $HOME.'/bin:/usr/local/bin:'.$PATH
        au VimResized * wincmd = | redraw
        au BufWritePost .vimrc source $MYVIMRC
        au BufWinEnter * call RestoreCursorPosition()
        au BufWritePre * sil! call StripWhitespaces()
        au FileChangedShell * call HandleFileChangedShellEvent()
        au FocusLost,FocusGained,CursorHold,VimResized * call PlumSetBackground()
        au BufReadPost * if &key != "" | setl noswf nowb viminfo= nobk nostmp history=0 secure | endif

        au BufRead,BufNewFile *.pde  setf java
        au BufRead,BufNewFile *.clj  setf clojure
        au BufRead,BufNewFile *.json  setf javascript

        au Filetype text  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>
        au Filetype markdown  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>

        au Filetype gitconfig  setl noet
        au Filetype vim  setl fdm=marker
        au Filetype html  setl sts=2 ts=2 sw=2
        au Filetype css  setl sts=2 ts=2 sw=2

        au Filetype python  setl fdm=indent fdn=2 fdl=1
        au Filetype python  nnoremap <buffer> <F6> :!python %<CR>
        au Filetype python  inoremap <buffer> <F6> <ESC>:!python %<CR>a

        au Filetype go  setl nolist ts=4 noet fdm=syntax fdn=1 makeprg=go\ build ofu=gocomplete#Complete
        au FileType go  nnoremap <buffer> <F6> :!go run *.go<CR>
        au FileType go  inoremap <buffer> <F6> <ESC>:!go run *.go<CR>a
        au FileType go  nnoremap <buffer> <F7> :exe (&ft == 'go' ? 'Fmt' : '')<CR>:w<CR>
        au FileType go  inoremap <buffer> <F7> <ESC>:exe (&ft == 'go' ? 'Fmt' : '')<CR>:w<CR>a

    augroup END

" }}}

" UI --------------------------------------- {{{

    " syntax options
    let html_no_rendering = 1

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

    sil! aunmenu Help
    sil! aunmenu Window

    set noerrorbells vb t_vb=
    set t_Co=256
    set nostartofline
    set formatoptions=qn1c

    set number
    set cursorline
    "set colorcolumn=81
    call matchadd("SpellRare", "\\%81v.", -1)

    set ttyfast
    set notimeout
    set ttimeout
    set ttimeoutlen=0

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
    set stl+=%{CustomFilePath()}
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ~\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ~\ ':''}
    set stl+=%1l:%02v\ (%L)
    set stl+=%#StatusLineErr#%{empty(SyntasticStatuslineFlag())?'':'\ [errors]'}%*\ "

" }}}

" MAPPINGS --------------------------------- {{{

    let mapleader=","

    cabbrev E e
    cabbrev W w
    cabbrev Q q
    cabbrev Wa wa
    cabbrev WA wa
    cabbrev Wq wq
    cabbrev WQ wq
    cabbrev Mes mes

    nnoremap q: :q
    nnoremap ; :
    nnoremap ' `

    nmap j gj
    nmap k gk

    vnoremap < <gv
    vnoremap > >gv

    " sudo write
    command! -bang SudoWrite
        \ exec "w !sudo tee % > /dev/null"

    " rename the current buffer
    command! -bar -nargs=1 -bang -complete=file Rename
        \ sav<bang> <args> |
        \ setl modified |
        \ call delete(expand('#:p')) |
        \ exec "silent bw " . expand('#:p')

    " edit the .vimrc file
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

    " kill the window
    nnoremap <silent> Q :q<CR>

    " kill only the buffer but keep the window
    nnoremap <leader>q :Kwbd<CR>

    " let Y behave like other capitals
    nnoremap Y y$

    " use arrows for moving among tabs and buffers
    inoremap <up> <ESC>gt
    inoremap <down> <ESC>gT
    inoremap <left> <ESC>:bp<CR>
    inoremap <right> <ESC>:bn<CR>
    nnoremap <up> gt
    nnoremap <down> gT
    nnoremap <left> :bp<CR>
    nnoremap <right> :bn<CR>

    " osx gestures (MacVim only)
    nnoremap <SwipeDown> gT
    nnoremap <SwipeUp> gt
    nnoremap <SwipeLeft> :bN<CR>
    nnoremap <SwipeRight> :bn<CR>

    " clear searches
    nnoremap <silent> <leader><space> :noh<CR>

    " select the current line excluding starting whitespaces
    nnoremap vv ^v$

    " alternate buffer (last modified/viewed buffer)
    nnoremap <space> <c-^>

    " move across buffers
    nnoremap <silent> <leader>n :bn<CR>
    nnoremap <silent> <leader>m :bp<CR>

    " curly brackets are a nightmare on european keyboards
    nnoremap <silent> <tab> }
    vnoremap <silent> <tab> }
    nnoremap <silent> \ {
    vnoremap <silent> \ {

    " split windows
    nnoremap <leader>w <C-w>v<C-w>l
    nnoremap <leader>W <C-w>s<C-w>l

    " open/close tabs
    nnoremap <leader>t :tabedit! %<CR>

    " toggle options
    nnoremap <leader>i :set number!<CR>
    nnoremap <leader>o :set wrap!<CR>

    " paste and indent
    nnoremap <silent> <leader>p p`[v`]=

    " select entire buffer
    nnoremap vg ggVG

    " don't move on * and #
    nnoremap * *<C-O>
    nnoremap # #<C-O>

    " keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " useful cheats
    inoremap <C-A> <esc>I
    inoremap <C-Z> <esc>A
    inoremap <C-S> <esc>diwi
    inoremap <C-W> <esc>]}o
    inoremap <C-E> <esc>]}a

    " typos
    iabbr lenght length
    iabbr wiht with
    iabbr prinln println
    iabbr Flase False
    iabbr retrun return
    iabbr NOne None
    iabbr pytohn python

    " easy backquote and tilde
    inoremap <leader>' `
    inoremap <leader>? ~

    " delete last path component in the command line
    cnoremap <C-T> <C-\>e(<SID>RemoveLastPathComponent())<CR>

    " delete all trailing white-spaces
    nnoremap <F8> :call StripWhitespaces()<CR>
    inoremap <F8> <ESC>:call StripWhitespaces()<CR>a

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
        \ 'kinds' : ['p:package:1','i:imports:1','c:constants','v:variables','t:types','n:interfaces',
                    \ 'w:fields','e:embedded','m:methods','r:constructor','f:functions'],
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
            \"kinds_map": {'p': 'package', 'i': 'import', 'c': 'constant', 'v': 'variable', 't': 'type', 'n': 'interface',
                \'w': 'field', 'e': 'embedded', 'm': 'method', 'r': 'constructor', 'f': 'function'},
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

    nnoremap <leader>s :Ack

    " Ultisnips

    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "CustomSnips"]
    let g:UltiSnipsExpandTrigger = "<C-J>"

    " Vim Instant Markdown

    let g:instant_markdown_slow = 1

    " YouCompleteMe

    let g:ycm_filetype_blacklist = {'vim':1}

" }}}

" FUNCTIONS -------------------------------- {{{

    " to handle the FileChangedShell event
    fu! HandleFileChangedShellEvent()
        let l:msg = "File changed shell "
        if v:fcs_reason =~# "changed\\|conflict\\|deleted"
            let l:msg .= "[".v:fcs_reason ."]."
            let v:fcs_choice = "reload"
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
    fu! CustomFilePath()
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
        let stripped_line = substitute(line, '^ *', '', 1)
        let stripped_line = substitute(stripped_line, '{\s*$', '', 1)
        let n = len(line) - len(stripped_line)
        return '+' . repeat('-', n-1) . ' ' . stripped_line
    endfu

    " to delete the last path component in the command line (found on vim wikia)
    fu! s:RemoveLastPathComponent()
        return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
    endfu

    " to restore the cursor position
    fu! RestoreCursorPosition()
        if line("'\"") > 0 && line("'\"") <= line("$")
            exec "normal `\""
        endif
    endfu

    " to open the hyperlink under cursor in the default browser
    fu! OpenHyperlink()
        let cursor = getpos(".")
        let motion = &ft == "markdown" ? "vi)" : "viW"
        exec "normal " . motion . "\<ESC>" | exec "normal " . motion . "\<ESC>"
        let start = col("'<")
        let end = col("'>")
        let word = strpart(getline("."), start-1, end-start+1)
        if word =~# "^http://\\|^https://\\|^www\."
            let link = word =~# "^http" ? word : "http://" . word
            exec "silent !open " . link
            call setpos('.', cursor)
        else
            exec "normal viw"
        endif
    endfu

" }}}

" vim: fdm=marker:
