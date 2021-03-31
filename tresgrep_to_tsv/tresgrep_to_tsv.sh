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

#####main
line_no="$(cat $2 |iconv -f $(nkf -g $2) -t UTF-8 | grep -n -E "$1" | cut -d : -f 1)"

[[ "$line_no" == '' ]] && echo 'keyword not found' && exit 1

#echo "$line_no"

sed -n -e "$line_no",+"$(wc -l $2 |cut -d ' ' -f 1)"p "$2" |iconv -f $(nkf -g "$2") -t UTF-8


