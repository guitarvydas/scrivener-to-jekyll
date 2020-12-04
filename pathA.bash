#!/bin/bash
#
## inputs:
## filename (fd 3)
## content (fd 4) N/C
## go (fd 5)
#
## outputs:
## <none> - side-effect - file.html moved to ./_posts/<prefix>_filename.html
#

rm -f _posts/*

wire1=wire_$RANDOM
wire1a=wire_$RANDOM
wire1b=wire_$RANDOM
wire2=wire_$RANDOM
wire2a=wire_$RANDOM
wire2b=wire_$RANDOM
wire3=wire_$RANDOM
mkfifo ${wire1} ${wire1a} ${wire1b} ${wire2} ${wire2a} ${wire2b} ${wire3}

./create-file-prefix.bash 3<${wire1a} 4<${wire2a} 5>${wire3} &
./move-to-posts.bash 3<${wire1b} 4<${wire3} 5<${wire2b} &
./wire-splitter2 3<${wire1} 4>${wire1a} 5>${wire1b} &
./wire-splitter2 3<${wire2} 4>${wire2a} 5>${wire2b} &

read -u 3 filename
echo test1.html > ${wire1} &

read -u 5 go
echo ${go} > ${wire2} &

wait



## pseudo code
#
# initialize filename to empty
# while running
# do
#     go = non-blocking-read port["go"]
#     if go {
# 	    exit loop
#     } else {
# 	   temp = non-blocking-read port["filename"]
# 	   if temp {
# 	      send temp to create-file-prefix["filename"], move-to-posts["filename"]
# 	   }
#     }	      
# end while
# send "go" to create-file-prefix["go"], move-to-posts["go"]
#
#
## pseudo code with more detail
#
# self.input filename --> wire10[3]
# self.input go --> wire20[3]

# wire10 --> wire10a, wire10b
# wire10a --> create-file-prefix.bash[3]
# wire10b --> move-to-posts.bash[3]

# wire20 --> wire20a, wire20b
# wire20a --> create-file-prefix.bash[4]
# wire20b --> move-to-posts.bash[5]

# wire30 --> move-to-posts.bash[4]

# initialize filename to ""
# initialize running to "true"
# while running == "true"
# do
#     go = read fd 3 
#     if go {
# 	    set running = "false"
#     } else {
# 	   temp = read fd 4
# 	   if temp is not empty {
# 	      send temp to wire10
# 	   }
#     }	      
# end while
# send "go" to wire20

