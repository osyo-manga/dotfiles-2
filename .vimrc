"  -----------------------------------------------------
"  vim configuration file
"  Maintainer: Giacomo Comitti - github.com/gcmt 
"  Last Change: 2 Aug 2013
"  -----------------------------------------------------

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    set rtp+=$HOME/dropbox/dev/vim-plum
    set rtp+=$HOME/dropbox/dev/vim-taboo
    set rtp+=$HOME/dropbox/dev/vim-ozzy
    set rtp+=$HOME/dropbox/dev/vim-breeze
    set rtp+=$HOME/dropbox/dev/vim-tube
    set rtp+=$HOME/dropbox/dev/vim-go-syntax
    set rtp+=/usr/local/go/misc/vim

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gcmt/indentLine'
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
    Bundle 'ap/vim-css-color'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/gundo.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'terryma/vim-expand-region'
    Bundle "Valloric/YouCompleteMe"
    Bundle 'kien/ctrlp.vim'
    Bundle 'nsf/gocode'
    Bundle 'tpope/vim-markdown'

    filetype plugin indent on
    syntax on

" }}}

" GENERAL OPTIONS -------------------------- {{{

    set sessionoptions+=tabpages,globals
    set encoding=utf-8
    set noautowrite
    set hidden
    set tags=tags
    set backspace=2
    set iskeyword=_,$,@,a-z,A-Z,48-57
    set autochdir
    set autoread
    set modeline

    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set history=1000
    set undolevels=1000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=10000

    set noswapfile
    set nobackup

    set shell=/usr/local/bin/zsh
    sil !source ~/.zshrc

    if $TMUX == ''
        set clipboard+=unnamed
    endif

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_stuff
        au!

        au VimResized * wincmd = | redraw
        au BufWinEnter * call RestoreCursorPosition()
        "au BufWritePost *.vim call ReloadVimFile()
        au BufWritePost .vimrc so $MYVIMRC
        au FocusLost,FocusGained,CursorHold,VimResized * call PlumSetBackground()

        au BufRead,BufNewFile *.pde        setf java
        au BufRead,BufNewFile *.pl         setf prolog
        au BufRead,BufNewFile *.clj        setf clojure
        au BufRead,BufNewFile *.go         setf go
        au BufRead,BufNewFile *.json       setf json
        au Filetype python                 setl tw=79 fdm=indent fdn=2 "ofu=pythoncomplete#Complete
        au Filetype markdown               setl tw=120
        au Filetype html,xml               setl nowrap
        au Filetype vim                    setl fdm=marker
        au Filetype go                     setl list ts=4 noet fdm=syntax fdn=1 ofu=gocomplete#Complete 
        au Filetype python,cpp,java        au! BufWritePre <buffer> call StripWhitespaces()

    augroup END

" }}}

