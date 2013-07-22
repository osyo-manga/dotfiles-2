
# z 
. `brew --prefix`/etc/profile.d/z.sh

# initialize colors
autoload -U colors; colors

## env vars

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
export PATH="/Applications/Racket v5.3.4/bin:${PATH}"

# prompt
precmd() { print -rP "%{$fg[blue]%}%n%{$reset_color%} at %{$fg[blue]%}%m%{$reset_color%} in %{$fg[blue]%}%~%{$reset_color%}" } 
PROMPT='=> '   #%nd : show last n parts of the paths ▸

# autoenv
source /usr/local/opt/autoenv/activate.sh

# tmux
[ -z "$TMUX" ] && export TERM=screen-256color

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/share/python/virtualenvwrapper.sh   

## aliases

alias v="workon"
alias v.d="deactivate"
alias v.mk="mkvirtualenv"
alias v.mkpkg="mkvirtualenv --system-site-packages"
alias v.rm="rmvirtualenv"

alias z.e="vim ~/.zshrc"
alias z.s="source ~/.zshrc"

alias p.f="pip freeze"
alias p.i="pip install -U"
alias p.u="pip uninstall"

alias py="python"
alias py3="python3"
alias pip3="pip-3.3"
alias py.i="python setup.py install"
alias py.d="python setup.py develop"
alias ipy="ipython"
alias ipynb="ipython notebook --pylab inline"

alias s="smash --colors"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="clear"
alias ls="ls -GC"

## functions

# symlink wx into the current python virtual environment 
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

## options

setopt correctall

autoload -U promptinit; promptinit
autoload -U compinit; compinit

export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

setopt PROMPT_SUBST
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt nolistambiguous
setopt extendedglob
setopt autocd
setopt No_Beep

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
