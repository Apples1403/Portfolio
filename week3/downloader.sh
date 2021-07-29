#!/bin/bash
echo " "

#Enter the url to download

read -p "Please enter the url you would like to download or type exit to quit: " url
echo " "

#if user entered "exit" then do so

if [ "$url" = "exit" ]; then
    echo "Goodbye"
    echo " "
    exit 0
fi

#get the destination directory

read -p "Please enter the destination directory: " destination

#check the destination directory exists"

if [ -d "$destination" ]; then

    #get the data from the url

    wget -P "$destination" "$url"
echo " "

#check for any resulting error code

#    if [ "$?" > 0 ]; then
#        echo "Unable to retrieve data from supplied url - please check and try again"
#    fi
else

   #the destination directory doesn't exit - let the user know
   echo " " 
   echo "Destination directory does not exist, please try again"
   echo " " 
fi

exit 0



