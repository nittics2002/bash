#!/bin/bash
#
# 段落調査 
#
# 1行tagで終了記号 /> が無いtagの文ずれる
#

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






