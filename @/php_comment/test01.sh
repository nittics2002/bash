#!/bin/bash

[[ $# -ne 1  || ! -f $1 ]] && cat <<EOL && echo AAA && exit 1

usage
    add_comment FILE

EOL

echo BBBBBBBBBBBBBBBBBB

exit 0


