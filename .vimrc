"  -----------------------------------------------------
"  vim configuration file
"  Maintainer: Giacomo Comitti (github.com/gcmt)
"  Last Change: 6/24/2013
"  -----------------------------------------------------

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    " where binaries of third party go packages are located
    let $PATH = $HOME . '/bin/go/bin:' . $PATH

    let $GOPATH = $HOME . '/dropbox/dev/go:' . $GOPATH
    let $GOPATH = $HOME . '/bin/go:' . $GOPATH

    set rtp+=/usr/local/go/misc/vim

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " bundles
    Bundle 'gmarik/vundle'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-eunuch'
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
    Bundle 'gcmt/psearch.vim'
    Bundle 'ap/vim-css-color'
    Bundle 'beyondmarc/opengl.vim'
    Bundle 'Yggdroot/indentLine'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/gundo.vim'
    Bundle 'klen/python-mode'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'vim-scripts/AutoComplPop'

    filetype plugin indent on
    syntax on

" }}}

" GENERAL OPTIONS -------------------------- {{{

    set sessionoptions+=tabpages,globals
    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set encoding=utf-8
    set ttyfast
    set notimeout
    set ttimeout
    set ttimeoutlen=0
    set history=1000
    set undolevels=1000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=10000
    set noswapfile
    set nobackup
    set noautowrite
    set noerrorbells vb t_vb=
    set nomodeline
    set hidden
    set tags=tags
    set backspace=2
    set iskeyword=_,$,@,%,#,-,a-z,A-Z,48-57
    set autochdir
    set autoread
    set shell=/usr/local/bin/zsh

    if $TMUX == ''
        set clipboard+=unnamed
    endif

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_behavior
        au!
        au FocusGained * echo ' Welcome back ' . $USER . "!"
        au VimResized * wincmd = | redraw
        au BufWinEnter * call RestoreCursorPosition()
    augroup END

    augroup ft_stuff

        au!
        au BufWritePost .vimrc             source $MYVIMRC
        au BufRead,BufNewFile *.haml       set ft=haml
        au BufRead,BufNewFile *.md         set ft=mkd tw=79
        au BufRead,BufNewFile *.markdown   set ft=mkd tw=79
        au BufRead,BufNewFile *.pde        set ft=java
        au BufRead,BufNewFile *.pl         set ft=prolog
        au BufWritePre *.go,*.py,*.cpp,*.java exec "silent! normal S"

        au Filetype python                 setlocal tw=79
        au Filetype python                 setlocal omnifunc=pythoncomplete#Complete
        au Filetype htmldjango,htmljinja   set ft=html
        au Filetype html,xml               setlocal nowrap
        au Filetype html,xml               let g:html_no_rendering = 1
        au Filetype css                    setlocal omnifunc=csscomplete#CompleteCSS
        au Filetype haml                   setlocal ts=2 sw=2 sts=0 tw=120
        au Filetype java                   setlocal omnifunc=javacomplete#Complete
        au Filetype vim                    setlocal foldmethod=marker
        au Filetype mkd                    setlocal spell
        au Filetype go                     setlocal list noexpandtab ts=4 

    augroup END

" }}}

