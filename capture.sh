#!/bin/bash

function idle_seconds() {
  # Echo - thus return!
  local float_seconds=`ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF/1000000000; exit}'`
  echo ${float_seconds%.*}
}

cadence=120
idle_threshold=$((20 * 60))

while [ 1 ]; do
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
  sleep $cadence
done
