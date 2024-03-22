#!/bin/bash
#
# test trim.awk
#
#set -e
#set -x

cd $(dirname $0)

src_dir=../functions
original_name=trim
script_name=../tmp/trim.test

function makeTestFile()
{
cat <<'EOL' ${src_dir}/${original_name}.awk > "${script_name}"
{
    ret=trim($1)
    print "${ret}"
}
EOL
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

data[3]='A BC  '
expects[3]='A BC'

echo "...START(OK if there is no failure)"

for(( i=0; i<${#data[@]}; i++ ))
do
    #echo "${data[$i]}"
    #echo "${expects[$i]}"

    actual=$( callFunction "${data[$i]}" )

    #echo "${actual}"

    [[ ${actual} != ${expects[$i]} ]] && echo "failure=${i}"
   
done

echo "...END"
echo
