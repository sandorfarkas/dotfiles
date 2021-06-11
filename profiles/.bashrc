verbose="false"
say () {
  if [ $verbose = "true" ]; then
    echo $1
  fi
}

source_profiles_from () {
  if [ ! -d "$1" ]; then return; fi

  files=$(find $1 -maxdepth 1 -type f -printf "%f\n")
  for filename in $files; do
    source "${1}/${filename}"
  done
}

say "Sourcing .bashrc"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source environment variables
if [ -f ~/.env ]; then
  say "Sourcing .env"
  . ~/.env
else
  say "No .env found"
fi

# source TD functions
if [ -f ~/.functions ]; then
  say "Sourcing .functions"
  . ~/.functions
else
  say "No .functions found"
fi

# source prompt
if [ -f ~/.prompt ]; then
  say "Sourcing .prompt"
  . ~/.prompt
else
  say "No .prompt found"
fi

# source aliases
if [ -f ~/.alias ]; then
  say "Sourcing .alias"
  . ~/.alias
else
  say "No .alias found"
fi

# source TD stuff
source_profiles_from "${HOME}/workspace/lab/dotfiles_topdesk"

# welcome message
if [ -f $HOME/.config/welcome.message ]; then
  cat $HOME/.config/welcome.message | lolcat-c
fi
