#!/bin/bash

#set -e
set -x

current_dir=$(realpath .)

#
# ダウンロード&抽出
#
# @param url
# @param xpath
# @return
#
function download_and_parse(){
    curl -L "${1}" | \
        xmllint --html --c14n - #| \
        #xmllint --html --xpath "${2}" -
}

#機能別関数一覧
function_list_url='https://docs.microsoft.com/ja-jp/powerquery-m/power-query-m-func'

#関数抽出xpath
function_xpath='//li/a[@data-linktype="relative-path"]'

echo "$(download_and_parse ${function_list_url} ${function_xpath})"






