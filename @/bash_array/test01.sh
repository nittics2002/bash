#!/bin/bash

set -e
#set -x

#####
# var_dump
#####
function var_dump(){
    local x
    for x in "$@";
    do
        echo "${x}"
    done

    echo
}

#
#
#
#
function split() {
echo "${1}" | \
    sed -r -e "s|${2}|\n|g" | \
    sed -r -e "s|(.*)|'\1'|g"
}

file_path='http://aaa/bbb/ccc/ddd/eee.fff?ggg=hhh&iii=jjj'

arr=($(split "$file_path" "/" ))

echo "${#arr[@]}"

var_dump "${arr[@]}"



