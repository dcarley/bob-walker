#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

This script simulates a bob walker

OPTIONS:
   -h      Show this message
   -s      Sport mode!
EOF
}

SPORT_MODE=0

while getopts “hs” OPTION
do
    case $OPTION in
        h)
            usage
            exit
            ;;
        s)
           SPORT_MODE=1
           ;;
        ?)
           usage
           exit 1
           ;;
    esac
done

while true; do
  echo beard
  echo beer
  echo pie
  if [ $SPORT_MODE -eq 1 ]; then
    echo rugby
    echo cricket
  fi
done
