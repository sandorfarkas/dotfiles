#!/bin/bash

# if directory name contains _ it will be used as environment suffix
declare -a profile_dirs=(
  "${HOME}/workspace/lab/dotfiles/profiles"
) 

# @param $1 dir
# @param $2 filename
link_file () {
  target_filename="${1}/${2}"
  link_filename="${HOME}/${2}"
  
  if [ -f $link_filename ]; then
    echo "Backing up ${link_filename} to ${link_filename}.old"
    mv "${link_filename}" "${link_filename}.old"
  fi
  ln -s "${target_filename}" "${link_filename}" 
}

# @param $1 directory of profile files
linking_profiles_from_directory () {
  files=$(find $1 -maxdepth 1 -type f -printf "%f\n")
  for filename in $files; do
    link_file $1 $filename
  done
}

loop_profile_dirs () {
  for profile_dir in ${profile_dirs[@]}; do
    if [ -d $profile_dir ]; then
      echo "Linking profiles from directory ${profile_dir}"
      linking_profiles_from_directory "${profile_dir}"
    fi
  done
}

loop_profile_dirs

