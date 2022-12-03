#!/bin/bash
#
# Excite翻訳を使う
#
# @example
# cat <<EOL |xargs -0 ./trans_use_excite.sh EN JA
#  A history is GA loving for me!
#  Do you have a book?
#  Please lend me.
#EOL
#
#

set -e
#set -x

cd $(dirname "$0")

#EXCITE翻訳ページURL
excite_url=https://www.excite.co.jp/world/english/

if [[ $# != 3 ]] ; then
  cat <<-'EOL'

trans_use_excite.sh $before_lang $after_lang $text

  $before_lang 変換前言語
  $after_lang 変換後言語
  $text 変換する文字列

EOL
  exit 1
fi

#temp file
cookie_file_path=$(mktemp)
excite_page=$(mktemp)

#POSTデータ
post_data=$(cat <<EOL2 |tr -d "\n"
auto_detect_flg=0
&auto_detect=on
&before_lang=$1
&after_lang=$2
&before=$3
EOL2
)

#POST翻訳データ
curl -c "$cookie_file_path" \
  -b $cookie_file_path \
  -o "$excite_page" \
  -s \
  -XPOST --data "$post_data" \
  "$excite_url" 

#翻訳結果を抽出
#翻訳した文字列 #id="after"

cat "$excite_page" \
  |sed -r -n -e '/id="after"/p' \
  |perl -p -e 's/<textarea.+(?<=>)(.*)<\/textarea>/\1/' \
  |sed -r -e 's/^\s+//' -e 's/&#010;/ /g' 

