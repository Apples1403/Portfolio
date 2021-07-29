# use the bash shell

#!/bin/bash

# Get the name of the folder to create from the user

read -p "Enter name of new folder: " FldrName

# Get the new password from the user, making sure it is not visible

read -p "Enter password: " SecretPword


# Delete any existing folder 


if [ -d ~/scripts/portfolio/week\ 2/"$FldrName" ]; then


    rm -r ~/scripts/portfolio/week\ 2/"$FldrName"

fi

# Create new folder

mkdir "./$FldrName"

# CD to new folder

cd "$FldrName"

# Store the password in file secret.txt"

echo "$SecretPword" | sha256sum >  secret.txt
