#!/bin/bash
echo "* $0"

## inputs
## port 3 --> filename
## port 4 --> go
#
## outputs
## <none> - side effect creates a file in ./_post and, maybe in ./assets/
#
rm -f wire_*

wire1=wire_$RANDOM
wire1a=wire_$RANDOM
wire1b=wire_$RANDOM
wire1c=wire_$RANDOM

wire3=wire_$RANDOM
wire4=wire_$RANDOM

mkfifo ${wire1}
mkfifo ${wire1a}
mkfifo ${wire1b}
mkfifo ${wire1c}
mkfifo ${wire3}
mkfifo ${wire4}


# sub components
./wire-splitter3.bash 3<${wire1} 4>${wire1a} 5>${wire1b} 6>${wire1c} &
./isADirectory.bash 3<${wire1c} 4>${wire4} 5>${wire3} &
./pathA.bash 3<${wire1a} 5<${wire3} &
./pathAa.bash 3<${wire1b} 5<${wire4} &

read -u 3 filename
echo ${filename} >${wire1}

wait
echo "** done $0"
