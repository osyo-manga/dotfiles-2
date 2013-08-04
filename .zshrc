
# .zshrc

for file in `dirname $(readlink $HOME/.zshrc)`/.zsh/{profile,path,misc,prompt,exports,aliases,functions,options}; do
    [ -r "$file" ] && source "$file"
done
unset file
