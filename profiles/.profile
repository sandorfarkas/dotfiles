# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	   . "$HOME/.bashrc"
    fi
fi

if [ -f "$HOME/.env" ]; then
  . "$HOME/.env"
fi

if [ -f "$HOME/bin/fehbg" ]; then
  . "$HOME/bin/fehbg"
fi

if [ -n "$DOTFILES_TOPDESK" ]; then
    if [ -f "$DOTFILES_TOPDESK/.env" ]; then
        . "$DOTFILES_TOPDESK/.env"
    fi
fi
