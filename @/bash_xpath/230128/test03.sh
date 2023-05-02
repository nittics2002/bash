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
    #local -n tokens1="$1"
    #local -n xpath="$2"
    #local -n token_position="$3"

echo "$1"

return 0


    while 1
    do
        if [[ -z ${xpath:$1:1} ]]
        then
            #echo "${tokens[@]}"
            return 0
        fi

        if [[ ${xpath:$1:1} =~ [A-Za-z0-9*] ]]
        then
            tokens+=( ${xpath:$1:1} )
        else
            break
        fi
    done

    #echo "${tokens[@]}"
    return 0
}





function xpath_parse()
{
    local -i i
    local -i node=0
    local -a tokens
    local -i token_position

    local xpath="$1"

    #for (( i=0; i<${#1}; i++ ))
    for (( i=0; i<${#xpath}; i++ ))
    do
        #echo "${1:$i:1}"

#        case "${1:$i:1}" in
#            /)
#                node+=1
#                ;;

        #ch="${1:$i:1}"

        parse_node tokens xpath i


        echo "${tokens[@]}"

    done

    echo -----last
    echo "${tokens[@]}"


}

in='/abc/def//gfi[text()="ABC"]'

xpath_parse "$in"


