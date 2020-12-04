#!/bin/bash
## send file name into 3
## if file name is a directory, echo <something> to port 4
## else echo <something> to port 5
# input_port[3] === input_port["filename"]
# output_port[4] === output_port["yes"]
# output_port[5] === output_port["no"]
echo "* $0"
read -u 3 filename
if test -d ${filename}
then
   echo directory >/dev/fd/4
else
   echo notDirectory >/dev/fd/5
fi