" UI --------------------------------------- {{{

    " syntax options
    let html_no_rendering = 1

    " colorscheme options
    let g:plum_cursorline_highlight_only_linenr = 1

    colorscheme plum

    " this may help with slow syntax highlighting
    set synmaxcol=500
    if version >= 704
        set regexpengine=0
    endif

    if has("gui_running")

        set guioptions=mc  " remove 'e' for terminal-style tabs
        set linespace=0

        if has("gui_macvim")
            set guifont=Source\ Code\ Pro:h13
            "set guifont=GohuFont:h14
        else
            set guifont=Source\ Code\ Pro\ 10
        endif

    endif

    set noerrorbells vb t_vb=
    set t_Co=256
    set nostartofline
    set textwidth=79
    set formatoptions=qn1c
    set number
    set nocursorline

    set ttyfast
    set notimeout
    set ttimeout
    set ttimeoutlen=0

    set mouse=a
    set virtualedit=all

    set title
    set titlestring=%<%((⎇\ %{fugitive#head()})%)\ %F
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
    set stl+=\ %w%r%#StatusLineErr#%m%*%h
    set stl+=\ #%{bufnr('%')}\ %((⎇\ %{fugitive#head()})\ %)%{NiceFilePath()}%#StatusLineBold#%t%*
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ~\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ~\ ':''}
    set stl+=%1l:%02v\ ~\ %L:%P
    set stl+=%#StatusLineErr#%{empty(SyntasticStatuslineFlag())?'':'\ [errors]'}%*\ "

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
    imap jk <Esc>

    nmap j gj
    nmap k gk

    nnoremap J 3j
    nnoremap K 3k
    vnoremap J 3j
    vnoremap K 3k

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

" keep the cursor in place while joining lines
    nnoremap <leader>j mzJ`z

" delete all trailing white-spaces
    nnoremap <F8> :call StripWhitespaces()<CR>

" select entire buffer
    nnoremap vg ggVG

" don't move on *
    nnoremap * *<C-O>

" keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

" keep screen navigation centered: it seems that the cursor moves
" left or right when using these commands
    " jump forward one full screen.
    nnoremap <C-F> <C-F>zz2h  
    " jump backwards one full screen
    nnoremap <C-B> <C-B>zz2h  
    " jump forward a half screen
    nnoremap <C-D> <C-D>zzh 
    " jump back one half screen
    nnoremap <C-U> <C-U>zz

" shortcuts
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

" build tags for the current directory
    nnoremap <F4> :py GenerateTags()<CR>

" toggle between dark and light background
    nnoremap <silent> <F7> :exe 'set bg=' . (&bg == 'dark' ? 'light' : 'dark')<CR>

" go
    nnoremap <silent> <F6> :exe (&ft == 'go' ? 'Fmt' : '')<CR>:w<CR>
    nnoremap <silent> <F5> :!go run %<CR>

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
    let g:tagbar_iconchars = ['+ ', '* '] 
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
    let g:ozzy_shade_color = 'Comment'
    let g:ozzy_shade_color_darkbg = 'Comment'
    let g:ozzy_matches_color = 'WarningMsg'
    let g:ozzy_matches_color_darkbg = 'Function'
    nnoremap <leader>- :Ozzy<CR>

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

" YouCompleteMe

    let g:ycm_filetype_blacklist = {'vim':1, 'go':1}

" }}}

" FUNCTIONS -------------------------------- {{{

python << END
import vim, os


def GenerateTags():
    """Generate tags differently for go sources."""
    if vim.eval("&ft") == "go":
        flist = vim.curent.buffer.name
        #for root, dirs, files in os.walk(vim.eval('getcwd()')):
            #for f in filter(lambda f: f.endswith(".go"), files):
                #flist += " " + os.path.join(root, f)
        vim.command('exe "!gotags {} > tags"'.format(flist)) 
    else:
        vim.command('exe "!/usr/local/bin/ctags -R ."')


def FindRoot(path, root_markers=None):
    if root_markers is None:
        root_markers = ['AndroidManifest.xml', '.git']

    if path == os.path.sep:
        return ''
    elif any(m in os.listdir(path) for m in root_markers):
        return path
    else:
        return FindRoot(os.path.dirname(path), root_markers)


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

"nnoremap <leader>k :py GoToMakefile()<CR>
"nnoremap <leader>h :py GoToHeaderFile()<CR>


" generate a decent file path for the statusline
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

" strip trailing whitespace
fu! StripWhitespaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfu

" delete last path component in the command line (found on vim wikia)
cnoremap <C-T> <C-\>e(<SID>RemoveLastPathComponent())<CR>
fu! s:RemoveLastPathComponent()
    return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
endfu

fu! RestoreCursorPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal `\""
    endif
endfu

fu! ReloadVimFile()
    let dir = expand("%:p:h:t") 
    if dir == "colors"
        exe "colo " . g:colors_name
    elseif dir == "syntax" 
        syntax on
    endif
endfu

" }}}
