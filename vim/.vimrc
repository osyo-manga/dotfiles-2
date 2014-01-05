
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

    set rtp+=$HOME/dropbox/dev/vim/chronos
    set rtp+=$HOME/dropbox/dev/vim/surfer
    set rtp+=$HOME/dropbox/dev/vim/gate
    set rtp+=$HOME/dropbox/dev/vim/plum
    set rtp+=$HOME/dropbox/dev/vim/taboo
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
    set encoding=utf8
    set fileformats="unix,dos,mac"
    set hidden
    set tags=
    set backspace=2
    set autochdir
    set autoread
    set modeline
    set cryptmethod=blowfish
    set shell=bash\ -i

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

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_stuff
        au!

        au VimResized * wincmd = | redraw
        au BufReadPost * call RestoreCursorPosition()
        au BufWritePre * sil! call StripWhitespaces()
        au BufReadPost * if &key != "" | setl noswf nowb viminfo= nobk nostmp history=0 secure | endif

        au BufWritePost .vimrc source $MYVIMRC
        au BufWritePost plum.vim nested colorscheme plum

        au BufRead,BufNewFile *.pde  setf java
        au BufRead,BufNewFile *.json  setf javascript

        au FileType text,markdown,rest  nnoremap <silent> <buffer> <2-LeftMouse> :call OpenHyperlink()<CR>
        au FileType text,markdown,rest setl nonumber foldcolumn=2

        au FileType gitconfig  setl noet
        au FileType vim  setl fdm=marker
        au FileType html,css  setl sts=2 ts=2 sw=2

        au BufWinEnter *.py let g:_match_id = matchadd("SpellRare", "\\%81v.", -1)
        au BufWinLeave *.py sil! call matchdelete(g:_match_id)
        au FileType python  setl cin tw=79 fdm=indent fdn=2 fdl=1
        au FileType python  nnoremap <buffer> <F6> :!python %<CR>
        au FileType python  inoremap <buffer> <F6> <ESC>:!python %<CR>a

        au FileType go  setl nolist ts=4 noet fdm=syntax fdn=1
        au Filetype go  setl makeprg=go\ build ofu=gocomplete#Complete
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
    "let g:plum_cursorline_style = 4
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

    set nonumber
    set nocursorline
    call matchadd("SpellRare", "\\%101v.", -1)

    set mouse=a
    set virtualedit=all

    set title
    set titlestring=%<%{GitCurrentBranch('')}\ %F
    set titlelen=100

    set complete-=i
    set completeopt=longest,menuone

    set wildmenu
    set wildmode=longest,full
    set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,tags
    set wildignore+=*.swp,*.cache,*.jar,*.bat,*.dat

    set cmdheight=1
    set report=0
    set shortmess=IaA
    set noshowmode
    set showcmd

    set sidescrolloff=3
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

    set foldenable
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

    set stl=
    set stl+=\ %(%w%r%h\ %)
    set stl+=\ %(%#StatusLineErr#%{&mod?'(+)':''}%*\ %)
    set stl+=%(%{GitCurrentBranch('')}\ %)
    set stl+=%{DynamicFilePath()}
    set stl+=%=
    set stl+=%{AlternateBuffer()}
    set stl+=%1l:%02v\ ~\ %P\ "

" }}}

" MAPPINGS --------------------------------- {{{

    " basic {{{
    " -------------------------------------------------------------------------

    let mapleader=","
    inoremap jj <ESC>

    " }}}

    " commands {{{
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
    cabbrev E e
    cabbrev W w
    cabbrev Q q
    cabbrev Wa wa
    cabbrev Wq wq
    cabbrev Set set
    cabbrev Mes mes
    cabbrev Me mes
    cabbrev me mes

    " }}}

    " tabs {{{
    " -------------------------------------------------------------------------

    " open/close tabs
    nnoremap <silent> <leader>tt :tabedit! <C-R>=expand("%:p")<CR><CR>
    nnoremap <silent> <leader>tc :tabclose<CR>
    nnoremap <silent> <leader>to :tabonly<CR>

    " go to next/previous tabs
    nnoremap <silent> <left> :tabprevious<CR>
    inoremap <silent> <left> <ESC>:tabprevious<CR>
    nnoremap <silent> <right> :tabnext<CR>
    inoremap <silent> <right> <ESC>:tabnext<CR>

    " tabs relocation
    nnoremap <silent> <down> :exec 'sil! tabmove ' . (tabpagenr()-2)<CR>
    inoremap <silent> <down> <ESC>:exec 'sil! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <up> :exec 'sil! tabmove ' . tabpagenr()<CR>
    inoremap <silent> <up> <ESC>:exec 'sil! tabmove ' . tabpagenr()<CR>

    " }}}

    " windows {{{
    " -------------------------------------------------------------------------

    " kill the window
    nnoremap <silent> Q :call CloseWindow()<CR>

    " windows navigation
    noremap <C-h> <C-W>h
    noremap <C-j> <C-W>j
    noremap <C-k> <C-W>k
    noremap <C-l> <C-W>l

    " split windows
    nnoremap <leader>w <C-W>v<C-W>l:b #<CR>
    nnoremap <leader>W <C-W>s<C-W>l:b #<CR>

    " }}}

    " buffers {{{
    " -------------------------------------------------------------------------

    nmap <silent> <leader>n :bnext<CR>
    nmap <silent> <leader>b :bprevious<CR>

    " kill only the buffer but keep the window
    nmap <silent> <leader>q :call KillBuffer(1)<CR>

    " go to the alternate buffer
    nnoremap <SPACE> <C-^>

    " }}}

    " editing {{{
    " -------------------------------------------------------------------------

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

    inoremap <silent> <C-Z> <ESC>/[)}\]>'"]<CR>:noh<CR>:call histdel("search",-1)<CR>:let @/=''<CR>a
    inoremap <silent> <ENTER> <C-R>=SmartEnter()<CR>
    inoremap <silent> <BS> <C-R>=SmartBackspace()<CR>

    " let Y behave like other capitals
    nnoremap Y y$

    " paste the last yanked text
    nnoremap <C-P> "0p
    vnoremap <C-P> "0p

    " paste and indent
    nnoremap <leader>p p`[v`]=

    " select the current line excluding starting whitespaces
    nnoremap vv ^vg_

    " reselect visual selection after indenting
    vnoremap < <gv
    vnoremap > >gv
    vnoremap = =gv

    " move the current line or selection
    nmap + :.move .+1<CR>==
    nmap - :.move .-2<CR>==
    vmap + :move '>+1<CR>gv=
    vmap - :move '<-2<CR>gv=

    " }}}

    " command line {{{
    " -------------------------------------------------------------------------

    " delete last path component in the command line
    cnoremap <C-T> <C-\>e(RemoveLastPathComponent())<CR>

    " delete last word in the command line
    cnoremap <C-S> <C-\>e(RemoveLastWord())<CR>

    " }}}

    " search {{{
    " -------------------------------------------------------------------------

    " don't move on * and #
    nnoremap * *<C-O>
    nnoremap # #<C-O>

    " keep search matches in the middle of the window
    nnoremap n nzvzz
    nnoremap N Nzvzz

    " }}}

    " moving around {{{
    " -------------------------------------------------------------------------

    nmap <TAB> }
    xmap <TAB> }
    nmap \ {
    xmap \ {

    nnoremap j gj
    nnoremap k gk
    xnoremap j j
    xnoremap k k

    nmap J 5j
    nmap K 5k
    xmap J 5j
    xmap K 5k

    " }}}

    " misc {{{
    " -------------------------------------------------------------------------

    nnoremap q: :q
    nnoremap ; :

    nnoremap gp vipgq

    " open explorer
    nnoremap <leader>ee :edit .<CR>j

    " open the finder (or terminal) at the location of the current file
    nnoremap <silent> <leader>ef :exec "sil !open ".expand("%:p:h")<CR>
    nnoremap <silent> <leader>et :TubeCd<CR>:TubeFocus<CR>

    " clear searches
    nnoremap <silent> <leader><space> :noh<CR>

    " edit .vimrc
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

    " delete trailing whitespaces
    nnoremap <silent> <F8> :call StripWhitespaces()<CR>
    inoremap <silent> <F8> <ESC>:call StripWhitespaces()<CR>a

    nnoremap <silent> <leader>on :set number!<CR>
    nnoremap <silent> <leader>ow :set wrap!<CR>
    nnoremap <silent> <leader>ol :set list!<CR>
    nnoremap <silent> <leader>oi :call PrintFileInfo()<CR>

    " typos
    iabbrev lenght length
    iabbrev wiht with
    iabbrev retrun return

    inoremap <leader>' `
    inoremap <leader>? ~

    " }}}

" }}}

" PLUGINS ---------------------------------- {{{

    " NERDTree {{{
    " -------------------------------------------------------------------------

    let NERDTreeMinimalUI = 1
    let NERDTreeWinSize = 30
    nnoremap <silent> <F1> :NERDTreeToggle<CR>
    inoremap <silent> <F1> <ESC>:NERDTreeToggle<CR>

    " }}}

    " Tagbar {{{
    " -------------------------------------------------------------------------

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
        \ 'ctagsbin' : $HOME.'/opt/go/bin/gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

    " }}}

    " Gundo {{{
    " -------------------------------------------------------------------------

    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " }}}

   " Chronos {{{
   " -------------------------------------------------------------------------

    nnoremap <leader>h :Chronos<CR>
    let g:chronos_current_line_indicator = " "
    let g:chronos_matches_color_darkbg = 'Function'
    let g:chronos_debug = 0

    " }}}

    " Gate {{{
    " -------------------------------------------------------------------------

    nnoremap <leader>- :Gate<CR>
    let g:gate_exclude_extension_from_matching = 1
    let g:gate_current_line_indicator = " "
    let g:gate_matches_color_darkbg = 'Function'
    let g:gate_ignore = ["*/[Bb]uild/*"]
    let g:gate_debug = 0

    " }}}

    " Surfer {{{
    " -------------------------------------------------------------------------

    let g:surfer_line_format = [" @ {file}", " ({line})"]
    let g:surfer_current_line_indicator = " "
    let g:surfer_matches_color_darkbg = 'Function'
    let g:surfer_exclude = ["*/[Dd]oc?/*", "*/[Tt]est?/*", "*/[Bb]uild/*", "*/setup.py"]
    let g:surfer_exclude_kinds = ["field", "package", "import", "namespace"]
    let g:surfer_custom_languages = {
        \"go": {
            \"ctags_prg": $HOME."/opt/go/bin/gotags",
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

    " }}}

    " Taboo {{{
    " -------------------------------------------------------------------------

    let g:taboo_tab_format = " #%N %f%m "
    let g:taboo_modified_tab_flag = " +"

    " }}}

    " Tube {{{
    " -------------------------------------------------------------------------

    let g:tube_terminal = 'iterm'

    " }}}

    " Syntastic {{{
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

    " }}}

    " Easymotion {{{
    " -------------------------------------------------------------------------

    hi link EasyMotionTarget WarningMsg
    hi link EasyMotionShade Comment

    " }}}

    " Ack {{{
    " -------------------------------------------------------------------------

    command! -bang -nargs=* Ackp
        \ exec "Ack".<q-bang>." ".(empty(<q-args>)?'<cword>':<q-args>)
        \ ." ".pyeval('_find_project_root()')
    nnoremap <expr> <leader>a ":Ackp "

    " }}}

    " Ultisnips {{{
    " -------------------------------------------------------------------------

    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "CustomSnips"]
    let g:UltiSnipsExpandTrigger = "<C-C>"

    " }}}

    " Git Gutter {{{
    " -------------------------------------------------------------------------

    let g:gitgutter_enabled = 1
    nnoremap <leader>g :GitGutterToggle<CR>

    " }}}

    " Instant Markdown {{{
    " -------------------------------------------------------------------------

    let g:instant_markdown_slow = 1
    let g:instant_markdown_autostart = 0

    " }}}

    " YouCompleteMe {{{
    " -------------------------------------------------------------------------

    let g:ycm_filetype_blacklist = {'vim' : 1}

    " }}}

" }}}

" FUNCTIONS -------------------------------- {{{

python << END
import vim, os

def _find_project_root(path=None, markers=None): # {{{
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

    # }}}

END

    fu! _count(haystack, needle) " {{{
        if type(a:haystack) == 1
            return count(split(a:haystack, "\\zs"), a:needle)
        elseif type(a:haystack) == 3 || type(a:haystack) == 4
            return count(a:haystack, a:needle)
        endif
    endfu " }}}

    " Automatically insert a closint quote
    fu! SmartPairQuoteInsertion(quote) " {{{
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if &ft == "vim" && line[:col(".")-2] =~ "^\\s*$"
            return a:quote
        endif
        let odd_brackets = _count(line, a:quote) % 2 != 0
        if odd_brackets || context[0] =~? "\[a-z\]" || context[1] =~? "\[a-z\]"
            return a:quote
        endif
        return a:quote.a:quote."\<ESC>i"
    endfu " }}}

    " Utomatically insert a closing bracket
    fu! SmartPairBracketInsertion(obr, cbr) " {{{
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        let special_cond = a:obr == "(" && context[1] =~? "[a-z]"
        if !special_cond && _count(getline("."), a:obr) == _count(getline("."), a:cbr)
            return a:obr.a:cbr."\<ESC>i"
        endif
        return a:obr
    endfu " }}}

    " if the cursor is inside an opening and closing brackets,
    " add a new line in between
    fu! SmartEnter() " {{{
        let context = getline(".")[col(".")-2] . getline(".")[col(".")-1]
        if context =~ "()\\|\[\]\\|{}"
            return "\<CR>\<ESC>O"
        endif
        return "\<CR>"
    endfu " }}}

    " if the cursor is inside an opening and closing brackets, delete both
    fu! SmartBackspace() " {{{
        let line = getline(".")
        let context = line[col(".")-2] . line[col(".")-1]
        if context =~ "()\\|\[\]\\|{}\\|''\\|\"\"" && _count(line, context[0]) == _count(line, context[1])
            return "\<ESC>la\<BS>\<BS>"
        endif
        return "\<BS>"
    endfu " }}}

    " to strip trailing whitespace
    fu! StripWhitespaces() " {{{
        let cursor = getpos(".")
        exec "keepj %s/\\s\\+$//e"
        call histdel("search", -1)
        call setpos('.', cursor)
    endfu " }}}

    " to restore the cursor position
    fu! RestoreCursorPosition() " {{{
        if line('`"') <= line('$')
            exec 'sil! normal! g`"zvzz'
        endif
    endfu " }}}

    " to open the hyperlink under cursor in the default browser
    fu! OpenHyperlink() " {{{
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
    endfu " }}}

    " to delete the last path component in the command line
    fu! RemoveLastPathComponent() " {{{
        return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
    endfu " }}}

    " to delete the last word in the command line
    fu! RemoveLastWord() " {{{
        return substitute(getcmdline(), '\S\+$', '', '')
    endfu " }}}

    " to display a better text for closed folds
    fu! CustomFoldText() " {{{
        let line = getline(v:foldstart)
        if (&foldmethod == 'marker')
            let line = substitute(line, split(&foldmarker, ',')[0], '', 1)
        endif
        let stripped_line = substitute(line, '^\s*', '', 1)
        let stripped_line = substitute(stripped_line, '{\s*$', '', 1)
        let n = len(line) - len(stripped_line)
        return '+' . repeat('-', n-2) . ' ' . stripped_line
    endfu " }}}

    " to display a variable-length file path according the witdh of the
    " current window
    fu! DynamicFilePath() " {{{
        if &bt == 'help' || &bt == 'nofile'
            return expand('%:t')
        endif

        let fname = expand('%:t')
        let fpath = substitute(expand('%:p:h'), $HOME, '~', '')
        let x = winwidth(winnr()) - 60
        let available_chars = float2nr(5 * sqrt(x < 0 ? 0 : x))

        if strlen(fpath) > available_chars
            let fpath = strpart(fpath, strlen(fpath) - available_chars)
            " round the path to the nearest slash
            let cut_pos = match(fpath, '/')
            if cut_pos >= 0
                let fpath = strpart(fpath, cut_pos + 1)
            endif
        endif

        let cond = empty(fname)
        return (cond ? "" : fpath ."/") . (cond ? "[no name]" : fname)
    endfu " }}}

    " to return the git branch for the current buffer
    fu! GitCurrentBranch(prefix) " {{{
        if winwidth(winnr()) < 70
            return ""
        endif
        if empty(&buftype) && exists("g:loaded_fugitive")
            let branch = fugitive#head()
            if !empty(branch)
                return "(" . a:prefix . branch . ")"
            endif
        endif
        return ""
    endfu " }}}

    " to return the alternate buffer for the current buffer
    fu! AlternateBuffer() " {{{
        if winwidth(winnr()) < 50
            return ""
        endif
        let alt_buffer = expand('#:t')
        if !empty(alt_buffer) && buflisted(expand("#:p"))
            return "" . alt_buffer . "!\ ~\ "
        endif
        return ""
    endfu " }}}

    " to print info of the current file
    fu! PrintFileInfo() " {{{
        let msg = " [["
        let msg .= " ft:" . &ft
        let msg .= ", fenc:" . &fenc
        let msg .= ", ff:" . &ff
        let msg .= ", lines:" . line("$")
        let msg .= ", size:" . getfsize(expand("%:p"))/1024 . "Kb"
        let msg .= " ]]"
        echo msg
    endfu " }}}

    " to delete the buffer but leave the window intact
    " http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
    fu! KillBuffer(kwbdStage) " {{{
        if(a:kwbdStage == 1)
            if(!buflisted(winbufnr(0)))
                bd!
                return
            endif
            let s:kwbdBufNum = bufnr("%")
            let s:kwbdWinNum = winnr()
            windo call KillBuffer(2)
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
    endfu " }}}

    " to close the current window
    fu! CloseWindow() " {{{
        if &modified && (!&hidden || !&autowriteall)
            echohl WarningMsg | echom " Write the buffer first" | echohl None
        else
            let windows = tabpagewinnr(tabpagenr(), "$")
            if windows == 1
                echohl WarningMsg | echom " Use :q" | echohl None
            else
                exec "q"
            endif
        endif
    endfu " }}}

" }}}

" vim: fdm=marker:
