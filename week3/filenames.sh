#!/bin/bash

input="$1"

echo "$1"

if [ ! -f "$1" ]; then

    echo "The source file does not exist - try again"

    exit 1

fi

while IFS= read -r line

do

    if [ -f "$line" ]; then

        echo "$line" "That file exists"
    else 

        if [ -d "$line" ]; then

            echo "$line" "That directory exists"

        else

            echo " I don't know what that is"

        fi

    fi

done < "$input"

exit 0
