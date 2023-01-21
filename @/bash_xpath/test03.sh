#!/bin/bash
#
# xpath式parse 
#


#
# @param string &xpath
# @param int &token_position
# @return int moved_token_position
#
function parse_node()
{
    local -n xpath="$1"
    local -n token_position="$2"
    local -a tokens

    while 1
    do
        if [[ -z ${xpath:$1:1} ]]
            echo "${tokens[@]}"
            return 0
        fi

        if [[ ${xpath:$1:1} =~ [A-Za-z1-6*

    done

    echo "${tokens[@]}"
    return 0
}





function xpath_parse()
{
    local -i i
    local -i node=0
    local -a tokens
    local -i token_position

    for (( i=0; i<${#1}; i++ ))
    do
        #echo "${1:$i:1}"

        case "${1:$i:1}" in
            /)
                node+=1
                ;;





    done
}

in=abcdefg

xpath_parse "$in"


