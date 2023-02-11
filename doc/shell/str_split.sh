#!/bin/bash
UPDATE=4.2,4.3,5.4

if [ "$UPDATE" == "" ];
then 
    echo ok;
else 
    arr=$(echo $UPDATE | tr "," "\n");
    for s in ${arr[@]};
    do
        echo $s;
    done;
fi;
