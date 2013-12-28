
# .zshrc

for file in $HOME/.zsh/{options,functions,exports,path,misc,prompt,aliases}.zsh; do
    [ -r "$file" ] && source "$file"
done
unset file
