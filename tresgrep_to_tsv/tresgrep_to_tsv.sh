#!/bin/bash
#
# テキストファイルの正規表現で指定したキーワード以降の
#   データを抽出する
#
# @param $1 キーワード(egrep正規表現)
# @param $2 テキストファイル
# @return 文字列
#

set -e
#set -x

if [[ $# != 2 ]] ; then
 cat <<-'_USAGE'
  # テキストファイルの正規表現で指定したキーワード以降の
  #   データを抽出する
  
  tresgrep_to_tsv.sh $1 $2
    @param $1 キーワード(egrep正規表現)
    @param $2 テキストファイル
    @return 文字列

_USAGE
  exit 1
fi

utf8_file=$(mktemp --suffix=_tresgrep)

iconv -f UCS-2LE -t UTF-8 "$2" > "$utf8_file"

line_no="$(grep -n -E $1 $utf8_file | cut -d ':' -f 1)"

[[ -z $line_no ]] && echo 'keyword not found' && exit 1

sed -n -e "$line_no",+"$(wc -l $utf8_file |cut -d ' ' -f 1)"p "$utf8_file" | \
    iconv -f UTF-8 -t CP932

[[ $? == 0 ]] && trap "rm -f $utf8_file" EXIT

