"  -----------------------------------------------------
"  vim configuration file
"  Maintainer: Giacomo Comitti - github.com/gcmt 
"  Last Change: 14 Jul 2013
"  -----------------------------------------------------

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    " location of third party go packages binaries
    let $PATH = $HOME . '/bin/go/bin:' . $PATH

    let $GOPATH = $HOME . '/dropbox/dev/go:' . $GOPATH
    let $GOPATH = $HOME . '/bin/go:' . $GOPATH

    set rtp+=/usr/local/go/misc/vim
    "set rtp+=$HOME/dropbox/dev/vim-ozzy

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-haml'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'sjl/vitality.vim'
    Bundle 'majutsushi/tagbar'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'SirVer/ultisnips'
    Bundle 'scrooloose/syntastic'
    Bundle 'gcmt/taboo.vim'
    Bundle 'gcmt/ozzy.vim'
    Bundle 'gcmt/breeze.vim'
    Bundle 'ap/vim-css-color'
    Bundle 'Yggdroot/indentLine'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/gundo.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'terryma/vim-expand-region'
    Bundle 'alfredodeza/chapa.vim'
    Bundle "Valloric/YouCompleteMe"
    Bundle 'kien/ctrlp.vim'
    Bundle 'nsf/gocode'
    Bundle 'tpope/vim-markdown'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'kien/rainbow_parentheses.vim'
    Bundle 'tpope/vim-fireplace'
    Bundle 'guns/vim-clojure-static'

    filetype plugin indent on
    syntax on

" }}}

" GENERAL OPTIONS -------------------------- {{{

    let g:markdown_highlight_underscore_error = 1
    set sessionoptions+=tabpages,globals
    set encoding=utf-8
    set noautowrite
    set nomodeline
    set hidden
    set tags=tags
    set backspace=2
    set iskeyword=_,$,@,%,#,-,a-z,A-Z,48-57
    "set shell=/usr/local/bin/zsh
    set autochdir
    set autoread

    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set history=1000
    set undolevels=1000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=10000
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
        au BufWinEnter * call RestoreCursorPosition()
        au BufWritePost .vimrc so $MYVIMRC

        au BufRead,BufNewFile *.pde        setl ft=java
        au BufRead,BufNewFile *.pl         setl ft=prolog
        au BufRead,BufNewFile *.clj        setl ft=clojure
        au Filetype python                 setl tw=79 fdm=indent fdn=2 "ofu=pythoncomplete#Complete
        au Filetype markdown               setl tw=100
        au Filetype html,xml               setl nowrap
        au Filetype html                   let html_no_rendering = 1
        au Filetype htmldjango,htmljinja   setl ft=html
        au Filetype vim                    setl fdm=marker
        au Filetype go                     setl list ts=4 noet fdm=syntax fdn=1
        au Filetype go                     au! BufWritePre <buffer> Fmt
        au Filetype python,cpp,java        au! BufWritePre <buffer> silent! normal S

        au CmdwinEnter * let g:_test = 1

    augroup END

" }}}

