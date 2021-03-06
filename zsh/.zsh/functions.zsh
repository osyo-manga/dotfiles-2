
# functions

# create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@"
}

# automatically activate virtualenv. Thanks to Kenneth Reitz!
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

# Thanks to http://ianloic.com/2011/06/25/git-zsh-prompt
git_prompt() {
    local DIRTY="%{$fg[yellow]%}"
    local CLEAN="%{$fg[green]%}"
    local UNMERGED="%{$fg[red]%}"
    local RESET="%{$terminfo[sgr0]%}"
    git rev-parse --git-dir >& /dev/null
    if [[ $? == 0 ]]
    then
        echo -n "("
        if [[ `git ls-files -u >& /dev/null` == '' ]]
        then
            git diff --quiet >& /dev/null
            if [[ $? == 1 ]]
            then
                echo -n $DIRTY
            else
                git diff --cached --quiet >& /dev/null
                if [[ $? == 1 ]]
                then
                    echo -n $DIRTY
                else
                    echo -n $CLEAN
                fi
            fi
        else
            echo -n $UNMERGED
        fi
        echo -n `git branch | grep '* ' | sed 's/..//'`
        echo -n $RESET
        echo -n ")"
    fi
}
