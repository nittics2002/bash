#!/bin/bash



jq -r '.items[].name' aaa.json | \
while read line
do
    echo "---${line}---"
done






