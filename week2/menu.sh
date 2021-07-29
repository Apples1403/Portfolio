#!/bin/bash

# get the user to enter his password

./passwordcheck.sh

#if he got it right - continue

if (test $? == 0) ; then

   # set initial value for option of 0

   option=0

# repeat the loop until user enters value in the range of 1-3

   until ((option >= 1 && option <= 3))
   do
      echo "Select an Option in the range 1-3"
      echo "1. Create a Folder"
      echo "2. Copy a Folder"
      echo "3. Set a Password"
      echo -n "Please enter Option: "
      read option
      if ((option >= 1 && option <= 3)); then
        
         # display blank line

         echo " "
      else

         # let the user know his value was out of range

         echo " "
         echo "Please enter a Number in the Range 1 to 3"
      fi
   done    

   # based on input value run the appropriate script
 
   case $option in
        1) ./foldermaker.sh;;
        2) ./foldercopier.sh;;
        3) ./setPassword.sh;;
   esac
else   

   # user got password wrong - exit

   echo "Goodbye"
   exit 0
fi
