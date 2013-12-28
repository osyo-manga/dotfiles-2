
# aliases

alias z.s="source ~/.zshrc"
alias z.a="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/aliases.zsh"
alias z.p="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/path.zsh"
alias z.m="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/misc.zsh"
alias z.r="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/prompt.zsh"
alias z.e="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/exports"
alias z.o="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/options.zsh"
alias z.f="vim `dirname $(readlink $HOME/.zshrc)`/.zsh/functions.zsh"

alias v="workon"
alias v.d="deactivate"
alias v.mk="mkvirtualenv"
alias v.mkpkg="mkvirtualenv --system-site-packages"
alias v.rm="rmvirtualenv"

alias p.f="pip freeze"
alias p.i="pip install -U"
alias p.u="pip uninstall"

alias py="python"
alias py3="python3"
alias py.i="python setup.py install"
alias py.d="python setup.py develop"
alias ipy="ipython"

alias cb="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ..="cd .."
alias 1.="cd .."
alias 2.="cd ../.."
alias 3.="cd ../../.."
alias 4.="cd ../../../.."
alias 5.="cd ../../../../.."

# use -G instead of --color for Mac OS X built-in ls utility
alias l="ls --color"
alias la="ls -A --color"
alias ll="ls -lAh --color"
alias lsd='ls -lA --color | grep "^d"'
alias lsg='ls -A | grep'

alias c="clear"
alias g="git"

alias o="open"
alias oo="open ."

alias -s go=vim
alias -s py=vim
alias -s cpp=vim
alias -s c=vim
alias -s vim=vim
alias -s java=vim
alias -s rb=vim
alias -s md=vim
alias -s txt=vim
alias -s vimrc=vim
alias -s zshrc=vim
alias -s gitconfig=vim
alias -s gitignore=vim

# Anki
alias anki="/Applications/Anki.app/Contents/MacOS/Anki -b $HOME/dropbox/anki"

# update/upgrade homebrew
alias brewup="brew update; brew upgrade; brew cleanup"

# hide/show dotfiles
alias hidedot="defaults write com.apple.finder AppleShowAllFiles -bool NO && killall Finder"
alias showdot="defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder"

# hide/show all desktop icons
alias hidedesk="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesk="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# clean up LaunchServices to remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
