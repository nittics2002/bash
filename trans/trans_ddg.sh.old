#!/bin/bash
#
# DuckDuckGo翻訳を使う
#
# @example
# trans_x.sh <<EOL
#  A history is GA loving for me!
#  Do you have a book?
#  Please lend me.
#EOL
#
#

set -e
#set -x

cd "$(cd $(dirname ${BASH_SOURCE[0]:-}); pwd)"

target_text=

while read -p "変換文字列入力:" line
do
    target_text+="$line. "
done

echo

#翻訳ページURL
url='https://duckduckgo.com/translation.js?vqd=3-144500552568568982516478253929298182282-63357618217516674028808065029482649975&query=%E7%BF%BB%E8%A8%B3%20a&from=en&to=ja'

if [[ -z $target_text ]] ; then
  cat <<-'EOL'

trans_x.sh [text]
  text 変換する文字列

EOL
  exit 1
fi

one_line_data="$(echo -e $target_text)"

declare -i data_length="${#one_line_data}"

for (( i = 0; i < $data_length; i = i + 2000 ))
do
  post_data="${one_line_data:$i:2000}"

    result=$(curl \
        -X POST \
        -s \
        -d "$post_data" \
        "$url" \
        |sed -E -e 's/\{"detected_language":null,"translated":"//g' \
            -e 's/"}//' \
    )

    echo -e "$result"
done

