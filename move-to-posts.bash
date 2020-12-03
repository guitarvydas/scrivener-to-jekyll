#!/bin/bash
#
## inputs:
## filename (fd 3)
## prefix (fd 4)
## go (fd 6)
#
## outputs:
## <none> - causes side-effect of mv'ing prefix/filename to ./_posts/
#

running=true
while test "true" = ${running}
do
    read -u 4 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	# hmm, this will need clean-up - if var_go is "", then we will block on reading a filename - that does not represent the correct semantics (we want to read-non-blocking var_go then read-non-blocking var_filename and keep looping)
	read -u 3 var_filename
    fi
done

# error check needed here - var_filename should not be "" at this point
echo ${var_filename} >&5