" UI --------------------------------------- {{{

    colorscheme Tomorrow
    set background=light

    if has("gui_running")
        set guioptions=mc  " add 'e' for macvim style tabs
        set linespace=0

        if has("gui_macvim")
            set guifont=Source\ Code\ Pro:h13
        elseif has('gui_win32')
            set guifont=Consolas:h10:cANSI
        else
            set guifont=inconsolata-g\ Medium\ 10
        endif
    endif

    set t_Co=256
    set nolazyredraw
    set mousemodel=popup
    set mouse=a
    set mousehide
    set virtualedit=all
    set title
    set titlestring=%<%((⎇\ %{fugitive#head()})%)\ %F
    set titlelen=100
    set completeopt=longest,menuone
    set wildmenu
    set wildmode=longest,full
    set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*$py.class,*.class,*.fasl
    set wildignore+=*.jpg,*.jpeg,*.png,*.gif,.DS_Store,.gitignore,.git,tags
    set wildignore+=*.swp,*.dex,*.apk,*.d,*.cache,*.ap_,.env
    set number
    set numberwidth=2
    set ruler
    set cmdheight=1
    set showcmd
    set noshowmode
    set report=0
    set shortmess=IaA
    set sidescrolloff=1
    set scrolloff=0
    set nostartofline
    set wrap
    set textwidth=79
    set colorcolumn=
    set synmaxcol=800
    set formatoptions=qn1c
    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
    set shiftround
    set autoindent
    set smartindent
    set cindent
    set nolist
    set fillchars=vert:\|
    set listchars=tab:\|\ ,trail:·,precedes:<,extends:>
    set showbreak=↳
    set linebreak
    set splitbelow
    set splitright
    set wmh=0
    set stal=1
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
    set stl+=\ %((⎇\ %{fugitive#head()})\ %)%{NiceFilePath()}%#StlBold#%t%*
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ●\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ●\ ':''}
    set stl+=%1l:%02v\ ●\ %L:%P
    set stl+=\ %#StlErr#%{SyntasticStatuslineFlag()}%*\ 

" }}}

" MAPPINGS --------------------------------- {{{

    let mapleader=","
    imap jj <Esc>

    nnoremap ' `

    nmap j gj
    nmap k gk

    vnoremap < <gv
    vnoremap > >gv

    nnoremap J 3j
    nnoremap K 3k
    vnoremap J 3j
    vnoremap K 3k

    command! -complete=file -nargs=* E exec 'e '.<q-args>
    command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
    command! Wa wa
    command! Wq wq
    command! -bang Q quit<bang>
    command! On on
    nnoremap q: :q
    nnoremap ; :
    command! Mes mes

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

" split and move
    nnoremap <leader>w <C-w>v<C-w>l
    nnoremap <leader>W <C-w>s<C-w>l

" open/close tabs
    nnoremap <leader>t :tabedit! %<CR>

" paste and indent
    nnoremap <silent> <leader>p p`[v`]=

" keep the cursor in place while joining lines
    nnoremap <leader>j mzJ`z

" delete all trailing white-spaces
    nnoremap <silent> S mz:%s/\s\+$//<CR>:let @/=''<CR>`z 

" select entire buffer
    nnoremap vg ggVG

" don't move on *
    nnoremap * *<c-o>

" keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

" shortcuts
    inoremap <c-a> <esc>A
    inoremap <c-e> <esc>I
    inoremap <c-s> <esc>diwi

" typos
    iabbr lenght length
    iabbr wiht with
    iabbr prinln println
    iabbr Flase False
    iabbr retrun return
    iabbr NOne None
    iabbr direcotry directory

" easy backquote and tilde
    inoremap <leader>' `
    inoremap <leader>? ~

" }}}

" PLUGINS ---------------------------------- {{{

" Gundo
    nnoremap <silent> <F3> :GundoToggle<CR>

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
    let g:ozzy_ignore = ['tags', '.env', '.gitignore', 'Makefile', '.vimrc']
    let g:ozzy_track_only = ['/Users/giacomo']
    let g:ozzy_project_mode_flag = '-> '
    let g:ozzy_global_mode_flag = '>> ' 
    let g:ozzy_prompt = ''
    let g:ozzy_hl_last_dir = 0
    nnoremap <leader>- :Ozzy<CR>
    nnoremap <leader>_ :OzzyToggleMode<CR>

" IndentLine
    let g:indentLine_color_term = 251
    let g:indentLine_char = '￨'
    let g:indentLine_fileType = ['html', 'xml', 'java', 'go', 'c', 'cpp']

" Syntastic
    nnoremap <leader>e :Errors<CR>
    "nnoremap <leader>E :lcl<CR>
    let g:syntastic_error_symbol = '✕'
    let g:syntastic_warning_symbol = '⁕'
    let g:syntastic_style_error_symbol = '✕'
    let g:syntastic_style_warning_symbol = '⁕'
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

" Python-mode
    let g:pymode_folding = 1
    let g:pymode_syntax = 0
    let g:pymode_run = 0
    let g:pymode_lint_write = 0
    let g:pymode_doc = 0

" Multiple cursors
    let g:multi_cursor_use_default_mapping = 0
    let g:multi_cursor_next_key='<C-y>'
    let g:multi_cursor_prev_key='<C-g>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

" AutocomplPop
    let g:acp_ignorecaseOption = 0
    let g:acp_behaviorKeywordLength = 2

" }}}

" FUNCTIONS -------------------------------- {{{

" cycle colorschemes
" -----------------------------------------------

    fu! CycleColorschemes()
        let g:colorcount += 1
        call SetColorscheme()
    endfu

    fu! SetColorscheme()
        let colorschemes = ['Tomorrow', 'Tomorrow-Night']
        let scheme = colorschemes[g:colorcount % len(colorschemes)]
        let g:indentLine_color_gui = scheme == 'Tomorrow' ? '#cccccc' : '#333333'
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

        let x = winwidth(winnr()) - 40
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

" delete las path component in the command line
cnoremap <C-t> <C-\>e(<SID>RemoveLastPathComponent())<CR>
function! s:RemoveLastPathComponent()
    return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
endfunction

function! RestoreCursorPosition()
    if line("m`\"") > 0 && line("`\"") <= line("$")
        exe "normal g`\""
    endif
endfunction

" }}}
