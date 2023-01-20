#!/bin/bash
#
#   関数の引数にarrayを渡す(リファレンス渡し)
#
#

aaa=( aaa bbb ccc ddd )

function destruct()
{
    declare -n argv=$1

    echo "${argv[@]}" |xargs -n 1  echo
}

destruct aaa





