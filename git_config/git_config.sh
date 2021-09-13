#!/bin/bash
#
# gitローカル設定反映
#
#

set -e
set -x

###定義

readonly -A define_user_files=(
  ["nittics1991"]=~/.config/git/nittics1991/config
  ["nittics2002"]=~/.config/git/nittics2002/config
)

backup_path=~/document

###

[[ $# -ne 1 ]] && cat <<EOL && exit 1

  git-config.sh REPOSOTORY_BASE_PATH
    REPOSOTORY_BASE_PATH gitリポジトリのベースDIR

EOL

config_path="$1/.git"
config_file="${config_path}/config"

[[ ! -f ${config_file} ]] && \
  echo "config file is not found. basepath=$1" && \
  exit 1

cp --backup=numbered "${config_file}" "${backup_path}"

url="$(sed -n -e '/url/p' ${config_file})"

parts=(${url//\// })

git_user="${parts[4]}"

define_user_file="${define_user_files[$git_user]}"

[[ ! -z $user ]] && echo "git user not found" && exit 1 

cat "${define_user_file}" >> "${config_file}"

echo "SUCCESS!!"


