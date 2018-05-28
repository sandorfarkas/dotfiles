#!/bin/bash

export DOTFILES=${HOME}/workspace/lab/.dotfiles
export DOTFILES_TD=${HOME}/workspace/lab/.dotfiles_td

if [ -L .alias ]; then
  mv .alias .alias.old
fi
ln -s $DOTFILES/.alias .alias

if [ -L .alias_td ]; then
 mv .alias_td .alias_td.old
fi
ln -s $DOTFILES_TD/.alias .alias_td

if [ -L .env ]; then
  mv .env .env.old
fi
ln -s $DOTFILES/.env .env

if [ -L .env_td ]; then
  mv .env_td .env_td.old
fi
ln -s $DOTFILES_TD/.env .env_td

if [ -L .bashrc ]; then
  mv .bashrc .bashrc.old
fi
ln -s $DOTFILES/.bashrc .bashrc

if [ -L .prompt ]; then
  mv .prompt .prompt.old
fi
ln -s $DOTFILES/.prompt .prompt

if [ -L .functions ]; then
  mv .functions .functions.old
fi
ln -s $DOTFILES/.functions .functions

if [ -L .tmux.conf ]; then
  mv .tmux.conf .tmux.conf.old
fi
ln -s $DOTFILES/.tmux.conf .tmux.conf

if [ -L .vimrc ]; then
  mv .vimrc .vimrc.old
fi
ln -s $DOTFILES/.vimrc .vimrc
