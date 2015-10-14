## Command Shell Test B. 

Write a terminal script that will copy files containing the word “log” to a remote machine called portland05.


### How to

 1. Place the script file [Copy2Remote.sh] in any directory.
 2. Go to the directory in Terminal/Shell and run `bash Copy2Remote.sh`

### Notes

 - Script will search all files in the directory and go deeper if any subdirectories
 - Assuming "log" is case insensitive
 - Assuming find "log" in file name, not file content.
 - Assuming local system does have access to remote server/directory via ssh