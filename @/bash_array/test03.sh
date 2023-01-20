#!/bin/bash

function child()
{
    arr=(aaa bbb ccc)
    ( IFS=, echo "${arr[*]}" )
}

function parent()
{
    { IFS=, ; arr=$(child) ; }

    for x in "${arr[@]}"
    do
        echo "${x}"
    done
}

parent

echo xxx${IFS}xxx

exit

##########################


arr=( aaa bbb ccc ddd eee fff ggg hhh)


for (( i=0; i<"${#arr[@]}"; i++ ))
do
    echo "${arr[${i}]}"
done


exit

############

for x in "${!arr[@]}"
do
    echo "$x"
done

for x in "${!arr[*]}"
do
    echo "$x"
done




