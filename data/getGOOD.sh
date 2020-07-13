#!/bin/sh

# Get list of the good events.
list=`cat good_list`
fileO="IS_final.csv"
fileI="IS.csv"

# Recreate the file.
echo -n > $fileO

# Get the catalogue data.
for ID in $list
do
    echo $ID
    awk "/$ID/{print}" $fileI >> $fileO
done


