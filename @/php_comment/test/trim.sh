#!/bin/bash
#
#
#
#
#set -e
#set -x

cd $(dirname $0)

src_dir=../functions
script_name=trim.test

function makeTestFile()
{
    if [[ ! -f ${script_name} ]]
    then
        cat <<EOL ${src_dir}/trim.awk >> "${script_name}"
{
    trimed=trim($0)
    trint $0
}
EOL
    fi
}

function callFunction()
{
    echo $( echo "$1" |awk -f "${script_name}" )
}

makeTestFile

declare -a data
declare -a expects

data[0]=' ABC'
expects[0]='ABC'

data[1]=' ABC '
expects[1]='ABC'

data[2]=' A BC'
expects[2]='A BC'

echo "...START"

for(( i=0; i<${#data[@]}; i++ ))
do
    #echo "${data[$i]}"
    #echo "${expects[$i]}"

    actual=$( callFunction "${data[$i]}" )

    #echo "${actual}"

    [[ ! ${actual}==${expects[$i]} ]] && echo "failure=${i}"
   
done

echo "...END"
echo
