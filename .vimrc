"  -----------------------------------------------------
"  vim configuration file
"  Maintainer: Giacomo Comitti (github.com/gcmt)
"  Last Change: 27 Mar 2013
"  -----------------------------------------------------

" BASICS OPTIONS ------------------------- {{{ 

    set nocompatible
    filetype off
 
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
    Bundle 'skammer/vim-css-color'
    Bundle 'vim-scripts/AutoComplPop'
    Bundle 'beyondmarc/opengl.vim'
    Bundle 'Yggdroot/indentLine'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'vim-scripts/a.vim'
    Bundle 'mileszs/ack.vim'

    filetype plugin indent on
    syntax on

    " easy plugin development and git tracking
    "set rtp+=$HOME/dropbox/dev/vim-vlogcat/

    set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo
    set encoding=utf-8
    set notimeout
    set ttimeout
    set ttimeoutlen=0
    set undolevels=1000
    set undodir=~/.vim/undofiles
    set undofile
    set undoreload=10000
    set updatetime=10000

    set noswapfile
    set nobackup
    set noautowrite      " no autowrite on :next
    set noerrorbells vb t_vb=
    set backspace=indent,eol,start

    set history=1000
    set hidden           " allow change buffers without saving
    set ttyfast
    set modelines=0      " ignores modelines
    set tags=tags

    set autochdir        " automatically cd into the dir of the open file
    set autoread         " automatically reads a file if has changed on disk

    set shell=/usr/local/bin/zsh

    if $TMUX == ''
        set clipboard+=unnamed
    endif

" }}} 

" AUTOCOMMANDS --------------------------- {{{ 

    augroup vim_behavior
        au!
        au focusGained * echo ' Welcome back ' . $USER . "!"
        "au focusLost * wall " save all
        au guiEnter * set columns=82 lines=45
        au vimResized * wincmd =
        au BufWinEnter * call RestoreCursorPosition()
        " automatically enter normal mode after 'updatetime' mseconds
        "au cursorHoldI * stopinsert
    augroup END

    augroup adjust_ft
        au!
        au FileType yml,yaml,html,xhtml,htmldjango,htmljinja,css setlocal sw=2 ts=2 sts=2
        au Filetype htmldjango,htmljinja setfiletype html
        au BufRead *.rss,*.atom setfiletype xml
        au BufRead *.pde setfiletype java
        au BufRead *.pl setfiletype prolog
    augroup END

    augroup html_xml_ft
        au!
        " fold html tags
        au FileType html nnoremap <buffer> <leader>h Vatzf
        au Filetype html,xml setlocal nowrap
        au Filetype html,xml let html_no_rendering = 1
        au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    augroup css_ft
        au!
        au FileType css setlocal nocindent
        au Filetype css setlocal omnifunc=csscomplete#CompleteCSS
    augroup END

    augroup py_ft
        au Filetype python setlocal omnifunc=pythoncomplete#Complete
    augroup END

    augroup java_ft
        au Filetype java setlocal omnifunc=javacomplete#Complete
        au FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
    augroup END

    augroup vim_ft
        au!
        au BufWritePost .vimrc source $MYVIMRC
        au FileType vim setlocal foldmethod=marker
    augroup END

" }}} 

" GUI ------------------------------------ {{{  

    colorscheme Tomorrow 
    if has("gui_running")
        set guioptions=mc   " add 'e' to have macvim style tabs
        if has("gui_macvim")
            set guifont=inconsolata-g:h12
        elseif has('gui_win32')
            set guifont=Consolas:h10:cANSI
        else
            set guifont=inconsolata-g\ Medium\ 10
        endif
    endif

" }}} 

" UI OPTIONS ----------------------------- {{{  

    set t_Co=256
    set lazyredraw        " don't update the display while executing macros

    set mousemodel=popup
    set mouse=a           " allow mouse
    set mousehide         " hides the mouse cursor while typing

    set virtualedit=onemore
    set linespace=2       " don't insert any extra pixel lines between rows
    set title
    set titlestring=%F
    set completeopt=longest,menuone,preview

    set wildmenu          " make the command-line completion better
    set wildmode=longest,full  " show up completions
    set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*$py.class,*.class,*.fasl
    set wildignore+=*.jpg,*.jpeg,*.png,*.gif,.DS_Store,.gitignore,.git,tags
    set wildignore+=*.swp,*.dex,*.apk,*.d,*.cache,*.ap_,.git,.gtignore

    set number
    set numberwidth=2
    set ruler             " always show current positions at the bottom

    set cmdheight=1       " make command line 2 lines high
    set showcmd           " show command I'm typing
    set noshowmode          " let me know the mode I'm in
    set report=0          " tell us when and how many lines changed
    set shortmess=IaA
    set magic             " allow pattern matching with special charactrers

    set sidescrolloff=0
    set scrolloff=0

    set wrap
    set textwidth=79      " textwidth is 79 chars
    set formatoptions=qn1c
    set colorcolumn=0

    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4      " amount of ws inserted or removed while indenting
    set shiftround
    set autoindent        " automatically indent when adding a brackets
    set smartindent
    set cindent

    set nolist
    set fillchars=vert:\|
    set listchars=tab:▸\ ,trail:·,eol:¬,precedes:<,extends:>,nbsp:.
    set showbreak=↳
    set linebreak

    set splitbelow
    set splitright
    set wmh=0             " collapsed window
    set stal=1            " show tabs bar only if there are tabs

    set colorcolumn=0     " do not show colored column
    set synmaxcol=800

    set wrapscan     " continue searching at top when bottom is reached
    set ignorecase
    set smartcase
    set showmatch    " show matching brackets
    set incsearch    " highlight as I type a something
    set hlsearch
    set gdefault     " assume always global, /g

