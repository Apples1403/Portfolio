#!/bin/bash

#find out name of current user

user=$(whoami)

#set input folder to home directory of that user

input=/home/$user

#set destination folder where the backup will be stored

output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

# create the backup (tar) file in the destination folder

tar -czf $output $input

#let the user know its finished

echo "Backup of $input completed! Details about the output backup file:"

#display the contents of the destination folder

ls -l $output
