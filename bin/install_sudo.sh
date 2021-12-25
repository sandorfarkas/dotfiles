#!/bin/bash
echo "Enter the user of dotfiles:"
read user_name
dotfiles="/home/${user_name}/workspace/util/dotfiles"

declare -A dirs_to_link=(
  ["${dotfiles}/i3blocks"]="/usr/share/i3blocks"
)
. "${dotfiles}/bin/install_util_functions.sh"


link_files_with_sudo () {
  backup_file "/etc/i3blocks.conf"
  rm -f "/etc/i3blocks.conf"
  echo "Link ${dotfiles}/etc/i3blocks.conf to /etc/i3blocks.conf."
  ln -s "${dotfiles}/etc/i3blocks.conf" "/etc/i3blocks.conf"
}

link_dirs
link_files_with_sudo
