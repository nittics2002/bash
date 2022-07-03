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

arr1=($(seq 1 10))

#var_dump "${arr1[@]}"

arr2=("${arr1[@]}" 'A')

#echo ---contain---
#var_dump "${arr2[@]}"

arr3=("${arr1[@]}" "${arr1[@]}")

#echo ---contain---
#var_dump "${arr3[@]}"

arr4=("${arr1[@]}" $(echo {a..z}))

echo ---contain---
var_dump "${arr4[@]}"





