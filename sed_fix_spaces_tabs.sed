function usage() {
  echo "USAGE: $0 [file-path] [-f | --fix] [-h | --help]"
  exit 1
}

FIX=0	#0-do not perform fix     1-perform fix

if [ $# -eq 0 ]; then
  usage
fi

while [ $# -gt 0 ]
do
  case "$1" in
    -f|--fix )
	FIX=1
	shift
	;;

    -h|--help )
	usage
	shift
	;;

    * )
	if [ -f "$1" ]; then
	  FILE="$1"
	  shift
	else
	  usage
	fi
	;;
  esac

done


if [ $FIX -eq 1 ] && [ -f "$FILE" ]; then
  echo "Fixing spaces and tabs at the beginning and at the end of lines"
  sed -i 's/[[:blank:]]\+$//' "$FILE"
  sed -i 's/^[[:blank:]]\+//' "$FILE"
fi


#display graphically space errors
if [ -f "$FILE" ]; then
  LINES=0
  REGEX_START="^[[:blank:]]+"
  REGEX_END="[[:blank:]]+$"


  while IFS= read -r line
  do
    let LINES++
    #if there is no space issue on a line, just print the line
    echo "$line" | sed -e '/[[:blank:]]\+$/q9' -e '/^[[:blank:]]\+/q7' >/dev/null
    if [ $? -eq 0 ]; then
      printf %4s "$LINES:" >> temp.txt 
      echo "$line" >> temp.txt
      continue
    fi

    #print line number
    printf %4s "$LINES:" >> temp.txt

    #print on the same line spaces/tabs as a red background at the beginning of line
    if [[ "$line" =~ $REGEX_START ]]; then
      MATCH=`echo "$BASH_REMATCH" | sed 's/\t/|___TAB___|/g'`
      echo -e -n "\e[41m$MATCH\e[49m" >> temp.txt
    fi
 
    #print on the same line part of line which is correct - which doesnt have spaces/tabs at the beginning
    #and at the end of line
    echo -e -n "$line" | sed -e 's/^[[:blank:]]\+//' -e 's/[[:blank:]]\+$//' >>temp.txt

    #print on the same line spaces/tabs as a red background at the end of line
    if [[ "$line" =~ $REGEX_END ]]; then
      MATCH=`echo "$BASH_REMATCH" | sed 's/\t/|___TAB___|/g'`
      echo -e "\e[41m$MATCH\e[49m" >> temp.txt
    else
      echo >> temp.txt 
    fi


  done < "$FILE"

  cat temp.txt
  rm temp.txt
fi

if [ $FIX -eq 1 ]; then
  echo
  echo -e "\e[42mDONE\e[49m"
fi
