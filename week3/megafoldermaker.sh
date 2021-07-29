#!/bin/bash

#if there aren't two arguements to the script

if (($#!=2)); then
    
    #Print error and exit

    echo "Error, please provide two numbers"  && exit 1

fi

echo "$1"
echo "$2"

#For every number between the first argument and the last

for ((i=$1; i<= $2; i++))

do

#Create a new folder for that number 

echo "Creating directory number $i"

mkdir "week $i"

done

exit 0
