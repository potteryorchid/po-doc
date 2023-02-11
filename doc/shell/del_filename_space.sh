#!/bin/bash
read -t 120 -p ">>>>>>> Please enter an absolute path to the directory where the loop resides and at the end of without '/' :" dir
cd $dir
for loop in `ls -1 | tr ' ' '#'`
do
    mv "`echo $loop | sed -e 's/#/ /g'`" "`echo $loop | sed -e 's/#//g'`"
done
