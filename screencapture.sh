#!/bin/bash

function idle_seconds() {
  # Echo - thus return!
  local float_seconds=`ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF/1000000000; exit}'`
  echo ${float_seconds%.*}
}

idle_threshold=$((15 * 60))

date=`date "+%Y-%m-%d"`
dir=~/screencapture/$date
mkdir -p $dir
date_time=`date "+%Y-%m-%d-%H:%M:%S"`
file=$dir/$date_time.png
idle_seconds=`idle_seconds`
if (( $idle_seconds > $idle_threshold )) 
then
  echo "Idle: ${idle_seconds}s - not snapping"
  touch "$file"
else 
  $HOME/usr/local/src/QuickGrab/quickgrab -file "$file"
  echo "Grabbed $file"
fi
