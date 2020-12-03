#!/bin/bash
## send file name into 3
## if file name is a directory, echo <something> to port 4
## else echo <something> to port 5
# input_port[3] === input_port["filename"]
# output_port[4] === output_port["yes"]
# output_port[5] === output_port["no"]
read -u 3 PORT_filename
if test -d ${PORT_filename}
then
   echo directory >&4
else
   echo notDirectory >&5
fi

