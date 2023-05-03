#!/bin/bash

[[ $# -ne 1  || ! -f $1 ]] && cat <<EOL && exit 1

usage
    add_comment FILE

EOL


cat "$1" |awk -- '
BEGIN{
    split("", arStack);
    stackIndex = 0;
}
{

    if (match($0, "function") == 0)
    {
        arStack[stackIndex] = $0;
        stackIndex++;
    } else {
        output();



    }
}

END {
    output();
}

function output()
{
    for(i = 0; i < stackIndex; i++)
    {
        print arStack[i];
    }
    
    delete arStack;
    stackIndex = 0;
}
'


