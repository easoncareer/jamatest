#!/bin/bash
REMOTE_PATH="remote/directory/"
REMOTE_SERVERIP="portland05"
REMOTE_USER="remote_user"


PATERN="log"
DPATH="`pwd -P`"
SCRIPTPATH="$DPATH/$(basename $BASH_SOURCE)"
DATE=`date +%F_%T`

is_search_content ()
{
	arglow="`tr '[:upper:]' '[:lower:]' <<< $1`"
	if [[ $arglow == "content" ]]; then
		echo 1
	else
		echo 0
	fi
}

sendfile () 
{ 
	fpath=${1#$DPATH}
	DIR=$(dirname "${fpath}")
	ssh "$REMOTE_USER@$REMOTE_SERVERIP" "mkdir -p $REMOTE_PATH$DATE$DIR"
	scp "$1" "$REMOTE_USER@$REMOTE_SERVERIP:$REMOTE_PATH$DATE$fpath"
	# rsync -ave ssh "$1" "$REMOTE_USER@$REMOTE_SERVERIP:$REMOTE_PATH/$DATE$fpath"
}

match_file_name()
{
	flow="`tr '[:upper:]' '[:lower:]' <<< $2`"
	if [[ "$flow" == *"$PATERN"* ]]; then
		sendfile "$1"
	fi
}

match_file_content()
{
	if grep -ixq "$PATERN" "$1"; then
		sendfile "$1"
	fi
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
				if [ $SEARCH_CONTENT -eq 1 ]; 
				then
					match_file_content "$fpath"  # search in file content
				else
					match_file_name "$fpath" "$f"  # search in file name
				fi
			fi
		fi
	done
}


SEARCH_CONTENT=`is_search_content "$1"`
getfile "$DPATH"
echo "Files with \"$PATERN\" were copied to remote directory $REMOTE_SERVERIP:$REMOTE_PATH$DATE"