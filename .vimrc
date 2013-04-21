"  -----------------------------------------------------
"  vim configuration file
"  Maintainer: Giacomo Comitti (github.com/gcmt)
"  Last Change: 17 Apr 2013
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
    Bundle 'mattn/zencoding-vim'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'sjl/vitality.vim'
    Bundle 'benmills/vimux'
    Bundle 'majutsushi/tagbar'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'SirVer/ultisnips'
    Bundle 'scrooloose/syntastic'
    Bundle 'gcmt/taboo.vim'
    Bundle 'gcmt/ozzy.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'ap/vim-css-color'
    Bundle 'vim-scripts/AutoComplPop'
    Bundle 'beyondmarc/opengl.vim'
    Bundle 'Yggdroot/indentLine'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'mileszs/ack.vim'
    Bundle 'godlygeek/tabular'
    Bundle 'sjl/gundo.vim'

    filetype plugin indent on
    syntax on

" }}}

" GENERAL OPTIONS -------------------------- {{{

    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set encoding=utf-8

    set ttyfast
    set notimeout
    set ttimeout
    set ttimeoutlen=0
    set updatetime=10000

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
    set iskeyword=_,$,@,%,#,.,-,a-z,A-Z,48-57

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
        au focusGained * echo ' Welcome back ' . $USER . "!"
        au guiEnter * set columns=80 lines=45
        au vimResized * wincmd =
        " Restore cursor position
        au BufWinEnter * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif
    augroup END

    augroup ft_stuff

        au!
        au BufWritePost .vimrc             source $MYVIMRC
        au BufRead,BufNewFile *.haml       set ft=haml
        au BufRead,BufNewFile *.md         set ft=mkd tw=72 ts=2 sw=2
        au BufRead,BufNewFile *.markdown   set ft=mkd tw=72 ts=2 sw=2
        au BufRead,BufNewFile *.pde        set ft=java
        au BufRead,BufNewFile *.pl         set ft=prolog

        au Filetype python                 setlocal tw=79
        au Filetype python                 setlocal omnifunc=pythoncomplete#Complete
        au Filetype htmldjango,htmljinja   set ft=html
        au Filetype html,xml               setlocal wrap
        au Filetype html,xml               let html_no_rendering = 1
        au Filetype css                    setlocal omnifunc=csscomplete#CompleteCSS ts=2 sw=2
        au Filetype haml                   setlocal ts=2 sw=2 sts=0 tw=120
        au Filetype java                   setlocal omnifunc=javacomplete#Complete
        au Filetype vim                    setlocal foldmethod=marker
        au Filetype mkd                    setlocal spell
        au Filetype go                     setlocal list noexpandtab ts=4 
        au Filetype go                     setlocal omnifunc=gocomplete#Complete
        au BufWritePre *.go,*.py,*.cpp,*.java   exec "silent! normal S"

    augroup END

" }}}

" UI --------------------------------------- {{{

    colorscheme Tomorrow
    set background=light
    if has("gui_running")

        set guioptions=mc   " add 'e' for macvim style tabs
        set linespace=0

        if has("gui_macvim")
            set guifont=Inconsolata-g:h13
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

    set virtualedit=onemore
    set title
    set titlestring=%<[%{tolower(&ft)}]\ %F
    set titlelen=70
    set completeopt=longest,menuone

    set wildmenu
    set wildmode=longest,full
    set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*$py.class,*.class,*.fasl
    set wildignore+=*.jpg,*.jpeg,*.png,*.gif,.DS_Store,.gitignore,.git,tags
    set wildignore+=*.swp,*.dex,*.apk,*.d,*.cache,*.ap_,.git,.gtignore

    set number
    set numberwidth=2
    set ruler

    set cmdheight=1
    set showcmd
    set noshowmode
    set report=0
    set shortmess=IaA
    set magic

    set sidescrolloff=1
    set scrolloff=1
    set nostartofline

    set wrap
    set textwidth=79
    set formatoptions=qn1c
    set colorcolumn=0

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
    set listchars=tab:┆\ ,trail:·,precedes:❮,extends:❯ ",eol:¬,nbsp:. "▸
    set showbreak=↳
    set linebreak

    set splitbelow
    set splitright
    set wmh=0
    set stal=1

    set colorcolumn=0
    set synmaxcol=800

    set wrapscan
    set ignorecase
    set smartcase
    set showmatch
    set incsearch
    set hlsearch
    set gdefault

