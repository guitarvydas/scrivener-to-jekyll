#!/bin/bash

echo scrivener-to-jekyll
set -xv

rm -f wire1 wire1a wire1b wire1c wire2 wire2a wire2b wire3 wire4
mkfifo wire1 wire1a wire1b wire1c wire2 wire2a wire2b wire3 wire4

./wire-splitter3 wire1 wire1a wire1b wire1c &
./wire-splitter2 wire2 wire2a wire2b &

# explicit declarations for ports (mapped to FDs)
# convention: PORT_<part>_<pin>=fd
PORT_self_filename=3
PORT_self_content=4

PORT_pathA_filename=3
PORT_pathA_content=4
PORT_pathA_go=5

PORT_pathB_filename=3
PORT_pathB_content=4
PORT_pathB_go=5

PORT_isADirectory_filename=3
PORT_isADirectory_no=4
PORT_isADirectory_yes=5



# connect wires to components

# same as: isADirectory.bash 3<wire1c 4<wire2a 5<wire3
./isADirectory.bash ${PORT_pathA_filename}<wire1c ${PORT_pathA_content}<wire2a ${PORT_pathA_go}<wire3 &
pid1=$!

# same as: pathA.bash 3<wire1a 4<wire2a 5<wire3
./pathA.bash ${PORT_pathA_filename}<wire1a ${PORT_pathA_content}<wire2a ${PORT_pathA_go}<wire3 &
pid2=$!

# same as: pathB.bash 3<wire1b 4<wire2b 5<wire4
./pathB.bash ${PORT_pathB_filename}<wire1b ${PORT_pathB_content}<wire2b ${PORT_pathB_go}<wire4 &
pid3=$!



# main loop of top (parent) part
# 2 inputs: filename & content, check them, then transfer data to appropriate wires
while true
do
    echo LOOP
    echo read -n 512 -u ${PORT_self_filename} var_filename
    read -n 512 -u ${PORT_self_filename} var_filename
    if test -z "$var_filename"
    then
	echo ${var_filename} > wire1
    fi

    read -n 512 -u ${PORT_self_content} var_content
    if test -z "$var_content"
    then
	echo ${var_content} > wire2
    fi

done

wait ${pid1} ${pid2} ${pid3}
