## Command Shell Test B

Write a terminal script that will copy files containing the word “log” to a remote machine called portland05.


### How to

 1. Place the script file [Copy2Remote.sh](https://github.com/easoncareer/jamatest/blob/master/Command%20Shell/B/Copy2Remote.sh) in any directory.
 2. Edit [Copy2Remote.sh](https://github.com/easoncareer/jamatest/blob/master/Command%20Shell/B/Copy2Remote.sh) and give valid value for the below variables:
    
    ```
    REMOTE_PATH="remote/directory/"
    REMOTE_SERVERIP="portland05"
    REMOTE_USER="remote_user"
    ```
      Make sure the local system does have access to the remote system and the user does have write access to the remote directory
 3. Go to the directory in Terminal/Shell and run 
 	- `bash Copy2Remote.sh` if want to copy files with "log" in file **NAME**
 	- `bash Copy2Remote.sh content` if want to copy files with "log" in file **CONTENT**

### Notes

 - Script will search all files in the directory and go deeper if any subdirectories
 - Assuming "log" is case insensitive
 - Assuming find "log" in file name, script will find "log" in file name by default.
 - Assuming local system does have access to remote server/directory via ssh