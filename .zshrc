
# z 
. `brew --prefix`/etc/profile.d/z.sh

# initialize colors
autoload -U colors
colors

# allow functions expantions in the prompt
setopt PROMPT_SUBST

# enable auto-execution of functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# custom prompt
precmd() { print -rP "%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[green]%}%m%{$reset_color%} in %{$fg_bold[blue]%}%~%{$reset_color%}" } 
PROMPT='%{$fg_bold[blue]%}❯%{$reset_color%} '   #%nd : show last n parts of the paths ▸

export GREP_OPTIONS="--color=auto"
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/dropbox/dev/go:$GOPATH
export GOPATH=$HOME/bin/go:$GOPATH
export PATH=$HOME/bin/go/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/bin/android-sdk/tools:$PATH
export PATH=$HOME/bin/android-sdk/platform-tools:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/bin:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export PATH="/Applications/Racket v5.3.3/bin:${PATH}"

# liquidprompt
source ~/.liquidpromptrc
source ~/.liquidprompt

# autoenv
source /usr/local/opt/autoenv/activate.sh

# tmux
[ -z "$TMUX" ] && export TERM=screen-256color

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/share/python/virtualenvwrapper.sh

# virtualenv aliases
alias v="workon"
alias v.d="deactivate"
alias v.mk="mkvirtualenv"
alias v.mkpkg="mkvirtualenv --system-site-packages"
alias v.rm="rmvirtualenv"

# zsh aliases
alias z.e="vim ~/.zshrc"
alias z.s="source ~/.zshrc"

# pip aliases
alias p.f="pip freeze"
alias p.i="pip install -U"
alias p.u="pip uninstall"

# python aliases
alias py="python"
alias py3="python3"
alias pip3="pip-3.3"
alias py.i="python setup.py install"
alias py.d="python setup.py develop"
alias ipy="ipython"

# smash aliases
alias s="smash --colors"

# generic aliases
alias ..="cd .."
alias c="clear"
alias ls="ls -GC"
alias lc="adb logcat"

v.usewx () {
    CURRENT_DIR=`pwd`

    if [ -z "$VIRTUAL_ENV" ]; then
        return
    fi

    echo 'linking wx files...'
    cp $HOME/dropbox/dotfiles/gpy $VIRTUAL_ENV/bin/gpy
    cdsitepackages
    ln -s /usr/local/lib/python2.7/site-packages/wx
    ln -s /usr/local/lib/python2.7/site-packages/wx-2.9.4-osx_cocoa
    ln -s /usr/local/lib/python2.7/site-packages/wx.pth
    ln -s /usr/local/lib/python2.7/site-packages/wxPython_common-2.9.4.0-py2.7.egg-info
    ln -s /usr/local/lib/python2.7/site-packages/wxversion.py
    ln -s /usr/local/lib/python2.7/site-packages/wxversion.pyc
    cdvirtualenv
    cd $CURRENT_DIR
}

v.rmwx () {
    CURRENT_DIR=`pwd`

    if [ -z "$VIRTUAL_ENV" ]; then
        return
    fi

    echo 'removing wx links...'
    rm -f $VIRTUAL_ENV/bin/gpy
    cdsitepackages
    rm -rf wx
    rm -rf wx-2.9.4-osx_cocoa
    rm -f wx.pth
    rm -f wxPython_common-2.9.4.0-py2.7.egg-info
    rm -f wxversion.py
    rm -f wxversion.pyc
    cdvirtualenv
    cd $CURRENT_DIR
}     

# automatically activate virtuasource /usr/local/opt/autoenv/activate.shlenv with autoenv
# thanks to Kenneth Reitz!
use_env() {
    typeset venv
    venv="$1"
    if [[ `basename "${VIRTUAL_ENV:t}"` != "$venv" ]]; then
        if workon | grep $venv > /dev/null; then
            workon "$venv"
        else
            echo -n "Create virtualenv '$venv' now? (Yn) "
            read answer
            if [[ "$answer" == "Y" ]]; then
                mkvirtualenv "$venv"
            fi
        fi
    fi
}

# options

autoload -U promptinit; promptinit

export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt nolistambiguous
setopt extendedglob

bindkey -v
zstyle :compinstall filename '/home/giacomo/.zshrc'
