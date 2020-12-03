#!/bin/bash
PORT_filename=$1
echo filename is ${PORT_filename}
if test -d ${PORT_filename}
then
   echo directory
else
    echo not a directory
fi

