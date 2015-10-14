#!/bin/bash
REMOTE_PATH="remote/directory/"
REMOTE_SERVERIP="portland05"
REMOTE_USER="root"

PATERN="Log"
DPATH="`pwd -P`"
SCRIPTPATH="$DPATH/$(basename $BASH_SOURCE)"
DATE=`date +%F_%T`

sendfile () 
{ 
	fpath=${1#$DPATH}
	DIR=$(dirname "${fpath}")
	ssh "$REMOTE_USER@$REMOTE_SERVERIP" "mkdir -p $REMOTE_PATH$DATE$DIR"
	scp "$1" "$REMOTE_USER@$REMOTE_SERVERIP:$REMOTE_PATH$DATE$fpath"
	# rsync -ave ssh "$1" "$REMOTE_USER@$REMOTE_SERVERIP:$REMOTE_PATH/$DATE$fpath"
}

getfile ()
{	
	for f in `ls -1 "$1"`
	do
		fpath="$1/$f"
		if [ "$fpath" != "$SCRIPTPATH" ]; then
			if [ -d "$fpath" ]; then
				getfile "$fpath"
			else
				flow="`tr '[:upper:]' '[:lower:]' <<< $f`"
				if [[ "$flow" == *"log"* ]]; then
					if [ -f "$fpath" -a -r "$fpath" ]; then
						sendfile "$fpath"
					else
						echo "Error: Cannot read $f"
					fi
				fi
			fi
		fi
	done
}

getfile "$DPATH"