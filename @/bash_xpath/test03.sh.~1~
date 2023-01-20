#!/bin/bash
#
# 
#
#

#
#   clean_tmpfiles
#
#   @param int exit_status
#   @param &array file_path
#
function clean_tempfiles()
{
    local status=$1
    shift
    declare -n file_paths="$@"

    [[ ${#file_paths[@]} == 0 ]] && exit 0

    echo "${file_paths[@]}" |xargs rm -f

    exit $status
}

tmpfile[0]=$(mktemp)
tmpfile[1]=$(mktemp)
tmpfile[2]=$(mktemp)

trap 'clean_tempfiles $? tmpfile' EXIT INT PIPE TERM







