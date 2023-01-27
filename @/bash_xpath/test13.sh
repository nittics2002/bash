#!/bin/bash
#
#
#

#set -x


function lexcer()
{

    for path in "$@"
    do
        echo "${path}"

    done

}


paths="/foo /bar /baz"

lexcer ${paths}




