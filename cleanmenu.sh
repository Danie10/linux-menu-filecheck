#!/bin/bash

# This script will parse all the *.desktop files in DIRECTORY
# to check if they have an Exec= line
# and print out the filename followed by the command line
# If no Exec= line found it will display accordingly

# If run with sudo as root user, it checks roots menu *.desktop files
# Note running as sudo will create an output file with root permissions
# If normal user has root permission desktop files in their menu apps location,
# It will generate file output but root permission files are displayed
# to the console and will state 'No such file or directory' as grep
# has no permission to read those files


# TODO: Consider passing a runtime variable as the DIRECTORY
# The user directory usually overrides the system directory
# so usually the errors are in this directory
# System wide desktop files are in
# /usr/share/applications/ or /usr/local/share/applications/

DIRECTORY=~/.local/share/applications

# $i will be full path and filename
# $i in brackets ensures handling of filenames with spaces in

# Loop now opens each file with .desktop extension to process
for i in $DIRECTORY/*.desktop; do
	# grep -q will return true if the 'Exec' string is found in the file
	# it returns false if it can open the file but does not find the string
	# it returns an error to console if the file exists but it cannot open it
	if grep -q 'Exec' "$i"
	then
	    # cat gets full file contents and grep will return just
	    # line with Exec=command string
	    command=$(cat "$i" | grep 'Exec')
	else
	    command="NO Exec COMMAND FOUND IN THIS FILE"
	fi
	# Writes results to a text file in current directory
	# with each line displaying path/filename followed by
	# Exec command or message
	# It appends to the file so you must manually delete the
	# output file before a new run
	echo "$i -> $command" >> menucommands.txt
done
