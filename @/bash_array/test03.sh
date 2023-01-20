#!/bin/bash
#
#   関数の引数にarrayを渡す(リファレンス渡し)
#
#

function child()
{
    declare -n argv=$1

    echo "${argv[@]}" |xargs -n 1  echo
}

function parent()
{

    local aaa=( aaa bbb ccc ddd )
    child aaa
}

parent



