#!/bin/bash

# Display topic of table

echo "Google Server IPs:"

awk 'BEGIN {

    # Set the field separator to ":"    

FS=":";

    # Print the top line of the Table

    print"________________________________";


    # Prin the headings

    print"| \033[34mServer Type\033[0m | \033[034m     IP\033[0m        |";
}

{

    # Print a line of the input file, with formatting

    printf("| \033[33m%-11s\033[0m | \033[35m%-14s\033[0m |\n",$1,$2);

}

END {

    # Print bottom line of the table


    print("________________________________");


}' input.txt

exit 0
