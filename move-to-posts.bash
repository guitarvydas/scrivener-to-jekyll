#!/bin/bash
#
## inputs:
## filename (fd 3)
## prefix (fd 4)
## go (fd 5)
#
## outputs:
## <none> - causes side-effect of mv'ing prefix/filename to ./_posts/
#

running=true
while test "true" = ${running}
do
    read -n -u 5 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	read -n -u 3 var_temp
	if test -n ${var_temp}
	then
	    var_filename=${var_temp}
	fi
    fi
done

echo move-to-posts filename: ${var_filename}
read -u 4 var_prefix
echo move-to-posts prefix: ${var_prefix}

