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
    methodName = "";
}
{
    if (match($0, "function") > 0){
        if(!hasComment()){
            getSyntax();
            
            if(hasBrace()){
                addComment();
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

function addComment()
{

}

function getSyntax()
{
    split($0, arSyntax1, "\(");
    getMethod(arSyntax1[0]);

    if (length(arSyntax1) == 1){
        return;
    }
    
    split(arSyntax1[1], arSyntax2, ",");

    for (i in arSyntax2){
        gsub("[(){]", "", arSyntax2[i]);
        arArgs[argsIndex] = arg;
        argsIndex++;
    }
}

function getMethod(text)
{
    split(text, arSyntax1, " function ");

    if (length(arSyntax1) != 2){
        return;
    }

    gsub(" ", "", arSyntax1[1]);

    methodName = arSyntax1[1];
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

