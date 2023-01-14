#!/bin/bash

#set -x

source var_dump.sh

echo $$

function child()
{
    echo $$
    sleep 10
    echo child
}


( child )


echo END!!!!!!!!!

