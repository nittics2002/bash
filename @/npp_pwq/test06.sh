#!/bin/bash

#set -e
#set -x

current_dir=$(realpath .)

#機能別関数一覧
url='https://docs.microsoft.com/ja-jp/powerquery-m/power-query-m-function-reference'

curl -L --no-progress-meter "${url}" | \
    sed -n '/data-linktype="relative-path"/p' | \
    sed -n '/<li>/p'






