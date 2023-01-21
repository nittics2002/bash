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
    local -n _tokens="$1"
    local -n _xpath="$2"
    local -n _i="$3"
    local -n _pos="$4"
   
    while true
        ch="${_xpath:${_i}:1}"
        
        if [[ -z ${ch} ]]
        then
           return 1 #xpathを最終までスキャン
        fi



        if [[ $1 =~ [A-Za-z0-9*] ]]
        then
            _token[${_pos}]+=
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

    for (( i=0; i<${#xpath}; i++ ))
    do

        #echo "${1:$i:1}"

        #ch="${1:$i:1}"

        parse_node tokens xpath i pos

        echo "${ret}"


}

in='/abc/def//gfi[text()="ABC"]'

xpath_parse "$in"


