#!/bin/bash
## send file name into 3
## if file name is a directory, echo <something> to port 4
## else echo <something> to port 5
# input_port[3] === input_port["filename"]
# output_port[4] === output_port["yes"]
# output_port[5] === output_port["no"]
echo "* $0"
# read -u 3 filename
read filename </dev/fd/3
if test -d ${filename}
then
   echo "*** directory /${filename}/ $0"
   echo go >/dev/fd/4
   echo die >/dev/fd/5
else
   echo "*** not directory /${filename}/ $0"
   echo go >/dev/fd/5
   echo die >/dev/fd/4
fi
echo "** done $0"

