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
    split("", arArgs);
    argsIndex = 0;
}
{
    if (match($0, "function") > 0){
        if(!hasComment()){
            getSyntax();
            
            if(hasBrace()){
                addStack($0);
                outputStack();

            } else {
                ifFunction = true;
            }

        } else {
            addStack($0);
            outputStack();
        }



        
    } else if (isFunction){

    
    
    } else {
        
        addStack($0);
        
    }
}

END {
    outputStack();
}

function getSyntax()
{
    split($0, arSyntax1, "\(");

    if (length($arSyntax1) == 0){
        return;
    }
    
    split(arSyntax1, arSyntax2, ",");

    for arg in arSyntax2){
        gsub("", "", arg);
        arArgs[argsIndex] = arg;
        argsIndex++;
    }
}

function hasBrace()
{
    if(index($0, "{") == 0){
        return true;
    }
    return false;
}

function hasComment()
{
    for(i = stackIndex - 1; i >= 0; i--){
        trimed =  arStack[i];
        gsub(" ", "", trimed);

        if(trimed == ""){
            //nop
        }else if(index(arStack[i], "*/") == 0){
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
    for(i = 0; i < stackIndex; i++){
        print arStack[i];
    }
    
    delete arStack;
    stackIndex = 0;
}
'

