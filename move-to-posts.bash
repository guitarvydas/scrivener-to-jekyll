#!/bin/bash
#
## inputs:
## filename (fd 3)
## prefix (fd 4)
## go (fd 5)
#
## outputs:
## <none> - causes side-effect of mv'ing prefix/filename to ./_posts/
#

var_filename=""
read -u 3 var_filename
read -u 4 var_prefix
read -u 5 var_go

echo move-to-posts filename: ${var_filename}
echo move-to-posts prefix: ${var_prefix}
echo move-to-posts plan: mv ${var_filename} _posts/${var_prefix}-${var_filename}
mv ${var_filename} _posts/${var_prefix}-${var_filename}


