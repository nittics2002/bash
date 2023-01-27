#!/bin/bash
#
# 標準入力の<を改行,空行を削除,コメント削除
#

declare in_comment

sed -E -e 's/</\n</g' | \
    sed -E -e '/^$/d' | \
    sed -E -e '/^\s+$/d' |
    while read line
    do
        if [[ -z ${in_comment} ]] && [[ ${line} =~ ^\<\!\-\- ]]
        then
            in_comment=1
        elif [[ -n ${in_comment} ]] && [[ ${line} =~ \-\-\> ]]
        then
            in_comment=
        elif [[ -n ${in_comment} ]]
        then
            :
        else
            echo "${line}"
        fi
    done

