#!/bin/bash
mode="desktop"
dotfiles="${HOME}/workspace/util/dotfiles"
declare -A dirs_to_link=(
  ["${dotfiles}/profiles"]="${HOME}"
  ["${dotfiles}/home-bin"]="${HOME}/bin"
  ["${dotfiles}/.config/i3"]="${HOME}/.config/i3"
) 
. "${dotfiles}/bin/install_util_functions.sh"

install_dependencies () {
  sudo apt install -y vim lolcat mlocate mc
  if [ ${mode} == "desktop" ]; then
    sudo apt install -y vim i3blocks fonts-font-awesome compton clipit feh authbind gparted

    sudo touch /etc/authbind/byport/80
    sudo chmod 500 /etc/authbind/byport/80
    sudo chown sandorf /etc/authbind/byport/80    
  fi
}

set_configuration () {
  sudo snap set system refresh.retain=2
}

create_directories () {
  if [ ! -d "${dotfiles}/backup" ]; then mkdir "${dotfiles}/backup"; fi
  if [ ! -d "${HOME}/bin" ]; then mkdir "${HOME}/bin"; fi
}

# files without git sync
copy_files () {
  if [ ! -d "${HOME}/.vim/colors" ]; then
    mkdir -p "${HOME}/.vim/colors"
  fi
  if [ ! -f "${HOME}/.vim/colors/gruvbox.vim" ]; then
    cp "${dotfiles}/.vim/colors/gruvbox.vim" "${HOME}/.vim/colors/gruvbox.vim"
  fi
  if [ ! -f "${HOME}/.vim/.vimrc.less" ]; then
    cp "${dotfiles}/.vim/.vimrc.less" "${HOME}/.vim/.vimrc.less"
  fi
  if [ ! -f "${HOME}/.config/welcome.message" ]; then
    echo "Repleace welcome message at \"${HOME}/.config/welcome.message\"." > "${HOME}/.config/welcome.message"
  fi
  if [ ${mode} == "desktop" ]; then
    if [ ! -f "${HOME}/Pictures/wallpaper.jpg" ]; then
      cp "${dotfiles}/Pictures/wallpaper.jpg" "${HOME}/Pictures/wallpaper.jpg"
    fi
  fi
}

install_dependencies
set_configuration
create_directories
copy_files

link_dirs
