
# .zshrc

for file in $HOME/.zsh/{profile,path,misc,prompt,exports,aliases,functions,options}; do
    [ -r "$file" ] && source "$file"
done
unset file
