
# .zshrc

for file in $HOME/.zsh/{profile,options,functions,exports,path,misc,prompt,aliases}; do
    [ -r "$file" ] && source "$file"
done
unset file
