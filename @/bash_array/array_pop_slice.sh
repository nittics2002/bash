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


arr1=($(echo {a..z}))

#echo ---dump---
#var_dump "${arr1[@]}"

#注意　「:」の後にマイナスが付く場合 空白を入れる

echo ---pop---
arr2=("${arr1[@]: -1: 1}")
echo "${#arr2[@]}"
echo
var_dump "${arr2[@]}"

echo ---minus slice---
arr3=("${arr1[@]: -5: 3}")
echo "${#arr3[@]}"
echo
var_dump "${arr3[@]}"




