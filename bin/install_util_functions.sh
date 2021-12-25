backup_file () {
  filename=$1
  if [ ${filename:0:1} != "/" ]; then
    echo "[WARN] Can backup with absolute path only. ${filename} is invalid."
    return
  fi

  if [ -f "${filename}" ]; then
    echo "Save file ${filename} to ${dotfiles}/backup${filename}."
    mkdir -p "${dotfiles}/backup$(dirname ${filename})"
    cp "${filename}" "${dotfiles}/backup${filename}"
  else
    echo "[WARN] File ${filename} does not exist."
  fi
}

backup_and_link_files_from_directory () {
  target_dir=$1
  link_dir=$2

  echo "Linking files from directory ${target_dir} to ${link_dir}."
  files=$(find ${target_dir} -maxdepth 1 -type f -printf "%f\n")
  for file in ${files}; do
    backup_file "${link_dir}/${file}"
    rm -f "${link_dir}/${file}"
    echo "Link ${target_dir}/${file} to ${link_dir}/${file}."
    ln -s "${target_dir}/${file}" "${link_dir}/${file}"
  done
}

link_dirs () {
  for target_dir in ${!dirs_to_link[@]}; do
    if [ -d ${target_dir} ]; then
      link_dir=${dirs_to_link[${target_dir}]}
      backup_and_link_files_from_directory ${target_dir} ${link_dir}
    else
      echo "[WARN] Can not link ${target_dir} as it does not exist."
    fi
  done
}
