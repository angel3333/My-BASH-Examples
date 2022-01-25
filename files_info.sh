#!/bin/bash

# ./files_info.sh [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help] [-s] [--stats]

function usage() {
  echo "USAGE: $0 [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help] [-s] [--stats]"
  echo "Examples:"
  echo "$0 -l /etc/ -e txt -s"
  echo "$0 -e img --stats"
  echo
  exit 1
}

LOC_SET=0	#0-location not set, use current location     1-location set
STATS=0		#0-do not display statistics		              1-display statistics

while [ $# -gt 0 ]
do
  case $1 in
    -l|--location ) 
	LOCATION="$2"
	if ! [ -d "$LOCATION" ]; then
	  usage
	fi
	LOC_SET=1
	shift
	shift
	;;

    -e|--extension )
	EXT="$2"
	shift
	shift
	;;

    -s|--stats )
	STATS=1
	shift
	;;

    -h|--help )
	shift
	usage
	;;

    * )
	usage
	;;
  esac


done

if [ $LOC_SET -ne 1 ]; then
  LOCATION=$(pwd)
fi

echo "Location: $LOCATION"

if [ "$EXT" != "" ]; then
  ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$" &>/dev/null
  if [ $? -ne 0 ]; then
    echo "No file with extension: $EXT found"
    exit 2
  fi

  #count size of files with specific extension
  ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$" | awk -v stats=$STATS -f /home/user/size.awk

else
  ls -l $LOCATION | awk '/^-/' | awk -v stats=$STATS -f /home/user/size.awk

fi
