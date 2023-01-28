#!/bin/bash
#
# 省略構文=>完全構文
#

#set -x

declare axis_syntax=( child descendant parent ancestor self )
declare -A abbreviated_full 

#abbreviated_full[.]=self
#abbreviated_full[..]=parent
#abbreviated_full[.]=self

#
#
# @param array
# @param value
# @return int
# @output int
#
function in_array
{
    for value in "$@"
    do
        [[ ${value} == $2 ]] && echo 0 && exit 0
    done

    echo 1
    exit 0
}

#
#
# @param paths
# @param path
#
function abbreviate_to_full_syntax()
{
    
    if [[ $2 == . ]]
    then





}

function main
{

    for path in "$@"
    do

        echo "${path}"



    done


}

paths=( /abc /. /.. /child ::def /parent ::ghi /jkl ) 

abbreviate_to_full_syntax "${paths[@]}"


