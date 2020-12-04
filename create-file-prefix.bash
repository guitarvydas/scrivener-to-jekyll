#!/bin/bash
#
## inputs:
## filename (fd 3)
## go (fd 4)
#
## outputs:
## prefix (fd 5)
#

read -u 3 var_filename
read -u 4 var_go

# error check needed here - var_filename should not be "" at this point
var_creation_time=`grep '<meta name="CreationTime' ${var_filename}`
var_prefix=`echo ${var_creation_time} | sed -e 's/<meta name="CreationTime" content="\(2020-..-..\)T11:42:29Z">/\1/'`
echo ${var_prefix} >/dev/fd/5