" }}}

" STATUSLINE & TABLINE --------------------- {{{

    set laststatus=2

    " « » × ¬ ¶ ø · § ▸ ●  [%{toupper(mode())}]

    set stl=
    set stl+=\ %w%r%#StatuslineErr#%m%*
    set stl+=%{fugitive#head()}\ #%{bufnr('%')}\ %{DynamicFilePath()}
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ●\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.':':'').&ff.'\ ●\ ':''}
    set stl+=%1l:%02c\ ●\ %L:%P\ "

    " tabline options
    set showtabline=1

" }}}

" MAPPINGS --------------------------------- {{{

    let mapleader=","
    imap jj <Esc>
    nnoremap ; :
    command! W w
    command! Wa wa
    command! Wq wq
    command! Q q
    command! On on

    nmap j gj
    nmap k gk
    nnoremap J 3j
    nnoremap K 3k
    vnoremap J 3j
    vnoremap K 3k
    vnoremap < <gv
    vnoremap > >gv

    nnoremap <F5> :make<CR>
    inoremap <F5> <ESC>:make<CR>

    inoremap <C-c> <C-x><C-o>

" win
    nnoremap q: :q

" edit the vimrc file
    nnoremap <silent> <leader>r :e $MYVIMRC<CR>

" build tags for the current directory
    nnoremap <F8> :!/usr/local/bin/ctags -R .<CR>

" kill window
    nnoremap <silent> Q :q<CR>

" delete buffer but the window
    nnoremap <leader>q :Kwbd<CR>

" Y now behaves like other capitals
    nnoremap Y y$

" unmap arrows on insert mode
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
    nnoremap <up> <nop>
    nnoremap <down> <nop>
    nnoremap <left> <nop>
    nnoremap <right> <nop

" clear searches
    nnoremap <silent> <leader><space> :noh<CR>

" select the current line excluding starting whitespaces
    nnoremap vv ^v$

" alternate buffer (last modified buffer
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
    nnoremap <leader>- :tabedit! %<CR>

" easy windows moving
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l

" paste and indent
    nnoremap <silent> <leader>p p`[v`]=

