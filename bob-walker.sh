#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

This script simulates a bob walker

OPTIONS:
   -h      Show this message
   -s      Sport mode!
   -d      Drunk mode!
EOF
}

SPORT_MODE=0
DRUNK_MODE=0

while getopts “hsd” OPTION
do
    case $OPTION in
        h)
            usage
            exit
            ;;
        s)
           SPORT_MODE=1
           ;;
        d)
           DRUNK_MODE=1
           ;;
        ?)
           usage
           exit 1
           ;;
    esac
done

if [ $DRUNK_MODE -eq 1 ]; then
  DRUNK_FILTER="sed 's/e/eeee/g'"
else
  DRUNK_FILTER="cat"
fi

while true; do
  echo beard
  echo beer
  echo pie
  if [ $SPORT_MODE -eq 1 ]; then
    echo rugby
    echo cricket
  fi
  [ $DRUNK_MODE -eq 1 ] && sleep 1
done | eval $DRUNK_FILTER

