#!/bin/bash
#
# 軸方向を検索
#

#set -x

#
#
# @param restructed_file
# @param ...xpath
#
function lexcer()
{
    local file="$1"
    shift

    for path in "$@"
    do
        #echo "${path}"

        if [[ ${path} =~ ^/ ]]
        then
            #echo "${path}"

            tag="${path:1}"

            echo "---${tag}"

            matches="$(grep -E -i -n ^\<${tag} ${file})"

            echo "${matches}"

            echo

        fi

    done

}


file=./ddd.htm
paths="/!DOCTYPE /html /head /meta"

lexcer ${file} ${paths}




