#!/bin/bash
#
#
#

#set -x


function lexcer()
{

    file=./ddd.htm


    for path in "$@"
    do
        #echo "${path}"

        if [[ ${path} =~ ^/ ]]
        then
            #echo "${path}"

            tag="${path:1}"

            echo "---${tag}"

            matches="$(grep -E -i ^\<${tag} ${file})"

            echo "${matches}"

            echo

        fi

    done

}


paths="/!DOCTYPE /html /head"

lexcer ${paths}




