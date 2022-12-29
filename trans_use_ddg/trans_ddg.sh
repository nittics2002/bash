#!/bin/bash
#
# DuckDuckGo翻訳を使う
#
#trans_ddg.sh [-f jp] file
#
# @example
# trans_ddg.sh <<EOL
#  A history is GA loving for me!
#  Do you have a book?
#  Please lend me.
#EOL
#
#

set -e
#set -x

cd "$(cd $(dirname ${BASH_SOURCE[0]:-}); pwd)"

while getopts f: opt
do
    case "${opt}" in
        f)
            if [[ ${OPTARG,,[A-Z]} == ja ]] ;
            then
                from_lang=${OPTARG,,[A-Z]}
            fi
            ;;
    esac
done

to_lang=ja

if [[ -n $from_lang ]] ;
then
    to_lang=en
fi

target_text=

while read -p "変換文字列入力:" line
do
    target_text+="$line. "
done

echo

#翻訳ページURL
base_url='https://duckduckgo.com/'

#queryパラメータ
query_parameter="翻訳　slow"

#token取得
result="$(curl --silent ${base_url}?q=${query_parameter})"

[[ -z $result ]] && echo "token get request error" && exit 11

vqd=$(echo ${result} | \
    sed -E \
    -e "s/^(.+)vqd=(.+)/\2/" \
    -e "s/(.+)(&p_ent.+)/\1/" \
)

[[ -z $vqd ]] && echo "token get error" && exit 11

#翻訳URL
url="${base_url}translation.js?vqd=${vqd}&query=${query_parameter}&to=${to_lang}"

if [[ -z $target_text ]] ; then
  cat <<-'EOL'

trans_ddg.sh [-f jp] file

 -f jp 日本語から英語に変換
  file 変換する文字列

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
        |sed -E -e 's/\{"detected_language":.+,"translated":"//g' \
            -e 's/"}//' \
    )

    echo -e "$result"
done

