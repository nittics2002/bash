#!/bin/bash

#set -e
#set -x

current_dir=$(realpath .)

#機能別関数一覧
url='https://docs.microsoft.com/ja-jp/powerquery-m/power-query-m-function-reference'

curl -L --no-progress-meter "${url}" | \
    sed -n -r '/<li><a\s+.+data-linktype="relative-path"/p' | \
    sed -r 's/^.*href="(.+)"\s+data-link.+$/\1/g' | \
    while read x
    do
        url2="https://docs.microsoft.com/ja-jp/powerquery-m/${x}"
        curl -L --no-progress-meter "${url2}" | \
            sed -n -r '/<td><a\s+.+data-linktype="relative-path"/p' | \
            sed -r 's/^.*href="(.+)"\s+data-link.+$/\1/g'
    done







