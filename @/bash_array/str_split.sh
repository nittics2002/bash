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

#
#
#
#
function str_split() {
echo "${1}" | \
    sed -r -e "s|${2}|\n|g" | \
    sed -r -e "s|(.*)|'\1'|g"
}


[[ $# != 2 ]] && cat <<EOL && exit 11

str_split file regex

EOL

#[[ $# != 2 ]] && cat <<<'
#
#split file regex
#
#' && exit 11

echo "target=${1}"
echo "pattern=${2}"

arr=($(str_split "${1}" "${2}" ))

echo "split count=${#arr[@]}"

echo --------------------
var_dump "${arr[@]}"
echo --------------------


