#!/bin/bash

#get the name of the new folder from user

read -p "type the name of the folder you would like to create: " FolderName 

# create the new folder 

mkdir "$FolderName" 

