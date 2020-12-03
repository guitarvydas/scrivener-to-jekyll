#!/bin/bash
#
## inputs:
## filename (fd 3)
## go (fd 4)
## content (fd 5) N/C
#
## outputs:
## <none> - side-effect - file.html moved to ./_posts/<prefix>_filename.html
#

rm -f wire10, wire10a, wire10b, wire20, wire20a, wire20b, wire30
mkfifo wire10 wire10a wire10b wire20 wire20a wire20b wire30

./create-file-prefix.bash 3<wire10a 4<wire20a 5>wire30 &
create_file_prefix_pid = $!
./move-to-posts.bash 3<wire10b 4<wire30 5<wire20b &
move_to_posts_pid = $!

var_filename=""
running="true"
while test "true" = ${running}
    read -n -u 4 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	read -n -u 3 var_temp
	if test -n ${var_temp}
	then
	    echo ${var_temp} >wire10
	fi
    fi
done
echo "go" >wire20
wait ${create_file_prefix_pid} ${move_to_posts_pid}      
exit 0



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


