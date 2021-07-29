#!/bin/bash

read -p "type the name of the folder you would like to copy: " FolderName

#if the name is a valid directory

if [ -d "$FolderName" ]; then

    # copy it to a new location

    read -p "type the name of the destination folder: " newFolderName

    cp -r "$FolderName" "$newFolderName"

else

    #otherwise, print an error

    echo "I couldn't find that folder"
    
fi

