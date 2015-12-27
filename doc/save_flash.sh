#!/bin/bash

#saving flash (flv) video files from Goolge Chrome cache

pidNum=$(ps ax | grep flash | grep chrome | grep -v "grep" | sed -e 's/^ *//g' -e 's/ *$//g' | tr -s " " | cut -d " " -f 1)
procNum=$(ls -l /proc/${pidNum}/fd | grep Flash | tr -s " " | cut -d " " -f 9)

filename=$1
if [[ "$filename" == "" ]]; then
  filename=$procNum
fi

echo "Copying /proc/${pidNum}/fd/${procNum} to '${filename}.flv'"
cp /proc/${pidNum}/fd/${procNum} "${filename}.flv"
ls -lah "${filename}.flv"
