#!/bin/bash
dotfiles="${HOME}/workspace/dotfiles"
if [ ! -d "${dotfiles}/backup" ]; then mkdir "${dotfiles}/backup"; fi

# if directory name contains _ it will be used as environment suffix
declare -a profile_dirs=(
  "${dotfiles}/profiles"
) 

# @param $1 filename
backup_file () {
  filename=$1
 
  if [ -e "${HOME}/${filename}" ]; then
    echo "Backing up ${HOME}/${filename} to ${dotfiles}/backup/${filename}.old"
    mv "${HOME}/${filename}" "${dotfiles}/backup/${filename}.old"
  fi
}

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

# @param $1 directory of profile files
linking_profiles_from_directory () {
  profile_dir=$1
  echo "Linking profiles from directory ${profile_dir}"

  files=$(find $profile_dir -maxdepth 1 -type f -printf "%f\n")
  for filename in $files; do
    link_file $profile_dir $filename
  done
}

loop_profile_dirs () {
  for profile_dir in ${profile_dirs[@]}; do
    if [ -d $profile_dir ]; then
      linking_profiles_from_directory "${profile_dir}"
    fi
  done
}

copy_files () {
  if [ ! -d "${HOME}/.vim/colors" ]; then
    mkdir -p "${HOME}/.vim/colors"
  fi
  if [ ! -e "${HOME}/.vim/colors/gruvbox.vim" ]; then
    cp "${dotfiles}/.vim/colors/gruvbox.vim" "${HOME}/.vim/colors/gruvbox.vim"
  fi
}

loop_profile_dirs
copy_files

