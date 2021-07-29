#!/bin/bash

#Initialise the working variables

var1=0
var2=0
op=0
total=0

#include codes to set the foreground colours (only 4 needed) + nocolour 

red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
purple='\033[0;35m'
nocolour='\033[0m'

#Let the user know how the program works 

echo "This program allows you to enter numbers one after another and the running total is calculated"
echo "for each number entered"
echo " "

# Enter the first number

read -p  "Enter First Number: " var1
echo" "

# Find out type of operation - in range 1-5 only
while true
do
   until ((op >= 1 && op <= 5))
   do
       echo
       echo "Select from the following options: "
       echo  "1) Add (+)"
       echo  "2) Subtract (-)"
       echo  "3) Multiply (*)"
       echo  "4) Divide (/)"
       echo  "5) Exit Program"
       echo
       read -p "Please enter type of operation to perform: " op
       echo " "
   done

    # Get the next number (if the user did not want to Exit)

   if ((op != 5)); then
      read -p "Enter Next Number: " var2
      echo
   fi

   # Perform requested operation, changing colour to suit

   case $op in
     1)  (( total = $var1 + $var2 ))
         echo -e "${blue}Result:  $var1 + $var2 = $total"   
         ;;
     2)  (( total = $var1 - $var2 ))
         echo -e "${green}Result: $var1 - $var2 = $total"
         ;;
     3)  (( total = $var1 * $var2 ))
         echo -e "${red}Result: $var1 * $var2 = $total"
         ;;
     4)  (( total = $var1 / $var2 ))
         echo -e "${purple}Result: $var1 / $var2 = $total"
         ;;
     5)  echo "Thank you and Goodbye"
         exit 0
         ;;
   esac

   # Copy the current total to the first variable (var1) so we don't lose the progressive total

   var1="$total"

   # End the colour change  - set no colour

   echo -e "${nocolour}"

   # Reset the desired operation to 0

   op=0
done

# error condition - should not get here
exit 1
