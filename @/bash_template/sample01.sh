#!/bin/bash

#set -x

source var_dump.sh

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


SHORT_OPTION=hvnd:i:
LONG_OPTION=help,version,dry-run,max-depth:,ignore:

Params=$(getopt -o "${SHORT_OPTION}" -l "${LONG_OPTION}" -- "$@")
eval set -- "${Params}"

while [[ $# -gt 0 ]] ;
do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -v|--version)
            version
            exit 0
            ;;
        -n|--dry-run)
            shift
            ;;
        -d|--max-depth)
            max_depth="$2"
            shift 2
            ;;
        -i|--ignore)
            ignore="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
    esac
done


echo AAAAAAAAAAAAAAAAAa

var_dump "$@"

echo AAAAAAAAAAAAAAAAAa

echo max_depth="${max_depth}"

echo ignore="${ignore}"

echo END

var_dump "${Params[@]}"


