#!/bin/bash
REMOTE_PATH="Eason/Log/"
REMOTE_SERVERIP="gw.ops.cedexis.com"
REMOTE_USER="manager"

PATERN="log"
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
				if [[ "$flow" == *"$PATERN"* ]]; then
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
echo "Files with \"$PATERN\" were copied to remote directory $REMOTE_PATH$DATE on $REMOTE_SERVERIP"