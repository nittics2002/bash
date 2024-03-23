#!/bin/bash



echo 'aaa bbb ccc' |awk '{split($0, ar, / /); print ar[1]}'


