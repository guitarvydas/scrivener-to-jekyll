#!/bin/bash
echo TESTER
set -x
./scrivener-to-jekyll.bash 3< `echo test.html` 4<`echo junk`
