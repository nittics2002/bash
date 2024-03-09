#!/bin/bash

[[ $# -ne 1  || ! -f $1 ]] && cat <<EOL && exit 1

usage
    add_comment FILE

EOL


cat "$1" |awk -- '
BEGIN{
    split("", arStack);
    stackIndex = 0;
    isFunction = false;
}
{
    if (match($0, "function") > 0)
    {
        if(!hasComment())
        {
            getSyntax();
            
            if(hasBrace())
            {
                addStack($0);
                outputStack();

            } else {
                ifFunction = true;
            }

        } else {
            addStack($0);
            outputStack();
        }



        
    } else if (isFunction)
    {

    
    
    } else {
        
        addStack($0);
        
    }
}

END {
    outputStack();
}

function getSyntax()
{

}

function hasBrace()
{

}

function hasComment()
{
    for(i = stackIndex - 1; i >= 0; i--)
    {
        if(index(arStack[i], "*/") == 0)
        {
            return true;
        } else {
            return false;
        }
    }
}

function addStack(row)
{
    arStack[stackIndex] = row;
    stackIndex++;
}

function outputStack()
{
    for(i = 0; i < stackIndex; i++)
    {
        print arStack[i];
    }
    
    delete arStack;
    stackIndex = 0;
}
'