" UI --------------------------------------- {{{

    colorscheme plumtree
    set bg=light

    if has("gui_running")

        set guioptions=mc  " remove 'e' for terminal-style tabs
        set linespace=0

        if has("gui_macvim")
            "set guifont=Source\ Code\ Pro:h13
            set guifont=GohuFont:h14
        elseif has('gui_win32')
            set guifont=Consolas:h10:cANSI
        else
            set guifont=inconsolata-g\ Medium\ 10
        endif

    endif

    set noerrorbells vb t_vb=
    set t_Co=256
    set nostartofline
    set textwidth=79
    set formatoptions=qn1c
    set number

    set ttyfast
    set notimeout
    set ttimeout
    set ttimeoutlen=0

    set mouse=a
    set virtualedit=all

    set title
    set titlestring=%<%((br:\ %{fugitive#head()})%)\ %F
    set titlelen=100

    set completeopt=longest,menuone
    set wildmenu
    set wildmode=longest,full
    set wildignore=*.dll,*.o,*.pyc,*$py.class,*.class,*.fasl
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
    set cindent

    set splitbelow
    set splitright

    set nolist
    set fillchars=vert:\|
    set listchars=tab:\|\ ,trail:·,precedes:…,extends:…
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

" }}}

" STATUSLINE & TABLINE --------------------- {{{

    set laststatus=2

    set stl=
    set stl+=\ %w%r%#StlErr#%m%*%h
    set stl+=\ #%{bufnr('%')}\ %((br:%{fugitive#head()})\ %)%{NiceFilePath()}%#StlFname#%t%*
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ~\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ~\ ':''}
    set stl+=%1l:%02v\ ~\ %L:%P
    set stl+=\ %#StlErr#%{SyntasticStatuslineFlag()}%*\ "

" }}}

" MAPPINGS --------------------------------- {{{

    let mapleader=","

    command! -complete=file -nargs=* E exec 'e '.<q-args>
    command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
    command! -bang Q quit<bang>
    command! Wa wa | command! WA wa
    command! Wq wq | command! WQ wq
    command! On on | command! ON on
    command! Mes mes | command! M mes
    nnoremap q: :q
    nnoremap ; :
    nnoremap ' `
    imap jj <Esc>

    nmap j gj
    nmap k gk

    vnoremap < <gv
    vnoremap > >gv

    nnoremap 1 1gt<CR>
    nnoremap 2 2gt<CR>
    nnoremap 3 3gt<CR>
    nnoremap 4 4gt<CR>
    nnoremap 5 5gt<CR>
    nnoremap 6 6gt<CR>
    nnoremap 7 7gt<CR>
    nnoremap 8 8gt<CR>
    nnoremap 9 9gt<CR>

" sudo write
    cmap w!! w !sudo tee % > /dev/null

" rename current buffer
command! -bar -nargs=1 -bang -complete=file Rename
  \ sav<bang> <args> | 
  \ setl modified |
  \ call delete(expand('#:p')) | 
  \ exec "silent bw " . expand('#:p')

" fast up and down movements
    nnoremap J 3j
    nnoremap K 3k
    vnoremap J 3j
    vnoremap K 3k

" edit the vimrc file
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

" build tags for the current directory
    nnoremap <F4> :!/usr/local/bin/ctags -R .<CR>

" kill the window
    nnoremap <silent> Q :q<CR>

" kill the buffer but the window
    nnoremap <leader>q :Kwbd<CR>

" let Y behaves like other capitals
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

" toggle numbers
    nnoremap <leader># :set number!<CR>

" paste and indent
    nnoremap <silent> <leader>p p`[v`]=

" keep the cursor in place while joining lines
    nnoremap <leader>j mzJ`z

" delete all trailing white-spaces
    nnoremap S mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" select entire buffer
    nnoremap vg ggVG

" don't move on *
    nnoremap * *<C-O>

" keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

" shortcuts
    inoremap <C-A> <esc>A
    inoremap <C-E> <esc>I
    inoremap <C-S> <esc>diwi

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

" }}}

" PLUGINS ---------------------------------- {{{

" Gundo

    nnoremap <silent> <F3> :silent GundoToggle<CR>

" NERDTree

    let NERDTreeShowBookmarks = 1
    nnoremap <silent> <F1> :NERDTreeToggle<CR>

" Tagbar

    let g:tagbar_left = 0
    let g:tagbar_sort = 0
    let g:tagbar_width = 40
    let g:tagbar_iconchars = ['▸', '¬']
    nnoremap <silent> <F2> :TagbarToggle<CR>
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds' : ['p:package','i:imports:1','c:constants','v:variables','t:types','n:interfaces',
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
    let g:ozzy_shade_color_darkbg = 'Comment'
    let g:ozzy_matches_color_darkbg = 'Function'
    nnoremap <leader>- :Ozzy<CR>

" IndentLine

    let g:indentLine_color_term = 251
    let g:indentLine_char = '|'  "'￨'
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

" YouCompleteMe

    let g:ycm_filetype_blacklist = {'vim':1}

" Chapa

    let g:chapa_default_mappings = 1

" }}}

" FUNCTIONS -------------------------------- {{{

" cycle colorschemes
" -----------------------------------------------

    fu! CycleColorschemes()
        let g:colorcount += 1
        call SetColorscheme()
    endfu

    fu! SetColorscheme()
        let colorschemes = ['plumtree', 'candy']
        let scheme = colorschemes[g:colorcount % len(colorschemes)]
        let g:indentLine_color_gui = scheme == 'candy' ? '#cccccc' : '#292a48'
        exec 'colorscheme ' . scheme
    endfu

    let g:colorcount = get(g:, 'colorcount', 0)
    call SetColorscheme()

    nnoremap <silent> <F7> :call CycleColorschemes()<CR>


" show a decent path on the statusline
" -----------------------------------------------

    fu! NiceFilePath()
        if !strlen(expand('%')) || &bt == 'help' || &bt == 'nofile'
            return ''
        endif

        let path = substitute(expand('%:p:h'), $HOME, '~', '')
        let fname = expand('%:t')

        let x = winwidth(winnr()) - 55
        let x = x < 0 ? 0 : x
        let max_chars = float2nr(5 * sqrt(x))

        " be sure the file name is shown entirely
        if max_chars < strlen(fname)
            let max_chars = strlen(fname)
        endif

        " cut the path if it's too long.
        let str_len = strlen(path) + strlen(fname)
        if str_len > max_chars
            let path = strpart(path, str_len - max_chars)
        endif

        " round the path to the nearest slash.
        if path[0] != '~' && path[0] != '/'
            let pos = match(path, '\/') + 1
            let path = strpart(path, pos)
        endif

        if path[0] == '/'
            let path = strpart(path, 1)
        endif

        return strlen(path) ? path . '/' : ''
    endfu

" common utils
" -----------------------------------------------

python << END
import vim, os

def FindRoot(path, root_markers=None):
    if root_markers is None:
        root_markers = ['AndroidManifest.xml', '.git']

    if path == os.path.sep:
        return ''
    elif any(m in os.listdir(path) for m in root_markers):
        return path
    else:
        return FindRoot(os.path.dirname(path), root_markers)

END

" c utils
" -----------------------------------------------

python << END
import vim, os

def GoToHeaderFile(maxdepth=10):
    header = os.path.splitext(vim.eval("bufname('%')"))[0] + '.h'
    depth = 0
    for root, dirs, files in os.walk(vim.eval('getcwd()')):
        if depth >= maxdepth:
            break

        if header in files:
            vim.command("e {0}".format(
                os.path.join(root, header).replace(" ", "\ ")))
            return

        depth += 1

    print "No header file found"

def GoToMakefile(maxdepth=10):
    depth = 0
    for root, dirs, files in os.walk(vim.eval('getcwd()')):
        if depth >= maxdepth:
            break

        if "Makefile" in files:
            vim.command("e {0}".format(
                os.path.join(root, "Makefile").replace(" ", "\ ")))
            return

        depth += 1

    print "No Makefile found"

END

nnoremap <leader>k :py GoToMakefile()<CR>
nnoremap <leader>h :py GoToHeaderFile()<CR>


" misc utils
" -----------------------------------------------

" delete last path component in the command line (found on vim wikia)
cnoremap <C-T> <C-\>e(<SID>RemoveLastPathComponent())<CR>
fu! s:RemoveLastPathComponent()
    return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
endfu

fu! RestoreCursorPosition()
    if line("m`\"") > 0 && line("`\"") <= line("$")
        exe "normal g`\""
    endif
endfu

" }}}
