#!/bin/bash

# initialize option

option=0

# repeat the loop until user enters value in the range of 1-3

until ((option >= 1 && option <= 3))

do

    #clear the screen

    clear

    # Display heading

    echo -e "\033[032m                                    CyberSecurity - Insiders : Information Technology - Security  \033[0m"

    echo -e "\033[032m                                    ============================================================  \033[0m"

    echo

    echo "This program pulls data from the Cybersecurity Insiders website, totalling the number of articles in the specific area of interest "

    echo "Information Technology - Security.  Statistics are totalled for each sub-category."

    echo " "

    echo "Alternatively the user is presented with a list of available sub-categories from which the user may choose a sub-category of interest and be"

    echo  "presented with the top 50 most popular articles in that sub-category. The user may then choose to view further details of that article"

    # Display the options for the user

    echo " "

    echo " "

    echo "Select an Option in the range 1-3"

    echo " "

    echo "     0. Exit From Program"

    echo "     1. Show Site Statistics"

    echo "     2. Browse Site Articles"

    echo " "

    echo -n "Please enter Option: "

    #read the chosen option

    read option

    if ((option >= 0 && option <= 2)); then

       # display blank line

       echo " "

    else

       # let the user know his value was out of range

       echo " "

       echo "Please enter a Number in the Range 0 to 2"

       echo " "

    fi

    # run the appropriate script based on the user input (or exit if ws entered)

    case $option in

         0) echo "Thank you and Goodbye!"

            echo " "

            exit 0;;

         1) ./Statistics.sh;;

         2) ./WebScrape.sh;;

    esac

    option=0

done

   # should not geet here - exit with error code

exit 1
