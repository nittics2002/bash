#!/bin/bash

clear

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
                ifFunction = false;
            } else {
                ifFunction = true;
            }

        } else {
            addStack($0);
            outputStack();
        }
    } else if (isFunction){
        getSyntax();
        
        if(hasBrace()){
            addComment();
            addStack($0);
            outputStack();
            ifFunction = false;
        }
    } else {
        addStack($0);
    }
}

END {
    outputStack();
}

function addComment()
{
    if(substr($1, 0, 1) == " "){
        tabString = $1;
    } else {
        tabString = "";
    }

    addStack(tabString "/**");
    addStack(tabString " *");
    addStack(tabString " * " methodName);
    addStack(tabString " *");

    for(i in arArgs){
        addStack(tabString " * @param " arArgs[i]);
    }

    addStack(tabString " *");
    addStack(tabString " */");
}

function getSyntax()
{
    split($0, arSyntax1, "\(");

    if (length(arSyntax1) == 1){
        return;
    }

    getMethod(arSyntax1[1]);

    split(arSyntax1[2], arSyntax2, ",");

    for (i in arSyntax2){
        gsub("[(){]", "", arSyntax2[i]);
        arArgs[argsIndex] = arg;
        argsIndex++;
    }
}

function getMethod(text)
{
    split(text, arSyntax11, " function ");

    if (length(arSyntax11) != 2){
        return;
    }

    gsub(" ", "", arSyntax11[2]);

    methodName = arSyntax11[2];
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
#        print arStack[i];
    }
    
    delete arStack;
    stackIndex = 0;
}
'

