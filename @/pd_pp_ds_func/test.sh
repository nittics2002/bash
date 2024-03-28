#!/bin/bash

#
# pushd/popd を >/dev/null としたい
# popd は 数値N で 指定したdirs +N のDIRにcdし、popd +N したい
#




#shortcut popd left entry move
function ppp()
{
    if [[ $# -ne 1 ]]
    then
        popd >/dev/null
    else
        if [[ ${1:1:1} == - ]]
        then
            pos=$1
        else
            pos="+$1"
        fi
set -x
        . cd "$(dirs ${pos})"
        
        popd $pos >/dev/null

set +x
    fi
}

ppp $1

