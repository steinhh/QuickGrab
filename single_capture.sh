#!/bin/bash

date=`date "+%Y-%m-%d-%H:%M:%S"`
file=~/screencapture/"$date".png
idle_seconds=`idle_seconds`
if (( $idle_seconds > $idle_threshold )) 
then
    echo "Idle: ${idle_seconds}s - not snapping"
    touch "$file"
else 
    quickgrab -file "$file"
    echo "Grabbed $file"
fi