" keep the cursor in place while joining lines
    nnoremap <leader>j mzJ`z

" delete all trailing white-spaces
    nnoremap <silent> S mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" force saving files that require root permission
    cmap w!! w !sudo tee %

" select entire buffer
    nnoremap va ggVG

" don't move on *
    nnoremap * *<c-o>

" keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

" useful
    inoremap <c-a> <esc>A
    inoremap <c-e> <esc>I
    " delete the previous word
    inoremap <c-s> <esc>diwi

" braces match
    nnoremap <CR> %

" english typos
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

" toggle options
    noremap <silent> <leader># :setlocal number!<CR>

" format paragraph
   vnoremap A gq
   nnoremap A gqap

" }}}

" PLUGINS ---------------------------------- {{{

" NERDTree
    let NERDTreeShowBookmarks = 1
    nnoremap <silent> <F1> :NERDTreeToggle<CR>

" Tagbar
    let g:tagbar_left = 0
    let g:tagbar_sort = 0
    let g:tagbar_width = 35
    let g:tagbar_iconchars = ['▸', '¬']
    nnoremap <silent> <F2> :TagbarToggle<CR>

    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

" Ctrlp
    let g:ctrlp_max_height = 20
    let g:ctrlp_working_path_mode = 'rc'
    let g:ctrlp_root_markers = ['AndroidManifest.xml']
    nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Ozzy
    let g:ozzy_ignore = ['tags', '.env', '.gitignore']
    let g:ozzy_track_only = ['/Users/giacomo/dropbox/', '/Users/giacomo/Dropbox/']
    nnoremap <leader>o :Ozzy<CR>

" Psearch
    nnoremap <leader>s :PSearch<CR>

" Tube
    let g:tube_terminal = 'iterm'
    let g:tube_enable_shortcuts = 1
    let g:tube_aliases = {
        \'andc': 'cd #{AndroidProjectRoot} && ant clean debug',
        \'andi': 'cd #{AndroidProjectRoot} && ant clean debug install',
    \}

" IndentLine
    let g:indentLine_color_term = 250
    let g:indentLine_char = '┆'
    let g:indentLine_fileTypeExclude = ['py', 'text', 'mkd', 'help']

" Syntastic
    nnoremap <leader>e :Errors<CR>
    nnoremap <leader>E :lcl<CR>
    let g:syntastic_error_symbol = '✕'
    let g:syntastic_warning_symbol = '⁕'
    let g:syntastic_style_error_symbol = '✕'
    let g:syntastic_style_warning_symbol = '⁕'
    highlight link SyntasticErrorSign WarningMsg
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['c', 'cpp', 'javascript', 'python'],
        \ 'passive_filetypes': ['java']
    \}

" AutoComplPop
    let g:acp_ignorecaseOption = 0
    let g:acp_behaviorKeywordLength = 1

" Ack
    nnoremap <leader>* :Ack

" Go
    nnoremap <leader>i :Import  

" Ultisnips
    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "CustomSnips"]
    let g:UltiSnipsDontReverseSearchPath = "1"

" Tabularize
" :Tabularize /=\zs
"

" }}}

" FUNCTIONS -------------------------------- {{{

" cycle through colorschemes
" -----------------------------------------------

    fu! CycleColorschemes()
        let g:colorcount += 1
        call SetColorscheme()
    endfu

    fu! SetColorscheme()
        let colorschemes = ['Tomorrow', 'Tomorrow-Night', 'solarized']
        let scheme = colorschemes[g:colorcount % len(colorschemes)]

        if scheme == 'Tomorrow' || scheme == 'Tomorrow-Block'
            let g:indentLine_color_gui = '#cccccc'
        else
            let g:indentLine_color_gui = '#333333'
        endif

        exec 'colorscheme ' . scheme
    endfu

    let g:colorcount = exists('g:colorcount') ? g:colorcount : 0
    call SetColorscheme()

" cycle through some colorschemes
    nnoremap <silent> <F7> :call CycleColorschemes()<CR>


" show a decent path on the statusline
" -----------------------------------------------

    fu! DynamicFilePath()
        let abs_path = expand('%:p')

        " Note that the width is not aware of the others components on the
        " status line, so  you substract 60 or wathever you think other
        " components are occupying
        let k = 5
        let x = winwidth(winnr()) - 60
        let x = x < 0 ? 0 : x
        let max_chars = float2nr(k * sqrt(x))

        " show only file name if the current buffer is an help document
        let fname = expand('%:t')
        if &buftype == 'help' || &buftype == 'nofile'
            return fname
        endif

        " be sure the file name is shown entirely
        let file_name_len = strlen(fname)
        if max_chars < file_name_len
            let max_chars = file_name_len
        endif

        let path = substitute(abs_path, $HOME, '~', '')

        " cut the path if it is still too long.
        let str_len = strlen(path)
        if str_len > max_chars
            let path = strpart(path, str_len - max_chars)
        endif

        " round the path to the nearest slash.
        if path[0] != '~' && path[0] != '/'
            let pos = match(path, '\/') + 1
            let path = strpart(path, pos)
        endif

        return path
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
        return FindRoot(os.path.split(path)[0], root_markers)
END


" android utils
" -----------------------------------------------

python << END
import vim, os

def OpenAndroidManifest():
    root = FindRoot(vim.eval('getcwd()'), root_markers=['AndroidManifest.xml'])
    if root:
        vim.command("e {0}".format(root + '/AndroidManifest.xml'))
    else:
        print "No manifest file found"

def InstallProject(): 
    curr_dir = vim.eval('getcwd()')
    root = FindRoot(curr_dir, root_markers=['AndroidManifest.xml'])
    if root:
        vim.command("cd {0}".format(root))
        vim.command("!ant clean debug install")
    else:
        print "No project found"
    vim.command("cd {0}".format(curr_dir))
END

nnoremap <leader>am :py OpenAndroidManifest()<CR>
nnoremap <leader>ai :py InstallProject()<CR>


" c utils
" -----------------------------------------------

python << END
import vim, os

def GoToHeaderFile(maxdepth=10):
    depth = 0
    header = os.path.splitext(vim.eval("bufname('%')"))[0] + '.h'
    for root, dirs, files in os.walk(vim.eval('getcwd()')):
        if depth >= maxdepth:
            break

        if header in files:
            vim.command("e {0}".format(root + '/' + header))

        depth += 1

    print "No header file found"
END

nnoremap <leader>h :py GoToHeaderFile()<CR>

" utilities
" -----------------------------------------------

" delete las path component in the command line
cnoremap <C-t> <C-\>e(<SID>RemoveLastPathComponent())<CR>
function! s:RemoveLastPathComponent()
    return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
endfunction

" }}}
