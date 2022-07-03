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

arr4=($(echo {a..z}))

echo ---contain---
var_dump "${arr4[@]}"





