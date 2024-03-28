#!/bin/bash
#
# test output_function_comment.awk
#
#set -e
#set -x

cd $(dirname $0)

src_dir=../functions
original_name=output_function_comment
script_name=../tmp/${original_name}.test

function makeTestFile()
{
cat ${src_dir}/${original_name}.awk \
    ${src_dir}/trim.awk \
    - <<'EOL' > "${script_name}"

{
    ret=output_function_comment(row,indent)
    print ret
}
EOL
}

function callFunction()
{
    #echo "$(echo "" |awk -f "${script_name}" -v row="$1" -v indent="$2")"
    echo "" |awk -f "${script_name}" -v row="$1" -v indent="$2"
}

makeTestFile

declare -a data
declare -a expects

data1[0]='public function func1('
data2[0]=''
expects[0]='* func1'

data1[1]='public function func1('
data2[1]='    '
expects[1]='    * func1'


echo "...START(OK if there is no failure)"

for(( i=0; i<${#data1[@]}; i++ ))
do
    #echo "${data1[$i]}"
    #echo "${data2[$i]}"
    #echo "${expects[$i]}"

    actual=$( callFunction "${data1[$i]}" "${data2[$i]}")

    #echo "${actual}"

    [[ ${actual} != ${expects[$i]} ]] && echo "failure=${i}"
   
done

echo "...END"
echo