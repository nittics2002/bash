#!/bin/bash

[[ $# -ne 1  || ! -f $1 ]] && cat <<EOL && exit 1

usage
    add_comment FILE

EOL

cat "$1" |awk -- '
{
    print $0;
}
'




echo AAAAAAa


