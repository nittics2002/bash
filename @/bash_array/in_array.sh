#!/bin/bash
#
# @param key
# @param ..array
# @return 0:true 1:false
#

key="$1"
shift

if printf '%s\n' "$@" |grep -qx "${key}"; then
    echo 0
else
    echo 1
fi

