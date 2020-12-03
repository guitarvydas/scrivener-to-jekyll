#!/bin/bash
#
## inputs:
## filename (fd 3)
## go (fd 4)
#
## outputs:
## prefix (fd 5)
#

running=true
while test "true" = ${running}
do
    read -n -u 4 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	read -n -u 3 var_filename
    fi
done

# error check needed here - var_filename should not be "" at this point
echo create-file-prefix filename: ${var_filename}
var_creation_time=`grep '<meta name="CreationTime' ${var_filename}`
echo create-file-prefix creation_time: ${var_creation_time}
var_prefix=`echo ${var_creation_time} | sed -e 's/<meta name="CreationTime" content="\(2020-..-..\)T11:42:29Z">/\1/'`
echo ${var_prefix} >&5

