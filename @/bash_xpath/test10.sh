#!/bin/bash
#
# 段落調査 
#
# 1行tagで終了記号 /> が無いtagの文ずれる
#

#set -x

#空tag
void_elements=( area base br col embd hr img input link meta source track wbr )


#
# 空tag判定
#
# @param 
#
function is_void_element()
{
    local pattern

    for x in "${void_elements[@]}"
    do
        pattern=^\<${x}

        [[ $1 =~ ${pattern} ]] && echo && return 0
    done

    echo false
    return 1
}

declare -i indent=1

tac | while read line
do
    #echo "${line}"
    
    #終了tag
    if [[ ${line} =~ ^\</[A-Za-z0-9]+\> ]]
    then

        echo "${indent}"
        echo "${line}"
        echo
        (( indent++ ))

    #空tag
    elif [[ -z $(is_void_element ${line}) ]]
    then

        echo "${indent}"
        echo "${line}"
        echo


    #開始tag
    elif [[ ${line} =~ ^\<[A-Za-z0-9]+.*/\> ]]
    then

        echo "${indent}"
        echo "${line}"
        echo

    #1行tag
    elif [[ ${line} =~ ^\<[A-Za-z0-9]+.*\> ]]
    then

        echo "${indent}"
        echo "${line}"
        echo
        (( indent-- ))

    #その他
    else

        echo "${indent}"
        echo "${line}"
        echo

    fi



done






