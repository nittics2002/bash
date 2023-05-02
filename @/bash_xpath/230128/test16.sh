#!/bin/bash
#
# 軸方向を検索
#

#set -x

declare -a absolute_axis
#declare -a relative_axis
declare -a full_syntax
declare -a node_test


#
#
# @param restructed_file
# @param ...xpath
#
function lexcer()
{
    local file="$1"
    shift
    
    local -i len

    for path in "$@"
    do


        #絶対軸
        if [[ ${#path} -gt 1 ]] && [[ ${path} =~ ^/ ]]
        then
            tag="${path:1}"
            absolute_axis+=( "$(grep -E -i -n ^\<${tag} ${file})" )

        #相対軸
        elif [[ ${path} =~ ^/ ]]
        then
            #relative_axis+=( "$(grep -E -i -n ^\<${tag} ${file})" )
            :

        #完全構文
        elif [[ ${path} =~ ^:: ]]
        then
            syntax="${path:2}"
            full_syntax+=( "$(grep -E -i -n ^\<${syntax} ${file})" )


        #ノードテスト
        elif [[ ${path} =~ ^\[ ]]
        then
            
            len=$(( ${#path} -2 ))
            test1="${path:1}"
            test2="${test1::${len}}"
            formula=$( IFS==; ar=( ${test2} ) ; echo ${ar[@]} )
            
            #関数処理必要


            node_test+=( "$(grep -E -i -n ${test2} ${file})" )

            echo "$IFS"
            echo "${formula[@]}"
            echo

        fi





    done

}


file=./ddd.htm
paths="/!DOCTYPE /html / /head /parent ::body [@id=\"pg-index\"]"

lexcer ${file} ${paths}

echo ----absolute
echo "${absolute_axis}"
echo


echo ----full syntax
echo "${full_syntax}"
echo


echo ----node_test
echo "${node_test}"
echo




