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

# source TD stuff
if [ -d "${HOME}/workspace/util/dotfiles_topdesk" ]; then
  source_profiles_from "${HOME}/workspace/util/dotfiles_topdesk"
fi