#!/bin/bash


# copy the password file to a text file - make sure /etc/password file remains unchanged no matter what

cp /etc/passwd passwd.txt

awk 'BEGIN {

    # Set Field Separator

    FS=":";

    # Print top line of table

    print"________________________________________________________________________________________________________";


    # Print Column Headings

    print"| \033[34m     UserName       \033[0m | \033[034m UserID \033[0m | \033[0m \033[034mGroupID\033[0m | \033[034m              Home              \033[0m | \033[034m       Shell        \033[0m |";
}

{

    # Only print line if the bash shell is used

    if ($7 =="/bin/bash")

    {


        # Print fomatted line


        printf("| \033[033m%-20s\033[0m | \033[036m%-8s\033[0m | \033[035m%-8s\033[0m | \033[035m%-32s\033[0m | \033[035m%-20s\033[0m | \n",$1,$3,$4,$6,$7);


    }

}

END {


     #Print bottom line of table

     print"________________________________________________________________________________________________________";


#  User passwd.txt as the source

}' passwd.txt

exit 0
