
# prompt

precmd() {
    print -rP "%{$fg[blue]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} $(git_prompt) %{$fg[magenta]%}%~%{$reset_color%}"
}
PROMPT="› "
