#!/bin/bash
#
# xpath式parse 
#

function split_path()
{
    local -a tokens=()
    local stack
    local inClosure
    local -i i

    for (( i=0; i<${#1}; i++ ))
    do
        ch="${1:$i:1}"
        
        if [[ ${i} -eq 0 ]]
        then
            stack="${ch}"
        elif [[ -z ${inClosure} ]] && [[ ${ch} == '"' ]]
        then
            inClosure=t
            stack+="${ch}"
        elif [[ ${ch} == '"' ]]
        then
            inClosure=
            stack+="${ch}"
        elif [[ -z ${inClosure} ]] && [[ ${ch} == / ]]
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

function split_axis()
{
    local -a tokens=()
    local stack
    local -i i

    for path in "$@"
    do
        for ((i=0; i<${#path}; i++))
        do
            ch="${path:$i:1}"
            
            if [[ ${i} -eq 0 ]]
            then
                stack="${ch}"
            elif [[ -z ${inClosure} ]] && [[ ${ch} == '"' ]]
            then
                inClosure=t
                stack+="${ch}"
            elif [[ ${ch} == '"' ]]
            then
                inClosure=
                stack+="${ch}"
            elif [[ -z ${inClosure} ]] && [[ ${ch} == : ]] && [[ ${path:$i+1:1} == : ]]
            then
                tokens+=( "${stack}" )
                stack="${ch}${ch}"
                (( i++ ))
            else
                stack+="${ch}"
            fi
        done
    done

    tokens+=( "${stack}" )

    echo "${tokens[@]}"
}

function main()
{

    in='/abc/def::ghi//jkl[text()="ABC/DEF::GHI[JKL]MNO(PQR)STU=VWX"]'

    path=$(split_path "$in")

    #echo "${paths}"

    axis=$(split_axis "$path")

    echo "${axis}"


}


main



