#!/bin/bash
#
# DuckDuckGo翻訳を使う
#

set -e
#set -x

if [[ $1 == --help ]] ; then
  cat <<-'EOL'

trans_ddg.sh [OPTIONS] 標準入力

 OPTIONS
  -f LANG
    LANGから日本語変換
    LANG:enなど
　-j
    日本語から英語に変換

 trans_ddg.sh <<EOL
 >this is
 >a pen
 >EOL

 ヒアストリング
 trans_ddg.sh <<< 'this is a pen'

 ファイル
 cat FILE |trans_ddg.sh
 trans_ddg.sh <FILE

EOL
  exit 1
fi

cd "$(cd $(dirname ${BASH_SOURCE[0]:-}); pwd)"

from_lang=en
to_lang=ja

while getopts f:j opt
do
    case "${opt}" in
        f)
            from_lang=${OPTARG,,[A-Z]}
            shift 2
            ;;
        j)
            from_lang=ja
            to_lang=en
            shift
            ;;
    esac
done

tmp_file=$(mktemp)
target_text=

if [[ -r $1 ]] ; then
    cat $1 |while read line
    do
        echo "${line}" \
            |sed -E 's/([^0-9])[.]([^0-9])/\1.\n\2/g' \
            >> "${tmp_file}"
    done < "$1"
else
    cat $1 |while read line
    do
        echo "${line}" \
            |sed -E 's/([^0-9])[.]([^0-9])/\1.\n\2/g' \
            >> "${tmp_file}"
    done
fi

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

#翻訳
function trans
{
    result=$(curl \
            -X POST \
            -s \
            -d "$(cat $1)" \
            "$url" \
        |sed -E -e 's/\{"detected_language":.+,"translated":"//g' \
            -e 's/"}//' \
    )

    echo -e "$result" |sed -E 's/。/。\n/g'

}

declare -i trans_max_length=500
declare -i trans_length=0
trans_data=$(mktemp)

while read line
do
    trans_length+=${#line}
    echo "${line}" >> "${trans_data}"

    if [[ ${line:-1,1} == \. ]] || \
        [[ ${trans_length} -ge ${trans_max_length} ]]
    then
        trans "${trans_data}"
        trans_length=0
        :>"${trans_data}"
    fi

done < "${tmp_file}"

trans "${trans_data}"



