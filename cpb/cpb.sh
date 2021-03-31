#!/bin/bash
#
# cpでファイル名が重複の場合、指定したsuffixを付ける
#
# cpb.sh -s suffix src dest
#   suffix:追加文字 省略時は自動
#

set -e
#set -x

declare -i argc=0
declare -a argv=()

#ファイル名suffix
suffix=.bak

while (( $# > 0 ))
do
  case $1 in
    -s)
      shift
      suffix="$1"
      ;;
    *)
      argv+=( "$1" )
      (( ++argc ))
      ;;
  esac
  shift
done

[[ "${#argv[@]}" < 1 ]] && \
  cat <<- EOL1 && exit 11
  
    suffixが指定があればバックアップ作成してコピー

    cpb.sh -s suffix src [dest]
      -s suffix:サフィックス文字

EOL1

#コピー元
src="${argv[0]}"
#コピー先
dest="${argv[1]:-}"
#destがdir
dest_is_dir=0

#destの指定が無ければsrcと同じにする
if [[ -z "$dest" ]] ;
then
  dest="$src"
#destがdirを持つ
elif [[ "$dest" =~ /.+ ]] ;
then
  dest_is_dir=1
#destがdirの場合、ファイル名をsrcと同じにする
elif [[ -d "$dest" ]] ;
then
  dest+="$(basename $src)"
  dest_is_dir=1
fi

#destが存在しない
if [[ ! -e "$dest" ]] ;
then
  suffix=
else
  #suffixファイルが存在する
  if [[ -e "$dest$suffix" ]] ;
  then
    #連番付きsuffixファイルは存在しない
    if [[ ! -e "$dest$suffix.1" ]];
    then
      suffix="$suffix.1"
    else
      regex="s/.+$suffix\\.//"

      #destがdir
      if [[ "$dest_is_dir" == 1 ]] ;
      then
        find_dir="$(dirname $dest)"
        find_file="$(basename $dest)"

        max_no="$(find $find_dir \
          -maxdepth 1 \
          -name "$find_file$suffix.[0-9]*" \
          |sed -r -e $regex \
          |sort -n \
          |sed -n '$p' \
        )"
     else
        max_no="$(find . \
          -maxdepth 1 \
          -name "$dest$suffix.[0-9]*" \
          |sed -r -e $regex \
          |sort -n \
          |sed -n '$p' \
        )"
      fi
      suffix+=".$(( ++max_no ))"
    fi
  fi
fi

echo "src=$src"
echo "dest=$dest"
echo "suffix=$suffix"

