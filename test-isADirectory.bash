#!/bin/bash
read -u 3 PORT_filename
if test -d ${PORT_filename}
then
   echo ${PORT_filename} is a directory
else
    echo ${PORT_filename} is NOT a directory
fi

