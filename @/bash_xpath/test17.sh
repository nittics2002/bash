#!/bin/bash
#
# 省略構文=>完全構文
#

#set -x

declare axis_syntax=( child descendant parent ancestor self )
declare -A abbreviated_full 

#abbreviated_full[.]=self
#abbreviated_full[..]=parent
#abbreviated_full[.]=self

function abbreviate_to_full_syntax()
{

    for path in "$@"
    do

        echo "${path}"

    done


}

paths=( /abc /. /.. /child ::def /parent ::ghi /jkl ) 

abbreviate_to_full_syntax "${paths[@]}"


