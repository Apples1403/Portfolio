#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;35m'
grey='\033[0;32m'
nocolour='\033[0m'

# get the user to enter his password

# turn the text red 

echo -e "${red}"

../week\ 2/passwordcheck.sh

#if he got it right - continue

if (test $? == 0) ; then

   echo -e "${nocolour}"

   while :
   do
      # set initial value for option of 0

      option=0

      # repeat the loop until user enters value in the range of 1-8

      until ((option >= 1 && option <= 8))
      do
         echo -e "${blue}"
         echo "Select an Option in the range 1-8"
         echo "1. Create a Folder"
         echo "2. Copy a Folder"
         echo "3. Set a Password"
         echo "4. Calculator"
         echo "5. Create Week Folders"
         echo "6. Check Filenames"
         echo "7. Download a file"
         echo "8. Exit"
         echo " "
         echo -n "Please enter Option: "
         read option
         if ((option >= 1 && option <= 8)); then
        
            # display blank line

            echo " "
         else

            # let the user know his value was out of range

            echo " "
            echo "Please enter a Number in the Range 1 to 8"
         fi
         echo -e "${nocolour}"
      done    
       
      # based on input value run the appropriate script

      case  $option in
          1)  ../week\ 2/foldermaker.sh
              ;;
          2)  ../week\ 2/foldercopier.sh
              ;;
          3)  ../week\ 2/setPassword.sh
              ;;
          4)  ./calculator.sh 
              ;;
          5)  read -p "Please enter starting week number: " firstweek
              echo " "
              read -p "Please enter ending week number: " lastweek
              ./megafoldermaker.sh "$firstweek" "$lastweek"
              ;;
          6)  read -p "Please enter name of text file: " textfilename
              ./filenames.sh "$textfilename"
              ;;
          7)  ./downloader.sh;;
          8)  echo -e "${green}Goodbye"
              echo -e "${nocolour} "
              exit 0;
        esac
   done
else   

# user got password wrong - exit
   
   echo " "
   echo -e "${green}Goodbye"
   echo -e "${nocolour}"
   echo " "
 
   exit 0
fi

# shouldn't get here

exit 1
