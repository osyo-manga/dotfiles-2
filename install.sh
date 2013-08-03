#!/usr/bin/env bash

# install.sh

DOTFILES=$(pwd `dirname $0`)

ln -s $DOTFILES/.zshrc $HOME/.zshrc
ln -s $DOTFILES/.ackrc $HOME/.ackrc
ln -s $DOTFILES/.ctags $HOME/.ctags
ln -s $DOTFILES/.vimrc $HOME/.vimrc
ln -s $DOTFILES/.vim $HOME/.vim
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.gitignore_global $HOME/.gitignore_global

unset DOTFILES
