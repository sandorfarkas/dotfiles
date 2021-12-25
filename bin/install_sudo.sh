#!/bin/bash
echo "Enter the user of dotfiles:"
read user_name
dotfiles="/home/${user_name}/workspace/util/dotfiles"

declare -A dirs_to_link=(
  ["${dotfiles}/i3blocks"]="/usr/share/i3blocks"
)
. "${dotfiles}/bin/install_util_functions.sh"


install_dependencies () {
  apt install -y vim lolcat mlocate mc

  if [ ${mode} == "desktop" ]; then
    apt install -y i3blocks fonts-font-awesome compton clipit feh authbind gparted lxappearance light

    touch /etc/authbind/byport/80
    chmod 500 /etc/authbind/byport/80
    chown ${user_name} /etc/authbind/byport/80
  fi
}

set_configuration () {
  snap set system refresh.retain=2
}

link_files_with_sudo () {
  backup_file "/etc/i3blocks.conf"
  rm -f "/etc/i3blocks.conf"
  echo "Link ${dotfiles}/etc/i3blocks.conf to /etc/i3blocks.conf."
  ln -s "${dotfiles}/etc/i3blocks.conf" "/etc/i3blocks.conf"
}

install_dependencies
set_configuration

link_dirs
link_files_with_sudo
