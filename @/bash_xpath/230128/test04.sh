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
    if [[ $1 =~ [A-Za-z0-9*] ]]
    then
       break 
    else
        break
    fi

}





function xpath_parse()
{
    local -i i
    local -i node=0
    local bracket
    
    local axis #軸
    local ntest #node test
    local predicate #述語
    
    local nspace #名前空間
    local dcolon #doubleコロン
    local amark #@mark


    local -a tokens
    local -i pos=0

    local xpath="$1"

    #for (( i=0; i<${#1}; i++ ))
    for (( i=0; i<${#xpath}; i++ ))
    do
        #echo "${1:$i:1}"

        ch="${1:$i:1}"

        if [[ node -lt 2 -a -z braket -a ch =~ / ]]
        then
            node+=1
            tokens[${pos}]+=${ch}
        elif [[ -z bracket -a ch == [ ]]
        then
            bracket=t
            node=0
            pos++
            tokens[${pos}]+=${ch}




        fi

    done

    echo -----last
    echo "${tokens[@]}"


}

in='/abc/def//gfi[text()="ABC"]'

xpath_parse "$in"


