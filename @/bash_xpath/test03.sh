#!/bin/bash
#
#   array
#
#

aaa=( aaa bbb ccc ddd )

#for x in "${aaa[@]}" ;
#do
#    echo "${x}"
#done
#
#echo "${aaa[@]}" |xargs -n 1  echo

function destruct()
{
    declare -n argv=$1

    echo "${argv[@]}" |xargs -n 1  echo
}

set -x

destruct aaa





