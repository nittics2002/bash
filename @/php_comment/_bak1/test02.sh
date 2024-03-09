#!/bin/bash

[[ $# -ne 1  || ! -f $1 ]] && cat <<EOL && exit 1

usage
    add_comment FILE

EOL

cat "$1" |awk -- '
BEGIN{
    stackIndex = 0;
}
{

print NR;


    if (match($0, /./) != 0)
    {
        
        print 'AAAAAAAAAAAAAAAAAAAAA';
        
        
        
        arStack[stackIndex] = $0;
        stackIndex++;
    } else {
        output();


        print 'FFFFFFFFFFFFFFFFF';


    }


    print 'DDDDDDDDDDDDDDDDD';

}

END {
    output();
}

function output()
{
    for(i = 0; i < stackIndex; i++)
    {
        print arStack[stackIndex];
    }
    
    delete arStack;
    stackIndex = 0;
}
'


echo RESULT=$?