" }}} 

" STATUSLINE & TABLINE ------------------- {{{  

    set laststatus=2  " always show status line

    " utf chars: « » × ¬ ¶ ø · § ▸ ●  [%{toupper(mode())}]

    set stl=
    set stl+=\ %w%r%#StatuslineErr#%m%*
    set stl+=\ %{DynamicFilePath(1)} " 1 means relative to home
    set stl+=%=
    set stl+=%{strlen(&ft)?tolower(&ft).'\ ●\ ':''}
    set stl+=%{winwidth(winnr())>80?(strlen(&fenc)?&fenc.',':'').&ff.'\ ●\ ':''}
    set stl+=%1l:%02c\ ●\ %L:%P\ "   

    " tabline options
    set showtabline=1

" }}} 

" MAPPINGS ------------------------------- {{{  

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
    nnoremap <right> <nop>
    
" clear searches
    nnoremap <silent> <leader><space> :noh<CR>

" select the current line excluding starting whitespaces
    nnoremap vv ^v$

" alternate buffer (last modified buffer
    nnoremap <space> <c-^>

" move across buffers
    nnoremap <silent> <leader>n :bn<CR>
    nnoremap <silent> <space> :bn<CR>
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

" delete all ^M / trailing white-spaces
    command! TM exe "mz:%s/\r//<CR>:let @/=''<CR>`z"
    nnoremap S mz:%s/\s\+$//<CR>:let @/=''<CR>`z

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

" jump to buffers
    nnoremap <silent> <leader>1 :b1<CR>
    nnoremap <silent> <leader>2 :b2<CR>
    nnoremap <silent> <leader>3 :b3<CR>
    nnoremap <silent> <leader>4 :b4<CR>
    nnoremap <silent> <leader>5 :b5<CR>
    nnoremap <silent> <leader>6 :b6<CR>
    nnoremap <silent> <leader>7 :b7<CR>
    nnoremap <silent> <leader>8 :b8<CR>
    nnoremap <silent> <leader>9 :b9<CR>

" }}} 

" PLUGINS -------------------------------- {{{  

" NERDTree
    let NERDTreeShowBookmarks = 1
    nnoremap <silent> <F1> :NERDTreeToggle<CR>
    nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" Tagbar
    let g:tagbar_left = 0
    let g:tagbar_sort = 0
    let g:tagbar_width = 35
    let g:tagbar_iconchars = ['▸', '¬']
    nnoremap <silent> <F2> :TagbarToggle<CR>

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

" Syntastic 
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
    
" }}} 

" FUNCTIONS ------------------------------ {{{  

" cycle through colorschemes
" -----------------------------------------------

    fu! CycleColorschemes()
        let g:colorcount += 1
        call SetColorscheme()
    endfu

    fu! SetColorscheme()
        let colorschemes = [ 'Tomorrow', 'Tomorrow-Night']
        let scheme = colorschemes[g:colorcount % len(colorschemes)]

        if scheme == 'Tomorrow'
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

    fu! DynamicFilePath(relative_to_home)
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

        " if relative_to_home is set to true the path that match the $HOME is
        " substitute with '~/'.
        if a:relative_to_home
            let path = substitute(abs_path, $HOME, '~', '')
        else
            let path = abs_path
        endif

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

        return "#" . bufnr('%') . " " . path
    endfu

" android utils
" -----------------------------------------------

python << END
import vim, os

def android_project_root(path):
    if path == os.path.sep:
        return ''
    elif 'AndroidManifest.xml' in os.listdir(path):
        return path
    else:
        return android_project_root(os.path.split(path)[0])

def OpenAndroidManifest():
    root = android_project_root(vim.eval('getcwd()'))
    if root:
        vim.command("e {0}".format(root + '/AndroidManifest.xml'))
    else:
        print "No manifest file found"
END

nnoremap <leader>a :py OpenAndroidManifest()<CR> 

" utilities
" -----------------------------------------------

" delete las path component in the command line
cnoremap <C-t> <C-\>e(<SID>RemoveLastPathComponent())<CR>
function! s:RemoveLastPathComponent()
    return substitute(getcmdline(), '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', '')
endfunction

" restore last cursor positions
function! RestoreCursorPosition()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
" }}} 
