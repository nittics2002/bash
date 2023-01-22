#!/bin/bash
#
# xpath式parse 
#

function split_path()
{
    local -a tokens=()
    local stack
    local -i i

    for (( i=0; i<${#1}; i++ ))
    do
        ch="${1:$i:1}"
        
        if [[ ${i} -eq 0 ]]
        then
            stack="${ch}"
        elif [[ ${ch} == / ]]
        then
            tokens+=( "${stack}" )
            stack="${ch}"
        else
            stack+="${ch}"
        fi
    done

    tokens+=( "${stack}" )

    echo "${tokens[@]}"
}

in='/abc/def//gfi[text()="ABC"]'

paths=$(split_path "$in")





echo "${paths[@]}"






