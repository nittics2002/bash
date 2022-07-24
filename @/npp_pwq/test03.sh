#!/bin/bash

#set -e
set -x

#機能別関数一覧
function_list_url='https://docs.microsoft.com/ja-jp/powerquery-m/power-query-m-function-reference'


#関数抽出pattern
function_match_pattern='data-linktype="relative-path"'

current_dir=$(realpath .)

#
# ダウンロード&抽出
#
# @param url
# @param match_pattern
# @param extract_pattern
# @return
#
#function download_and_parse(){
    #curl -L "${1}" | \
    curl -L "${function_list_url}" | \
        grep -E -i "${function_match_pattern}"
        #grep -E -i 'data-linktype="relative-path"'
#}

#echo "$(download_and_parse ${function_list_url} ${function_match_pattern})"





