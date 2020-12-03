#!/bin/bash
#
## inputs:
## filename (fd 3)
## go (fd 4)
## contents (fd 5) N/C
#
## outputs:
## prefix (fd 6)
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
var_prefix=
echo ${var_filename} >&5

