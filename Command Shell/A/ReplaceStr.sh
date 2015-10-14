#!/bin/bash
OLD="contour"
NEW="jama"
DPATH="`pwd -P`"
TFILE="/tmp/out.tmp.$$"
SCRIPTPATH="$DPATH/$(basename $BASH_SOURCE)"

sedfile () 
{ 
	sed "s/$OLD/$NEW/g" "$1" > $TFILE && mv $TFILE "$1"
}

getfile ()
{	
	for f in `ls -1 "$1"`
	do
		f="$1/$f"
		if [ "$f" != "$SCRIPTPATH" ]; then
			if [ -d "$f" ]; then
				getfile "$f"
			else
				if [ -f "$f" -a -r "$f" ]; then
					sedfile "$f"
				else
					echo "Error: Cannot read $f"
				fi
			fi
		fi
	done
}

getfile "$DPATH"