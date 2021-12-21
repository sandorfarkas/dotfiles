#!/bin/bash
dotfiles="${HOME}/workspace/util/dotfiles"
mode="desktop"

# if directory name contains _ it will be used as environment suffix
declare -a profile_dirs=(
  "${dotfiles}/profiles"
) 

# @function backup_file
# @param $1 filename
backup_file () {
  filename=$1
 
  if [ -e "${HOME}/${filename}" ]; then
    echo "Backing up ${HOME}/${filename} to ${dotfiles}/backup/${filename}.old"
    mv "${HOME}/${filename}" "${dotfiles}/backup/${filename}.old"
  fi
}

# @function link_file
# @description creates soft link for file in ${HOME} with the same filename
# @param $1 dir
# @param $2 filename
link_file () {
  dir=$1
  filename=$2

  target_filename="${dir}/${filename}"
  link_filename="${HOME}/${filename}"

  backup_file "${filename}"

  ln -s "${target_filename}" "${link_filename}" 
}

# @function link_profiles_from_directory
# @param $1 directory of profile files
link_profiles_from_directory () {
  profile_dir=$1
  echo "Linking profiles from directory ${profile_dir}"

  files=$(find $profile_dir -maxdepth 1 -type f -printf "%f\n")
  for filename in $files; do
    link_file $profile_dir $filename
  done
}

loop_and_link_profile_dirs () {
  for profile_dir in ${profile_dirs[@]}; do
    if [ -d $profile_dir ]; then
      link_profiles_from_directory "${profile_dir}"
    fi
  done
}

install_dependencies () {
  sudo apt install -y vim lolcat mlocate mc
  if [ ${mode} == "desktop" ]; then
    sudo apt install -y i3blocks fonts-font-awesome compton clipit feh authbind gparted

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

copy_files () {
  if [ ! -d "${HOME}/.vim/colors" ]; then
    mkdir -p "${HOME}/.vim/colors"
  fi
  if [ ! -e "${HOME}/.vim/colors/gruvbox.vim" ]; then
    cp "${dotfiles}/.vim/colors/gruvbox.vim" "${HOME}/.vim/colors/gruvbox.vim"
  fi
  if [ ! -e "${HOME}/.config/welcome.message" ]; then
    echo "Repleace welcome message at ${HOME}/.config/welcome.message" > "${HOME}/.config/welcome.message"
  fi
  cp -r ${dotfiles}/home-bin/* ${HOME}/bin
  cp -r ${dotfiles}/home-bin/.* ${HOME}/bin

  if [ ${mode} == "desktop" ]; then
    if [ ! -e "${HOME}/Pictures/wallpaper.jpg" ]; then
      cp "${dotfiles}/Pictures/wallpaper.jpg" "${HOME}/Pictures/wallpaper.jpg"
    fi
  fi
}

install_dependencies
set_configuration
create_directories
copy_files
loop_and_link_profile_dirs

