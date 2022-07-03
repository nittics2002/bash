#!/bin/bash

#set -e
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
}


#echo ---contain---
#var_dump "${arr3[@]}"

arr1=($(echo {a..z}))

#echo ---dump---
#var_dump "${arr1[@]}"

echo ---slice---
arr2=("${arr1[@]:3:8}")
echo "${#arr2[@]}"
echo
var_dump "${arr2[@]}"




