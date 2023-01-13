#!/bin/bash

#set -x

function version()
{
    echo v0.0.1
}

function usage()
{
    cat <<EOL
        
        Name
            bash template
        
        Synopsis
            test1.sh [options] directory
        
        Description
            

        Options
            -h --help
                display help.

            -v --version
                display version.

EOL

}


SHORT_OPTION=hvn
LONG_OPTION=help,version,dry-run

Params=$(getopt -o "${SHORT_OPTION}" -l "${LONG_OPTION}" -- "$@")
eval set -- "${Params}"



echo ${#Params[@]}

#for x in "${Params[@]}" ;
#for x in "$@" ;
for x in ${Params[@]} ;
do
    echo $x
    
    case "${x}" in
        -h | --help)
            usage
            exit 0
            ;;
        -v | --version)
            version
            exit 0
            ;;
        -n | --dry-run)
            echo AAA;
            ;;
        --)
            break
            echo BBB
            ;;
    esac

    shift
done

echo ${#Params[@]}

echo END

